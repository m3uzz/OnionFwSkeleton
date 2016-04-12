<?php
/**
 * Global Configuration Override
 *
 * You can use this file for overriding configuration values from modules, etc.
 * You would place values in here that are agnostic to the environment and not
 * sensitive to security.
 *
 * @NOTE: In practice, this file will typically be INCLUDED in your source
 * control, so do not include passwords or other sensitive information in this
 * file.
 */

$laOnionOptions = \Onion\Config\Config::getAppOptions();
$laDbParams = $laOnionOptions['db'][$laOnionOptions['environment']];
$laModuleLayouts = $laOnionOptions['layout']['module_layouts'];

return array(
	'module_layouts' => $laModuleLayouts,	
	'service_manager' => array(
		'factories' => array(
			'Zend\Db\Adapter\Adapter' => function ($sm) use ($laDbParams) {
				$adapter = new BjyProfiler\Db\Adapter\ProfilingAdapter(array(
					'driver'    => $laDbParams['driver'],
					'dsn'       => 'mysql:dbname='.$laDbParams['database'].';host='.$laDbParams['hostname'],
					'database'  => $laDbParams['database'],
					'username'  => $laDbParams['username'],
					'password'  => $laDbParams['password'],
					'hostname'  => $laDbParams['hostname'],
				));

				if (php_sapi_name() == 'cli') 
				{
					$logger = new Zend\Log\Logger();
					// write queries profiling info to stdout in CLI mode
					$writer = new Zend\Log\Writer\Stream(CLIENT_DIR . DS . 'data' . DS . 'logs' . DS .'db.log');
					$logger->addWriter($writer, Zend\Log\Logger::DEBUG);
					$adapter->setProfiler(new BjyProfiler\Db\Profiler\LoggingProfiler($logger));
				} 
				else 
				{
					$adapter->setProfiler(new BjyProfiler\Db\Profiler\Profiler());
				}
				
				if (isset($dbParams['options']) && is_array($dbParams['options'])) 
				{
					$options = $dbParams['options'];
				} 
				else 
				{
					$options = array();
				}
				
				$adapter->injectProfilingStatementPrototype($options);
				
				return $adapter;
			},
		),
	),
);