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
use Zend\I18n\Translator\TranslatorAwareInterface;
use Zend\I18n\Translator\TranslatorAwareTrait;

/**
 * Class Adapters
 *
 * @package ImscpUser\Settings\Authentication
 * @author Laurent Declercq <l.declercq@nuxwin.com>
 */
class Adapters implements EditableSettingInterface, TranslatorAwareInterface
{

    use TranslatorAwareTrait;

    /**
     * @var array
     */
    protected $value = [
        'ImscpUser\\Authentication\\Adapter\\Db'
    ];

    /**
     * @var array
     */
    protected $optionsValues = [
        'ImscpUser\\Authentication\\Adapter\\Db'
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
        return $this->getTranslator()->translate("Authentication adapters");
    }

    /**
     * {@inheritdoc}
     */
    public function getDescription()
    {
        return $this->getTranslator()->translate('Authentication adapters which you want enable');
    }

    /**
     * {@inheritdoc}
     */
    public function getInputType()
    {
        return 'multiselect';
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
        $this->optionsValues = $optionsValues;

        return $this;
    }

    /**
     * {@inheritdoc}
     */
    public function getOptionValues()
    {
        return $this->optionsValues;
    }

    /**
     * {@inheritdoc}
     */
    public function getLevel()
    {
        return 'admin';
    }
}
