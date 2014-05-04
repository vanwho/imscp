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

namespace ImscpUser\Settings\Authentication;

use ImscpSettings\Settings\EditableSettingInterface;
use Zend\I18n\Translator\TranslatorAwareTrait;
use Zend\Validator\Translator\TranslatorAwareInterface;

/**
 * Class UserState
 *
 * @package ImscpUser\Settings\Authentication
 * @author Laurent Declercq <l.declercq@nuxwin.com>
 */
class UserState implements EditableSettingInterface, TranslatorAwareInterface
{
    use TranslatorAwareTrait;

    /**
     * @var array
     */
    protected $value = 1;

    /**
     * @var array
     */
    protected $optionsValues = [
        1, 0
    ];

    /**
     * {@inheritdoc}
     */
    public function getNamespace()
    {
        return __NAMESPACE__;
    }

    /**
     * {@inheritdoc}
     */
    public function getValue()
    {
        return $this->value;
    }

    /**
     * {@inheritdoc}
     */
    public function getLabel()
    {
        return $this->getTranslator()->translate('Enable user state usage');
    }

    /**
     * {@inheritdoc}
     */
    public function getDescription()
    {
        return $this->getTranslator()->translate("Should user's state be used in the login process?");
    }

    /**
     * {@inheritdoc}
     */
    public function getInputType()
    {
        return 'radio';
    }

    /**
     * {@inheritdoc}
     */
    public function isRequired()
    {
        return true;
    }

    /**
     * {@inheritdoc}
     */
    public function setOptionValues($optionsValues)
    {

    }

    /**
     * {@inheritdoc}
     */
    public function getOptionValues()
    {
        return null;
    }

    /**
     * {@inheritdoc}
     */
    public function getLevel()
    {
        return 'admin';
    }
}
