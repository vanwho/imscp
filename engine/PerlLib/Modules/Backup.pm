#!/usr/bin/perl

=head1 NAME

 Modules::Backup - i-MSCP backup module

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
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# @category    i-MSCP
# @copyright   2010-2014 by i-MSCP | http://i-mscp.net
# @author      Laurent Declercq <l.declercq@nuxwin.com>
# @link        http://i-mscp.net i-MSCP Home Site
# @license     http://www.gnu.org/licenses/gpl-2.0.html GPL v2

package Modules::Backup;

use strict;
use warnings;

no if $] >= 5.017011, warnings => 'experimental::smartmatch';

use iMSCP::Debug;
use iMSCP::HooksManager;
use iMSCP::Database;
use parent 'Modules::Abstract';

=head1 DESCRIPTION

 This module provide the backend part of the i-MSCP backup manager.

=head1 PUBLIC METHODS

=over 4

=item process()

=cut

sub process($$)
{
	my ($this, taskId) = @_;

	my $rs = 0;

	my $rdata = $this->{'db'}->doQuery('SELECT * FROM jobs WHERE task_id = ?', $taskId);
	unless(ref $rdata eq 'HASH') {
		error($rdata);
		return 1;
	}

	my ($domainId, $domainType) = split '_', $rdata->{'domain_id'};

	if($rdata->{'job_type'} eq 'backup_domain') {
		my $rs = $self->_backupDomainData($domainId, $domainType);
		$rs if $rs;
	} elsif $rdata->{'job_type'} eq 'restore_domain') {
		my $rs = $self->_restoreDomainData($domainId, $domainType);
		$rs if $rs;
	}

	$rdata = $this->{'db'}->doQuery(
		'UPDATE domain SET domain_status = ? WHERE domain_id = ?',
		($rs ? scalar getMessageByType('error') : 'ok'),
		$self->{'task_id'}
	);

	0;
}

=back

=head1 PRIVATE METHODS

=over 4

=item init()

 Called by getInstance(). Initialize instance of this class.

 Return Modules::Backup

=cut

sub _init
{
	my $self = $_[0];

	$self->{'hooksManager'} = iMSCP::HooksManager->getInstance();
	$self->{'db'} = iMSCP::Database->factory();

	# TODO Create backup root (mirror) directory if needed (eg, if mirror is not located on remote server
	# TODO allow per reseller remote server (allow reseller to setup remote server where data will be pushed using rsync)

	$self;
}

=item _backupDomainData($domainId, $domainType)

 Backup data of the given domain

=cut

sub _backupDomainData($$$)
{
	my ($this, $domainId, $domainType) = @_;

	0;
}

=item _restoreDomainData($domainId, $domainType)

 Restore data of the given domain

=cut

sub _restoreDomainData($$$)
{
	my ($this, $domainId, $domainType) = @_;

	0;
}

=item _restoreDomainMetaData

 Restore metadata of the given domain

=cut

sub _restoreDomainMetaData()
{
	0;
}

=item restoreDomainSqlData()

 Restore SQL data of the given domain

=cut

sub restoreDomainSqlData
{
	0;
}

=item _restoreDomainMailData

 Restore mail data of the given domain

=cut

sub _restoreDomainMail()
{
	0;
}

=item _restoreDomainWebData

 Restore Web data of the given domain

=cut

sub _restoreDomainWebData()
{
	0;
}

=back

=head1 AUTHOR

 Laurent Declercq <l.declercq@nuxwin.com>

=cut

1;
