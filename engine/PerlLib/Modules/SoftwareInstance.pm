#!/usr/bin/perl

=head1 NAME

 Modules::SoftwareInstance - i-MSCP Plugin module

=cut

# i-MSCP - internet Multi Server Control Panel
# Copyright (C) 2010-2014 by internet Multi Server Control Panel
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
#
# @category    i-MSCP
# @copyright   2010-2014 by i-MSCP | http://i-mscp.net
# @author      Laurent Declercq <l.declercq@nuxwin.com>
# @link        http://i-mscp.net i-MSCP Home Site
# @license     http://www.gnu.org/licenses/gpl-2.0.html GPL v2

package Modules::SoftwareInstances;

use strict;
use warnings;

use iMSCP::Debug;
use iMSCP::Database;
use iMSCP::Dir;
use iMSCP::Execute;
use iMSCP::Rights;
use File::Temp;

use parent 'Common::SimpleClass';

=head1 DESCRIPTION

 This module is responsible to install/uninstall a software instance.

=head1 PUBLIC METHODS

=over 4

=item process()

 Process software instance

 Return int 0 on success, other on failure

=cut

sub process
{
	my $self = $_[0];

	$self->{'software_id'} = $_[1];

	my $rs = $self->loadData();
	return $rs if $rs;

	my @sql;

	if($self->{'software_status'} eq 'toadd') {
		$rs = $self->_install();
		@sql = (
			'UPDATE web_software_inst SET software_status = ? WHERE software_id = ?',
			($rs ? scalar getMessageByType('error') : 'ok'),
			$self->{'software_id'}
		);
	} elsif($self->{'software_status'} eq 'todelete') {
		$rs = $self->_uninstall();

		if($rs) {
			@sql = (
				'UPDATE web_software_inst SET software_status = ? WHERE software_id = ?',
				scalar getMessageByType('error'),
				$self->{'software_id'}
			);
		} else {
			@sql = ('DELETE FROM web_software_inst WHERE software_id = ?', $self->{'software_id'});
		}
	} else {
		error("Software instance with ID $self->{'software_id'} has an inconsistent status: $self->{'software_status'}");
		return 1;
	}

	my $rdata = $self->{'_db'}->doQuery('dummy', @sql);
	unless(ref $rdata eq 'HASH') {
		error($rdata);
		return 1;
	}

    0;
}

=back

=head1 PRIVATE METHODS

=over 4

=item _init()

 Initialize instance

 Return Modules::SoftwareInstances

=cut

sub _init()
{
	my $self = $_[0];

	$self->{'_db'} = iMSCP::Database->factory();

	$self;
}

=item _loadData()

 Load data

 Return int 0 on success, other on failure

=cut

sub _loadData
{
	my $rdata = $self->{'_db'}->doQuery(
		'software_id',
		'
			SELECT
				t1.*, reseller_id, t2.software_db, t2.software_archive, t2.software_installfile, t2.software_depot,
				t2.software_master_id, t3.domain_name, t4.admin_sys_uid, t4.admin_sys_gid
			FROM
				web_software_inst AS t1
			INNER JOIN
				web_software AS t2 USING(software_id)
			INNER JOIN
				domain AS t3 USING(domain_id)
			INNER JOIN
				admin AS t4 ON(t4.admin_id = t3.domain_admin_id)
			WHERE
				software_id = ?
		',
		$self->{'software_id'}
	);
	unless(ref $rdata eq 'HASH') {
		error($rdata);
		return 1;
	} elsif(! exists $rdata->{$self->{'software_id'}}) {
		error("Data for software instance with ID '$self->{'software_id'}' were not found in database");
		return 1;
	}

	# Make data as object properties
	%{$self} = (%{$self}, %{$rdata->{$self->{'software_id'}}});

	# Set domain type
	$self->{'domain_type'} = 'domain';

	# Does the software instance belong to a subdomain, alias or subdomain alias?
	# In such a case, we retrieve the domain name and override the current one
	if(
		(
			$rdata->{$self->{'software_id'}}->{'subdomain_id'} +
			$rdata->{$self->{'software_id'}}->{'alias_id'} +
			$rdata->{$self->{'software_id'}}->{'subdomain_alias_id'}
		) > 0
	) {
		my $rdata2;

		if($rdata->{$self->{'software_id'}}->{'subdomain_id'}) {
			$rdata2 = $self->{'_db'}->doQuery(
				'domain_name',
				'
					SELECT
						CONCAT(subdomain_name, '.', domain_name) AS domain_name
					FROM
						subdomain
					INNER JOIN
						domain USING(domain_id)
					WHERE
						subdomain_id = ?
				',
				$rdata->{$self->{'software_id'}}->{'subdomain_id'}
			);

			# Override domain type
			$self->{'domain_type'} = 'subdomain';
		} elsif($rdata->{$self->{'software_id'}}->{'alias_id'}) {
			$rdata2 = $self->{'_db'}->doQuery(
				'domain_name',
				'
					SELECT
						alias_name AS domain_name
					FROM
						domain_aliasses
					WHERE
						alias_id = ?
				',
				$rdata->{$self->{'software_id'}}->{'subdomain_id'}
			);

			# Override domain type
			$self->{'domain_type'} = 'alias';
		} else {
			$rdata2 = $self->{'_db'}->doQuery(
				'domain_name',
				'
					SELECT
						CONCAT(subdomain_alias_name, '.', alias_name) AS domain_name
					FROM
						subdomain_alias
					INNER JOIN
						domain_aliasses USING(alias_id)
					WHERE
						subdomain_alias_id = ?
				',
				$rdata->{$self->{'software_id'}}->{'subdomain_alias_id'}
			);

			# Override domain type
			$self->{'domain_type'} = 'subdomain_alias';
		}
		unless(ref $rdata2 eq 'HASH') {
			error($rdata2);
			return 1;
		} elsif(!%{$rdata2}) {
			error("Software instance with ID '$self->{'software_id'}' seem to be an orphaned entry");
			return 1;
		}

		# Override domain name
		$self->{'domain_name'} = $rdata2->{'domain_name'}->{'domain_name'};
	}

	0;
}

=item _install()

 Install software instance

 Return int 0 on success, other on failure

=cut

sub _install
{
	my $self = $_[0];

	my $destDir = "$main::cfg{'USER_WEB_DIR'}/$self->{'domain_name'}$self->{'path'}";
	my $rs = 0;

	# Create software instance destination directory if it doesn't already exists
	unless(-d $destDir) {
		$rs = iMSCP::Dir->new('dirname' => $destDir)->make(
			{
				'mode' => 0750,
				'user' => $self->{'admin_sys_uid'},
				'group' => $self->{'admin_sys_gid'}
			}
		);
		return $rs if $rs;
	} else { # Directory cleanup
		my ($stdout, $stderr);
		$rs = execute("$main::imscpConfig{'CMD_RM'} -Rf $destDir/*", \$stdout, \$stderr);
		return $rs if $rs;
	}

	# Creating temporary directory
	my $tmpDir = File::Temp->newdir();
	return $rs if $rs;

	# Change current directory to temporary directory
	my $oldDir = chdir($tmpDir);

	if($self->{'software_depot'} eq 'yes') {
		my $archiveSourcePath = "$main::imscpConfig{'GUI_APS_DEPOT_DIR'}/$self->{'software_archive'}-" .
			"$self->{'software_master_id'}.tar.gz";

		# Copy software archive from software repository into temporary directory
		my ($stdout, $stderr)
		$rs = execute("$main::imscpConfig{'CMD_CP'} $archiveSourcePath .", \$stdout, \$stderr);
		return $rs if $rs;

		# Decompress software archive inside temporary directory
		$rs = execute(
			"$main::imscpConfig{'CMD_TAR'} -xzf $self->{'software_archive'}-$self->{'software_master_id'}.tar.gz",
			\$stdout,
			\$stderr
		);
		return $rs if $rs;
	} else {
		my $archiveSourcePath = "$main::imscpConfig{'GUI_APS_DIR'}/$self->{'reseller_id'}/" .
			"$self->{'software_archive'}-$self->{'software_id'}.tar.gz";

		# Copy software archive into temporary directory
		my ($stdout, $stderr)
		$rs = execute("$main::imscpConfig{'CMD_CP'} $archiveSourcePath .", \$stdout, \$stderr);
		return $rs if $rs;

		# Decompress software archive inside temporary directory
		$rs = execute(
			"$main::imscpConfig{'CMD_TAR'} -xzf $self->{'software_archive'}-$self->{'software_id'}.tar.gz",
			\$stdout,
			\$stderr
		);
		return $rs if $rs;
	}

	# Copy archive content to destdir
	my ($stdout, $stderr)
	$rs = execute("$main::imscpConfig{'CMD_CP'} -R $tmpDir/* $destDir", \$stdout, \$stderr);
	return $rs if $rs;

	# Set permissions
	$rs = setRights(
		$destDir,
		{
			'dirmode' => '0750',
			'filemode' => '0640',
			'user' => $self->{'admin_sys_uid'},
			'group' => $self->{'admin_sys_gid'},
			'recursive' => 1
		}
	);
	return $rs if $rs;

	# Change back to old directory
	chdir($oldDir);

	# Encode software maintenance script arguments
	my $arguments = encode_base64(
		join(
			',',
			(
				'install', $self->{'software_db'}, $self->{'software_prefix'}, $self->{'db'}, $self->{'database_user'},
				$self->{'database_tmp_paswd'}, $self->{'install_username'}, $self->{'install_password'},
				$self->{'install_email'}, $self->{'domain_name'}, $destDir, $self->{'path'}
			)
		)
	);

	# Run software maintenance script (install tasks)
	$rs = execute(
		"$main::imscpConfig{'CMD_PERL'} $self->{'software_installfile'} " . escapeShell($arguments), \$stdout, \$stderr
	);
	return $rs if $rs;

	# Set permissions again
	setRights(
		$destDir,
		{
			'user' => $self->{'admin_sys_uid'},
			'group' => $self->{'admin_sys_gid'},
			'recursive' => 1
		}
	);
}

=item _uninstall()

 Uninstall software instance

 Return int 0 on success, other on failure

=cut

sub _uninstall
{
	my $self = $_[0];

	my $destDir = "$main::cfg{'USER_WEB_DIR'}/$self->{'domain_name'}$self->{'path'}";
	my $rs = 0;

	# Creating temporary directory
	my $tmpDir = File::Temp->newdir();
	return $rs if $rs;

	# Change current directory to temporary directory
	my $oldDir = chdir($tmpDir);

	if($self->{'software_depot'} eq 'yes') {
		my $archiveSourcePath = "$main::imscpConfig{'GUI_APS_DEPOT_DIR'}/$self->{'software_archive'}-" .
			"$self->{'software_master_id'}.tar.gz";

		# Copy software archive from software repository into temporary directory
		my ($stdout, $stderr)
		$rs = execute("$main::imscpConfig{'CMD_CP'} $archiveSourcePath .", \$stdout, \$stderr);
		return $rs if $rs;

		# Decompress software archive inside temporary directory
		$rs = execute(
			"$main::imscpConfig{'CMD_TAR'} -xzf $self->{'software_archive'}-$self->{'software_master_id'}.tar.gz",
			\$stdout,
			\$stderr
		);
		return $rs if $rs;
	} else {
		my $archiveSourcePath = "$main::imscpConfig{'GUI_APS_DIR'}/$self->{'reseller_id'}/" .
			"$self->{'software_archive'}-$self->{'software_id'}.tar.gz";

		# Copy software archive into temporary directory
		my ($stdout, $stderr)
		$rs = execute("$main::imscpConfig{'CMD_CP'} $archiveSourcePath .", \$stdout, \$stderr);
		return $rs if $rs;

		# Decompress software archive inside temporary directory
		$rs = execute(
			"$main::imscpConfig{'CMD_TAR'} -xzf $self->{'software_archive'}-$self->{'software_id'}.tar.gz",
			\$stdout,
			\$stderr
		);
		return $rs if $rs;
	}

	# In old version of software instance manager, the list of directories and files to remove was read from the
	# uninstall.xml file from the software package. Since 1.1.6, we simply flush the content from the software instance
	# directory and we schedule a domain change to force copy of files from the Web skeleton
	my ($stdout, $stderr)
	$rs = execute("$main::imscpConfig{'CMD_RM'} -Rf $destDir/*", \$stdout, \$stderr);
	return $rs if $rs;

	# Encode software maintenance script arguments
	my $arguments = encode_base64(
		join(
			',',
			(
				'uninstall',
				$self->{'software_db'},
				$self->{'software_prefix'},
				$self->{'db'},
				$self->{'database_user'},
				$self->{'database_tmp_paswd'},
				$self->{'install_username'},
				$self->{'install_password'},
				$self->{'install_email'},
				$self->{'domain_name'},
				$destDir,
				$self->{'path'}
			)
		)
	);

	# Run software maintenance script (uninstall tasks)
	$rs = execute(
		"$main::imscpConfig{'CMD_PERL'} $self->{'software_installfile'} " . escapeShell($arguments), \$stdout, \$stderr
	);
	return $rs if $rs;

	# Change back to old directory
	chdir($oldDir);

	my $rdata;

	# Schedule domain, subdomain, alias or subdomain alias change to copy file from skeleton directory and set
	# Web directory permissions
	if($self->{'domain_type'} eq 'domain') {
		$rs = $self->{'_db'}->doQuery(
			'dummy',
			"
				UPDATE
					domain
				SET
					domain_status = 'tochange'
				WHERE
					domain_id = ?
				AND
					domain_status <> 'todelete'
			",
			$self->{'domain_id'}
		);
	} elsif($self->{'domain_type'} eq 'subdomain') {
		$rs = $self->{'_db'}->doQuery(
			'dummy',
			"
				UPDATE
					subdomain
				SET
					subdomain_status = 'tochange'
				WHERE
					subdomain_id = ?
				AND
					subdomain_status <> 'todelete'
			",
			$self->{'subdomain_id'}
		);
	} elsif($self->{'domain_type'} eq 'alias') {
		$rs = $self->{'_db'}->doQuery(
			'dummy',
			"
				UPDATE
					aliasses
				SET
					alias_status = 'tochange'
				WHERE
					alias_id = ?
				AND
					alias_status <> 'todelete'
			",
			$self->{'alias_id'}
		);
	} else {
		$rs = $self->{'_db'}->doQuery(
			'dummy',
			"
				UPDATE
					sudbdomain_alias
				SET
					subdomain_alias_status = 'tochange'
				WHERE
					subdomain_alias_id = ?
				AND
					subdomain_alias_status <> 'todelete'
			",
			$self->{'subdomain_alias_id'}
		);
	}
	unless(ref $rs eq 'HASH') {
		error($rs);
		return 1;
	}

	0;
}

1;
