<?php
$laOnionOptions = \Onion\Config\Config::getAppOptions();
$laDbParams = $laOnionOptions['db'][$laOnionOptions['environment']];
$lsDriver = 'Doctrine\\DBAL\\Driver\\' . $laDbParams['driver'] . '\\Driver';

return array(	
	'doctrine' => array(
		'connection' => array(
			'orm_default' => array(
				'driverClass' => $lsDriver,
				'params' => array(
					'host'     => $laDbParams['hostname'],
					'port'     => $laDbParams['port'],
					'user'     => $laDbParams['username'],
					'password' => $laDbParams['password'],
					'dbname'   => $laDbParams['database'],
				)
			)
		),
			
		// Configuration details for the ORM.
		// See http://docs.doctrine-project.org/en/latest/reference/configuration.html
		'configuration' => array(
			// Configuration for service `doctrine.configuration.orm_default` service
			'orm_default' => array(
				// metadata cache instance to use. The retrieved service name will
				// be `doctrine.cache.$thisSetting`
				//'metadata_cache'    => 'array',
			
				// DQL queries parsing cache instance to use. The retrieved service
				// name will be `doctrine.cache.$thisSetting`
				//'query_cache'       => 'array',
			
				// ResultSet cache to use.  The retrieved service name will be
				// `doctrine.cache.$thisSetting`
				//'result_cache'      => 'array',
			
				// Mapping driver instance to use. Change this only if you don't want
				// to use the default chained driver. The retrieved service name will
				// be `doctrine.driver.$thisSetting`
				//'driver'            => 'orm_default',
			
				// Generate proxies automatically (turn off for production)
				'generate_proxies'  => true,
			
				// directory where proxies will be stored. By default, this is in
				// the `data` directory of your application
				'proxy_dir'         => CLIENT_DIR . '/data/DoctrineORMModule/Proxy',
			
				// namespace for generated proxy classes
				'proxy_namespace'   => 'DoctrineORMModule\Proxy',
			
				// SQL filters. See http://docs.doctrine-project.org/en/latest/reference/filters.html
				//'filters'           => array()
				
				'datetime_functions' => array(
					'DATE_FORMAT'  => 'Onion\ORM\Query\DateFormat',
					'CONCAT_WS'  => 'Onion\ORM\Query\ConcatWs',
					'UNIX_TIMESTAMP'  => 'Onion\ORM\Query\UnixTimestamp',
					'MATCH_AGAINST'  => 'Onion\ORM\Query\MatchAgainst',
				),
			)
		),			
	),
);
