#!/bin/bash

#uso: ./create_client.sh client-folder "Client Name"

if [ "$1" ] && [ "$2" ]; then
	licence="/**
	 * This file is part of Onion
	 *
	 * Copyright (c) 2014-"`date '+%Y'`", Humberto Lourenço <betto@m3uzz.com>.
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
	 * \"AS IS\" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
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
	 *"
	 
	 category=" * @category   PHP"
	 
	 package=" * @package    Onion
	 * @author     Humberto Lourenço <betto@m3uzz.com>
	 * @copyright  2014-"`date '+%Y'`" Humberto Lourenço <betto@m3uzz.com>
	 * @license    http://www.opensource.org/licenses/BSD-3-Clause  The BSD 3-Clause License
	 * @link       http://github.com/m3uzz/onionfw
	 */"
	 
	cd ../client
	mkdir $1
	cd $1
	mkdir module
	mkdir data
	cd data
	mkdir cache
	mkdir logs
	mkdir temp
	mkdir uploads
	cd ..

	mkdir config

	mkdir public
	cd public

	echo "# Habilitar o PHP 5.3
	# AddType application/x-httpd-php53 .php

	#SetEnv APPLICATION_ENV \"development\"
	#SetEnv APPLICATION_ENV \"production\"

	SetOutputFilter DEFLATE

	RewriteEngine On
	# The following rule tells Apache that if the requested filename
	# exists, simply serve it.
	RewriteCond %{REQUEST_FILENAME} -s [OR]
	RewriteCond %{REQUEST_FILENAME} -l [OR]
	RewriteCond %{REQUEST_FILENAME} -d
	RewriteRule ^.*\$ - [NC,L]
	# The following rewrites all other queries to index.php. The 
	# condition ensures that if you are using Apache aliases to do
	# mass virtual hosting, the base path will be prepended to 
	# allow proper resolution of the index.php file; it will work
	# in non-aliased environments as well, providing a safe, one-size 
	# fits all solution.
	RewriteCond %{REQUEST_URI}::$1 ^(/.+)(.+)::\\2\$
	RewriteRule ^(.*) - [E=BASE:%1]
	RewriteRule ^(.*)\$ %{ENV:BASE}index.php [NC,L]
	" > .htaccess

	echo "<?php
	$licence
	$category
	$package

	/**
	 * This makes our life easier when dealing with paths. Everything is relative
	 * to the application root now.
	 */
	defined('CLIENT_DIR') || define('CLIENT_DIR', realpath(dirname(__DIR__)));
	defined('BASE_DIR') || define('BASE_DIR', realpath(dirname(dirname(dirname(__DIR__)))));
	chdir(BASE_DIR);

	require 'onionInit.php';
	" > index.php

	echo "User-agent: *
	Disallow: /access/
	Disallow: /css/
	Disallow: /js/
	Disallow: /img/
	Disallow: /fonts/
	Disallow: /assets/
	Disallow: /backend/" > robots.txt

	echo "<?xml version="1.0" encoding="UTF-8"?>
	<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
	<url>
		<loc></loc>
		<lastmod></lastmod>
		<changefreq></changefreq>
		<priority></priority>
	</url>
	</urlset>" > sitemap.xml

	mkdir fonts
	mkdir img

	mkdir css
	cd css
	category=" * @category   CSS"
	echo "$licence
	$category
	$package
	" > backend.css
	echo "$licence
	$category
	$package
	" > frontend.css
	cd ..

	mkdir js
	cd js
	category=" * @category   Java Script"
	echo "$licence
	$category
	$package
	" > backend.js
	echo "$licence
	$category
	$package
	" > frontend.js
	echo "$licence
	$category
	$package
	" > common.js
	cd ..
	cd ..
	cd ..
	cd ..

	./create_client_module.sh Backend backend $1
else
	echo -e "\E[31mERROR: Params not found!\E[0m\n"
	echo -e "\E[3;31mUsage: $ ./create_client.sh client-folder \"Client Name\"\E[0m\n\n"
fi
