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

use Doctrine\ORM\Mapping as ORM;

/**
 * Class Setting
 *
 * @package ImscpSettings\Entity
 * @ORM\Entity
 * @ORM\Table(name="settings")
 */
class Setting implements SettingInterface
{
    /**
     * @ORM\Id
     * @ORM\Column(type="string")
     * @var string
     */
    protected $name;

    /**
     * @ORM\Id
     * @ORM\ManyToOne(targetEntity="ImscpUser\Entity\User", inversedBy="settings")
     * @ORM\JoinColumn(name="owner_id", referencedColumnName="id", onDelete="CASCADE")
     * @var int|null
     */
    protected $owner;

    /**
     * @ORM\Id @ORM\Column(name="group_name", type="string")
     * @var string
     */
    protected $group;

    /**
     * @ORM\Column(type="text")
     * @var mixed
     */
    protected $value;

    public function __construct($name, $owner, $group)
    {
        $this->name = $name;
        $this->owner = $owner;
        $this->group = $group;
    }

    /**
     * {@inheritdoc}
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * {@inheritdoc}
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * {@inheritdoc}
     */
    public function setOwner($owner)
    {
        $this->owner = $owner;

        return $this;
    }

    /**
     * {@inheritdoc}
     */
    public function getOwner()
    {
        return $this->owner;
    }

    /**
     * {@inheritdoc}
     */
    public function setGroup($group)
    {
        $this->group = $group;

        return $this;
    }

    /**
     * {@inheritdoc}
     */
    public function getGroup($group)
    {
        return $this->group;
    }

    /**
     * {@inheritdoc}
     */
    public function setValue($value)
    {
        $this->value = $value;

        return $this;
    }

    /**
     * {@inheritdoc}
     */
    public function getValue()
    {
        return $this->value;
    }
}
