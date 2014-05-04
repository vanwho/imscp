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

namespace ImscpSettings\Settings;

/**
 * Interface EditableSettingsInterface
 *
 * @package ImscpSettings\Settings
 * @author Laurent Declercq <l.declercq@nuxwin.com>
 */
interface EditableSettingInterface extends SettingInterface
{
    /**
     * Get label
     *
     * @return string
     */
    public function getLabel();

    /**
     * Get setting description
     *
     * @return string
     */
    public function getDescription();

    /**
     * Get input type
     *
     * @return mixed
     */
    public function getInputType();

    /**
     * Is required?
     *
     * @return bool
     */
    public function isRequired();

    /**
     * Set option values
     *
     * @param array $optionValues
     * @return EditableSettingInterface
     */
    public function setOptionValues($optionValues);

    /**
     * Get option values
     *
     * @return array|null
     */
    public function getOptionValues();
}
