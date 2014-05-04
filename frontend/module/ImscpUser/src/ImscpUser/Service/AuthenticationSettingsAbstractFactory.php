<?php
/**
 * i-MSCP - internet Multi Server Control Panel
 * Copyright (C) 2014 Laurent Declercq <l.declercq@nuxwin.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */

namespace ImscpUser\Service;

use Zend\I18n\Translator\TranslatorAwareInterface;
use Zend\ServiceManager\AbstractFactoryInterface;
use Zend\ServiceManager\ServiceLocatorInterface;

/**
 * Class AuthenticationSettingsAbstractFactory
 *
 * @package ImscpUser\Service
 * @author  Laurent Declercq <l.declercq@nuxwin.com>
 */
class AuthenticationSettingsAbstractFactory implements AbstractFactoryInterface
{
    /**
     * @var array
     */
    protected $serviceClasses = [
        'ImscpUser\\Settings\\Authentication\\Adapters',
        'ImscpUser\\Settings\\Authentication\\AllowedLoginState',
        'ImscpUser\\Settings\\Authentication\\IdentityFields',
        'ImscpUser\\Settings\\Authentication\\PasswordCost',
        'ImscpUser\\Settings\\Authentication\\UserState'
    ];

    /**
     * {@inheritDoc}
     */
    public function canCreateServiceWithName(ServiceLocatorInterface $serviceLocator, $name, $requestedName)
    {
        if (in_array($requestedName, $this->serviceClasses)) {
            return true;
        }

        return false;
    }

    /**
     * {@inheritDoc}
     */
    public function createServiceWithName(ServiceLocatorInterface $serviceLocator, $name, $requestedName)
    {
        $service = new $requestedName();

        if ($service instanceof TranslatorAwareInterface) {
            $translator = $serviceLocator->get('translator');
            $service->setTranslator($translator);
        }

        return $service;
    }
}
