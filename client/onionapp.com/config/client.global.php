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
	'enable'		=> true,
	'maintenance'		=> false,
	'environment'		=> APP_ENV,
	'name'			=> 'onion',		//client
	'resource'		=> 'onionapp.com',	//client folder
	'id'			=> '',			//token
	'icon'			=> '/img/favicon.ico',
	'title'			=> 'm3uzz',
	'description'		=> '',
	'keywords'		=> '',
	'help'			=> '',
	'date'			=> '2016-02-24',
	'url' => array(
		'site'		=> 'http://local.onionapp.com',
		'admin'		=> 'http://local.onionapp.com',
		'js' 		=> 'http://local.onionapp.com',
		'css' 		=> 'http://local.onionapp.com',
		'img' 		=> 'http://local.onionapp.com',
		'service' 	=> '',
	),		
	'settings' => array(
		'sessionLifeTime' => 1209600, // 14 days
		'criptPassword'	=> true,
		'staticSalt'	=> 'aFGQ475SDsdfsaf2342',
		'CHMOD'		=> 0755,
		'CHOWN'		=> 'www-data',
		'CHGRP'		=> 'www-data',
		'cacheConfig'	=> false,
		'pushMensage'	=> true,
	),
	'translator' => array(
		'type'		=> 'gettext',
		'locale'	=> 'pt_BR',
		'base_dir'	=> BASE_DIR . DS . 'vendor' . DS . 'onion' . DS . 'onion' . DS . 'language' . DS,
		'pattern'  	=> '%s.mo',
		'datetime'	=> 'America/Sao_Paulo',
		'local'		=> 'br',
	),
	'output' => array(
		'encoding'	=> 'UTF-8',
		'contetType'	=> 'text/html',
	),
		
	'modules'	=> include 'modules.php',
	'plugins' 	=> include 'plugins.php',	
	'admin'		=> include 'backend.php',
	'front'		=> include 'frontend.php',
	'layout'	=> include 'layout.php',
	'hooks' 	=> include 'hooks.php',
	'cache'		=> include 'cache.php',
	'db' 		=> include 'db.php',
	'service'	=> include 'service.php',
	'mail' 		=> include 'mail.php',
	'log' 		=> include 'log.php',
	'status' 	=> include 'status.php',
	'form' 		=> include 'form.php',
	'table'		=> include 'table.php',
	'acl'		=> include 'acl.php',
	'menu'		=> include 'menu.php',
);

