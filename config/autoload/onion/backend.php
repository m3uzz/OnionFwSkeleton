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
	'meta' => array(
		'admLogo' 			=> '',
		'admCSS' 			=> '',
		'doctype' 			=> 'XHTML1_RDFA',
		'viewport' 			=> 'width=device-width, initial-scale=1',
		'siteTitle' 		=> 'NOT SETTED',
		'titleSeparator'	=> ' - ',
		'pageTitle' 		=> 'Área Administrativa',
		'charset' 			=> 'UTF-8',
		'lang' 				=> 'pt',
		'locale' 			=> 'pt_BR',
		'pragma' 			=> 'no-cache', // no-cache ou public,
		'sysName'			=> ''
	),
	'moduleConf' => array(
		'upload' => array(
			'imgSize' 		=> array(
				'thumb' 	=> '80x60',
				'small' 	=> '320x240',
				'medium' 	=> '640x480',
				'logo' 		=> '320x240',
				'wide' 		=> '728x300',
			),
			'image' => array(
				'stretch' 	=> true,
				'border' 	=> true,
				'bgColor' 	=> '255,255,255',
				'imgdefault'=> '',
			),
		),
		'file' => array(
			'AllowExt' 		=> 'pdf,doc,docx,odt,xls,xlsx,ods,ppt,pptx,odp,txt,csv,xml,jpg,png,gif,mp3',
			'MaxFileSize' 	=> 3072,
		),
		'banner' => array(	
			'AllowExt' 		=> 'jpg,png,gif',
			'MaxFileSize' 	=> 1024,
		),
		'gallery' => array(
			'AllowExt' 		=> 'png,jpg',
			'MaxFileSize' 	=> 3072,
		),
	),
);