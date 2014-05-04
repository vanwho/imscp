<?php

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
        'ImscpUser\\Settings\\Authentication\\UserState',
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
            $translator = $serviceLocator->get('MvcTranslator');
            $service->setTranslator($translator);
        }

        return $service;
    }
}
