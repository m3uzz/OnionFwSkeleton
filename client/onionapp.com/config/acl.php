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
    'acl' => array(
    	/*
    	'context' => array(
    		//IPs
    		'?.?.?.?' => array( // de qualquer ip
    			'denied' = false,
    			'user-agent' => array(
    				'*' => '' // de qualquer user-agent e sem token
    			)
    		),
    	),
    	*/
        'roles' => array(
            'guest'   => null,
	    'client' => 'guest',
            'admin' => 'client'
        ),
        'resources' => array(
            'allow' => array(
		'Index' => array(
			'index' => 'guest',					
			'message' => 'guest',
		),
            	'Backend' => array(
            		'index' => 'client',
            		'message' => 'guest',
            		'push' => 'guest',
            		'clear-flash' => 'guest',
            	),
		'Access' => array(
			'login' => 'guest',
			'logout' => 'guest',
			'forgotten-password' => 'guest',
			'message' => 'guest',
			'facebook' => 'guest',
		),
           	'LogAccess' => array(
            		'index' => 'admin',
            		'trash' => 'admin',
            		'add' => 'admin',
            		'edit' => 'admin',
            		'view' => 'admin',
            		'move' => 'admin',
            		'delete' => 'admin',
            		'move-list' => 'admin',
            		'delete-list' => 'admin',
            		'search-select' => 'admin',
            		'search' => 'admin',
            		'message' => 'guest',
            	),
            	'LogEvent' => array(
            		'index' => 'admin',
            		'trash' => 'admin',
            		'add' => 'admin',
            		'edit' => 'admin',
            		'view' => 'admin',
            		'move' => 'admin',
            		'delete' => 'admin',
            		'move-list' => 'admin',
            		'delete-list' => 'admin',
            		'search-select' => 'admin',
            		'search' => 'admin',
            		'message' => 'guest',
            	),
            	'Registration' => array(
            		'index' => 'guest',
            		'message' => 'guest',
            		'add' => 'guest'
            	),
            	'ContactUs' => array(
            		'index' => 'guest',
            		'send' => 'guest'
            	),
            	'Person' => array(
            		'index' => 'admin',
            		'trash' => 'admin',
            		'add' => 'admin',
            		'edit' => 'admin',
            		'view' => 'admin',
            		'move' => 'admin',
            		'delete' => 'admin',
            		'move-list' => 'admin',
            		'delete-list' => 'admin',
            		'search-select' => 'admin',
            		'search' => 'admin',
            		'message' => 'admin',
            		'csv' => 'admin',
            		'pdf' => 'admin'
            	),
            	'User' => array(
            		'index' => 'admin',
            		'trash' => 'admin',
            		'add' => 'admin',
            		'edit' => 'admin',
            		'view' => 'admin',
            		'move' => 'admin',
            		'delete' => 'admin',
            		'move-list' => 'admin',
            		'delete-list' => 'admin',
            		'search-select' => 'admin',
            		'search' => 'admin',
            		'message' => 'admin',
            		'csv' => 'admin',
            		'pdf' => 'admin',
            		'generate-password' => 'guest',
            		'change-password' => 'client',
            		'change-phone-extension' => 'admin',
            	),
            	'UserGroup' => array(
            		'index' => 'admin',
            		'trash' => 'admin',
            		'add' => 'admin',
            		'edit' => 'admin',
            		'view' => 'admin',
            		'move' => 'admin',
            		'delete' => 'admin',
            		'move-list' => 'admin',
            		'delete-list' => 'admin',
            		'search-select' => 'admin',
            		'search' => 'admin',
            		'message' => 'admin',
            		'csv' => 'admin',
            		'pdf' => 'admin'
            	),
            	'Frontend' => array(
            		'index' => 'guest',
            		'trash' => 'guest',
            		'add' => 'guest',
            		'edit' => 'guest',
            		'view' => 'guest',
            		'move' => 'guest',
            		'delete' => 'guest',
            		'move-list' => 'guest',
            		'delete-list' => 'guest',
            		'search-select' => 'guest',
            		'search' => 'guest',
            		'message' => 'guest',
            		'csv' => 'guest',
            	),
            )
        )
    )
);
