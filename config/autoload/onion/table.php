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
	'coreCategory' => array(
		'stResource' => array(
			'options' => array(
				'category'	=> 'Categorias',
				'company' 	=> 'Empresas',
				'file'		=> 'Arquivos',
				'product' 	=> 'Produtos',
				'service' 	=> 'Serviços',
			),
			'default' => 'company',
		),
		'numStatus' => array(
			'default' =>  0,
		),
		'isActive' => array(
			'default' =>  1,
		),
	),
	'addrAddress' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'addrAddress_has_addrZipCode' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'addrCity' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'addrCountry' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'addrEstate' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'addrZipCode' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'company' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'company_has_addrAddress' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'company_has_contact' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'company_has_link' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'contact' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'coreGroup' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'coreMenu' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'coreRoute' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'coreSection' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'coreUser' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'coreUser_has_coreGroup' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'file' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'link' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'newsletter' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'person' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'person_has_addrAddress' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'person_has_contact' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'product' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
	'service' => array(
		'numStatus' => array(
			'default' =>  0
		),
		'isActive' => array(
			'default' =>  1
		),
	),
);