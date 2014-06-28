#!/usr/bin/perl

=head1 NAME

Package::FrontEnd::Uninstaller - i-MSCP FrontEnd package Uninstaller

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

package Package::FrontEnd::Uninstaller;

use strict;
use warnings;

use iMSCP::Debug;
use parent 'Common::SingletonClass';

=head1 DESCRIPTION

 i-MSCP FrontEnd package uninstaller

=head1 PUBLIC METHODS

=item uninstall()

 Process uninstall tasks

 Return int 0 on success, other on failure

=cut

sub uninstall
{
	my $self = $_[0];

	my $rs = $self->_removeHttpdConfig();
	return $rs if $rs;

	$rs = $self->_removePhpConfig();
	return $rs if $rs;

	$self->_removeInitScript();

	0;
}

=back

=head1 PRIVATE METHODS

=over 4

=item _init()

 Initialize instance

 Return Package::FrontEnd::Installer

=cut

sub _init
{
	my $self = $_[0];

	$self;
}

=item _removeHttpdConfig()

 Remove httpd configuration

 Return int 0 on success, other on failure

=cut

sub _removeHttpdConfig
{
	my $self = $_[0];

	0;
}

=item _removePhpConfig()

 Remove PHP configuration

 Return int 0 on success, other on failure

=cut

sub _removePhpConfig _removeInitScript()
{
	my $self = $_[0];

	0;
}

=item _removeInitScript()

 Remove init script

 Return int 0 on success, other on failure

=cut

sub _removeInitScript
{
	my $self = $_[0];

	0;
}

=back

=head1 AUTHORS

Laurent Declercq <l.declercq@nuxwin.com>

=cut

1;
