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

namespace ImscpSettings\Entity;

/**
 * Interface ParameterInterface
 *
 * @package ImscpSettings\Entity
 */
interface SettingInterface
{
    /**
     * Set parameter name
     *
     * @param string $name
     * @return SettingInterface
     */
    public function setName($name);

    /**
     * Get parameter name
     *
     * @return string
     */
    public function getName();

    /**
     * Set parameter owner
     *
     * @param int|null $owner
     * @return SettingInterface
     */
    public function setOwner($owner);

    /**
     * Get parameter owner
     *
     * @return int|null
     */
    public function getOwner();

    /**
     * Set parameter group
     *
     * @param string $group
     * @return SettingInterface
     */
    public function setGroup($group);

    /**
     * Get parameter group
     *
     * @param $group
     * @return string
     */
    public function getGroup($group);

    /**
     * Set parameter value
     *
     * @param $value
     * @return int
     */
    public function setValue($value);

    /**
     * Get parameter value
     *
     * @return mixed
     */
    public function getValue();
}
