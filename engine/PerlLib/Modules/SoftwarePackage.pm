#!/usr/bin/perl
=head1 NAME

 Modules::SoftwarePackage - i-MSCP Plugin module

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

package Modules::SoftwarePackage;

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

 This module is responsible to install/uninstall software packages.

=head1 PUBLIC METHODS

=over 4

=item process()

 Process software package

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
			'UPDATE web_software SET software_status = ? WHERE software_id = ?',
			($rs ? scalar getMessageByType('error') : 'ok'),
			$self->{'software_id'}
		);
	} else {
		error("Software package with ID $self->{'software_id'} is in an inconsistent status: $self->{'software_status'}");
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

 Return Modules::SoftwarePackage

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
		'software_id', 'SELECT * FROM web_software WHERE software_id = ?', $self->{'software_id'}
	);
	unless(ref $rdata eq 'HASH') {
		error($rdata);
		return 1;
	} elsif(! exists $rdata->{$self->{'software_id'}}) {
		error("Data for software package with ID '$self->{'software_id'}' were not found in database");
		return 1;
	}

	# Make data as object properties
	%{$self} = (%{$self}, %{$rdata->{$self->{'software_id'}}});

	0;
}

=item _install()

 Install software package

 Return int 0 on success, other on failure

=cut

sub _install
{
	my $self = $_[0];

	my $rs = 0;

	# Retrieve available languages from main configuration file
	my @allowedLanguages = split(',', $main::imscpConfig{'SOFTWARE_ALLOWED_LANGUAGE'});

	# Creating temporary directory
	my $tmpDir = File::Temp->newdir();
	return $rs if $rs;

	# Change current directory to temporary directory
	my $oldDir = chdir($tmpDir);

	if($self->{'software_depot'} eq 'yes') {
		my $archiveSourcePath = "$main::imscpConfig{'GUI_APS_DEPOT_DIR'}/$self->{'software_archive'}-" .
			"$self->{'software_id'}.tar.gz";

		# Copy software archive from software repository into temporary directory
		my ($stdout, $stderr)
		$rs = execute("$main::imscpConfig{'CMD_CP'} $archiveSourcePath .", \$stdout, \$stderr);
		return $rs if $rs;

		# Decompress software archive inside temporary directory
		$rs = execute(
			"$main::imscpConfig{'CMD_TAR'} -xzf $self->{'software_archive'}-$self->{'software_archive'}.tar.gz",
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

	# TODO ...

	0;
}
