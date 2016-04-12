<?php
/**
 * This file is part of Onion
 *
 * Copyright (c) 2014-2016, Humberto Lourenço <betto@m3uzz.com>.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *
 *   * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in
 *     the documentation and/or other materials provided with the
 *     distribution.
 *
 *   * Neither the name of Humberto Lourenço nor the names of his
 *     contributors may be used to endorse or promote products derived
 *     from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * @category   PHP
 * @package    Onion
 * @author     Humberto Lourenço <betto@m3uzz.com>
 * @copyright  2014-2016 Humberto Lourenço <betto@m3uzz.com>
 * @license    http://www.opensource.org/licenses/BSD-3-Clause  The BSD 3-Clause License
 * @link       http://github.com/m3uzz/onionfw
 */
 
return array(
	'groups' => array(
		'1' => 'guest',
		'2' => 'admin',
		'3' => 'client',
	),	
	'admin' => array(
		'Home' => array(
			'accesskey' => '',
			'label' => 'Home',
			'link' => 'backend',
			'description' => 'Home (Alt+H)',
			'icon' => 'glyphicon glyphicon-dashboard',
			'submenu' => null,
		),
		'Access' => array(
			'accesskey' => '',
			'label' => 'Access',
			'link' => '',
			'description' => '',
			'icon' => 'glyphicon glyphicon-cog',
			'submenu' => array(
				'Group' => array(
					'accesskey' => '',
					'label' => 'Group',
					'link' => 'user-group',
					'description' => '',
					'icon' => 'glyphicon glyphicon-flag',
					'submenu' => null,
				),
				'User' => array(
					'accesskey' => '',
					'label' => 'User',
					'link' => 'user',
					'description' => '',
					'icon' => 'glyphicon glyphicon-lock',
					'submenu' =>null,
				),
				'Person' => array(
					'accesskey' => '',
					'label' => 'Person',
					'link' => 'person',
					'description' => '',
					'icon' => 'glyphicon glyphicon-user',
					'submenu' => null,
				),
			)
		),
		'Log' => array(
			'accesskey' => '',
			'label' => 'Log',
			'link' => '',
			'description' => '',
			'icon' => 'glyphicon glyphicon-list-alt',
			'submenu' => array(
				'Access' => array(
					'accesskey' => '',
					'label' => 'Access',
					'link' => 'log-access',
					'description' => '',
					'icon' => 'glyphicon glyphicon-log-in',
					'submenu' =>null,
				),
				'Event' => array(
					'accesskey' => '',
					'label' => 'Event',
					'link' => 'log-event',
					'description' => '',
					'icon' => 'glyphicon glyphicon-tag',
					'submenu' => null,
				),
			)
		),
		'ContactUs' => array(
			'accesskey' => '',
			'label' => 'Contact Us',
			'link' => 'contact-us',
			'description' => '',
			'icon' => 'glyphicon glyphicon-envelope',
			'submenu' => null,
		),
	),
	'client' => array(
		'Home' => array(
			'accesskey' => '',
			'label' => 'Home',
			'link' => 'backend',
			'description' => 'Home (Alt+H)',
			'icon' => 'glyphicon glyphicon-dashboard',
			'submenu' => null,
		),
		'Profile' => array(
			'accesskey' => '',
			'label' => 'Profile',
			'link' => 'profile',
			'description' => '',
			'icon' => 'glyphicon glyphicon-user',
			'submenu' => null,
		),
		'ContactUs' => array(
			'accesskey' => '',
			'label' => 'Contact Us',
			'link' => 'contact-us',
			'description' => '',
			'icon' => 'glyphicon glyphicon-envelope',
			'submenu' => null,
		),
	),
	'guest' => array(
		'Login' => array(
			'accesskey' => '',
			'label' => 'Login',
			'link' => 'access',
			'description' => '',
			'icon' => 'glyphicon glyphicon-log-in',
			'submenu' => null,
		),
		'ContactUs' => array(
			'accesskey' => '',
			'label' => 'ContactUs',
			'link' => 'contact-us',
			'description' => '',
			'icon' => 'glyphicon glyphicon-envelope',
			'submenu' => null,
		),
	),
);
