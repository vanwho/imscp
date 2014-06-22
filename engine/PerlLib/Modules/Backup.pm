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

sub process()
{

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

	$self;
}

=item _backupDomainData()

	Backup data of the given domain

=cut

sub _backupDomainData()
{

}

=item _restoreDomainData()

 Restore data of the given domain

=cut

sub _restoreDomainData
{
	Restore data of the given domain
}

=item _restoreDomainMetaData

 Restore metadata of the given domain

=cut

sub _restoreDomainMetaData()
{

}

=item restoreDomainSqlData()

 Restore SQL data of the given domain

=cut

sub restoreDomainSqlData{

}

=item _restoreDomainMailData

 Restore mail data of the given domain

=cut

sub _restoreDomainMail()
{

}

=item _restoreDomainWebData

 Restore Web data of the given domain

=cut

sub _restoreDomainWebData()
{

}

=back

=head1 AUTHOR

 Laurent Declercq <l.declercq@nuxwin.com>

=cut

1;
