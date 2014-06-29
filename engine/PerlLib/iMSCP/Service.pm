#!/usr/bin/perl

=head1 NAME

 iMSCP::Service - Package providing a set of functions for service management

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

package iMSCP::Service;

use strict;
use warnings;

use iMSCP::Debug;
use iMSCP::Execute;
use parent 'Common::SingletonClass';

=head1 DESCRIPTION

 Package providing a set of functions for service management.

=head1 PUBLIC METHODS

=over 4

=item start($serviceName, [$processName = $serviceName])

 Start the given service

 Param string $serviceName Service name
 Param string $processName Process name (default to service name)
 Return int 0 on succcess, 1 on failure

=cut

sub start($$;$)
{
	my ($self, $serviceName, $processName) = @_;
	$processName ||= $serviceName;

	$self->_runCommand("$self->{'service_provider'} $serviceName start");
	$self->status($processName);
}

=item stop($serviceName, [$processName = $serviceName])

 Stop the given service

 Param string $serviceName Service name
 Param string $processName Process name (default to service name)
 Return int 0 on succcess, 1 on failure

=cut

sub stop($$;$)
{
	my ($self, $serviceName, $processName) = @_;
	$processName ||= $serviceName;

	$self->_runCommand("$self->{'service_provider'} $serviceName stop");

	my $loopCount = 1;

	do {
		return 0 if $self->status($processName);
		sleep(1);
		$loopCount++;
	} while($loopCount < 5);

	1;
}

=item restart($serviceName, [$processName = $serviceName])

 Restart the given service

 Param string $serviceName Service name
 Param string $processName Process name (default to service name)
 Return int 0 on succcess, 1 on failure

=cut

sub restart($$;$)
{
	my ($self, $serviceName, $processName) = @_;
	$processName ||= $serviceName;

	$self->_runCommand("$self->{'service_provider'} $serviceName restart");
	$self->status($processName);
}

=item reload($serviceName, [$processName = $serviceName])

 Reload the given service

 Param string $serviceName Service name
 Param string $processName Process name (default to service name)
 Return int 0 on succcess, 1 on failure

=cut

sub reload($$;$)
{
	my ($self, $serviceName, $processName) = @_;
	$processName ||= $serviceName;

	unless($self->status($processName)) { # In case the service is not running, we start it
		$self->_runCommand("$self->{'service_provider'} $serviceName reload");
	} else {
		$self->_runCommand("$self->{'service_provider'} $serviceName start");
	}

	$self->status($processName);
}

=item status($processName)

 Get status of the given service

 Return int 0 if the service is running, 1 if the service is not running

=cut

sub status($$)
{
	my ($self, $processName) = @_;

	$self->_runCommand("$self->{'service_status_provider'} -o -f $processName");
}

=back

=head1 PRIVATE METHODS

=over 4

=item _init()

 Initialize instance

 Return iMSCP::Service

=cut

sub _init
{
	my $self = $_[0];

	$self->{'service_provider'} = $main::imscpConfig{'SERVICE_MNGR'};
	$self->{'service_status_provider'} = $main::imscpConfig{'CMD_PGREP'};

	$self;
}

=item _runCommand($command)

 Run the given command

 Return int 0 on success, 1 on failure

=cut

sub _runCommand($$)
{
	my ($self, $command) = @_;

	my ($stdout, $stderr);
	my $rs = execute($command, \$stdout, \$stderr);
	debug($stdout) if $stdout;
	debug($stderr) if $stderr;
	return 1 if $rs;

	0;
}

=back

=head1 AUTHOR

 Laurent Declercq <l.declercq@nuxwin.com>

=cut

1;
