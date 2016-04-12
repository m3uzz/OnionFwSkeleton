<?php
return array(
	'enable' 			=> false,
	'maintenance' 		=> false,
	'environment'		=> APP_ENV,
	'name'				=> '',	//client
	'resource'			=> '',	//client folder
	'id'				=> '',	//token
	'icon'				=> '',
	'title'				=> '',
	'description'		=> '',
	'keywords'			=> '',
	'help'				=> '',
	'date'				=> '',
	'url' => array(
		'site'			=> '',
		'admin'			=> '',
		'js' 			=> '',
		'css' 			=> '',
		'img' 			=> '',
		'service' 		=> '',
	),		
	'settings' => array(
		'sessionLifeTime' => 1209600, // 14 days
		'criptPassword'	=> true,
		'staticSalt'	=> 'aFGQ475SDsdfsaf2342',
		'CHMOD'			=> 0755,
		'CHOWN'			=> 'www-data',
		'CHGRP'			=> 'www-data',
		'cacheConfig'	=> false,
		'pushMensage'	=> false,
	),
	'translator' => array(
		'type'			=> 'gettext',
		'locale'		=> 'pt_BR',
		'base_dir'		=> BASE_DIR . DS . 'vendor' . DS . 'onion' . DS . 'onion' . DS . 'language',
		'pattern'  		=> '%s.mo',
		'datetime'		=> 'America/Sao_Paulo',
		'local'			=> 'br',
		'dateFormat'	=> 'Y-m-d',
	),
	'output' => array(
		'encoding'		=> 'UTF-8',
		'contetType'	=> 'text/html',
	),
		
	'modules'	=> include 'onion'.DS.'modules.php',
	'plugins' 	=> include 'onion'.DS.'plugins.php',	
	'admin'		=> include 'onion'.DS.'backend.php',	//ok
	'front'		=> include 'onion'.DS.'frontend.php',	//ok
	'layout'	=> include 'onion'.DS.'layout.php',
	'hooks' 	=> include 'onion'.DS.'hooks.php',
	'cache'		=> include 'onion'.DS.'cache.php', 	//ok
	'db' 		=> include 'onion'.DS.'db.php', 		//ok
	'service'	=> include 'onion'.DS.'service.php', //ok
	'mail' 		=> include 'onion'.DS.'mail.php', 		//ok
	'log' 		=> include 'onion'.DS.'log.php', 		//ok
	'status' 	=> include 'onion'.DS.'status.php', 	//ok
	'form' 		=> include 'onion'.DS.'form.php', 		//ok
	'table'		=> include 'onion'.DS.'table.php', 	//ok
	'acl'		=> include 'onion'.DS.'acl.php',	//ok
	'menu'		=> include 'onion'.DS.'menu.php',
);