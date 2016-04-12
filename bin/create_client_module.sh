#!/bin/bash

#uso: ./create_client_module.sh NomeModulo nome-modulo client-folder

if [ "$1" ] && [ "$2" ] && [ "$3" ]; then
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
	 *
	 * @category   PHP
	 * @package    Onion
	 * @author     Humberto Lourenço <betto@m3uzz.com>
	 * @copyright  2014-"`date '+%Y'`" Humberto Lourenço <betto@m3uzz.com>
	 * @license    http://www.opensource.org/licenses/BSD-3-Clause  The BSD 3-Clause License
	 * @link       http://github.com/m3uzz/onionfw
	 */"
	 
	cd ../client/$3/module
	 
	mkdir $1
	cd $1
	echo "<?php
	$licence

	namespace "$1";

	class Module
	{
		/**
		 *
		 */
	    public function getConfig ()
	    {
	        return include __DIR__ . '/config/module.config.php';
	    }


		/**
		 *
		 */
	    public function getAutoloaderConfig ()
	    {
	        return array(
	            'Zend\\Loader\\StandardAutoloader' => array(
	                'namespaces' => array(
	                    __NAMESPACE__ => __DIR__ . '/src/' . __NAMESPACE__,
	                ),
	            ),
	        );
	    }
	}
	" > Module.php

	mkdir config
	cd config
	echo "<?php
	$licence

	return array(
	    'controllers' => array(
	        'invokables' => array(
	            '"$1"\\Controller\\"$1"' => '"$1"\\Controller\\"$1"Controller',
	        ),
	    ),
	    'router' => array(
	        'routes' => array(
	            '"$2"' => array(
	                'type'    => 'segment', // 'Literal',
	                'options' => array(
	                    // Change this to something specific to your module
	                    'route'    => '/"$2"[/:action][/:id][/]',
	                	'constraints' => array(
	                		'action' => '[a-zA-Z][a-zA-Z0-9_-]*',
	                		'id'     => '[0-9]+',
	                	),                		
	                    'defaults' => array(
	                        // Change this value to reflect the namespace in which
	                        // the controllers for your module are found
	                        '__NAMESPACE__' => '"$1"\\Controller',
	                        'controller'    => '"$1"',
	                        'action'        => 'index',
	                    ),
	                ),
	            ),
	        ),
	    ),    
		'view_manager' => array(
			'template_path_stack' => array(
				'"$2"' => __DIR__ . '/../view',
			),
		),
		'doctrine' => array(
			'driver' => array(
				'"$2"_entities' => array(
					'class' => 'Doctrine\\ORM\\Mapping\\Driver\\AnnotationDriver',
					'cache' => 'array',
					'paths' => array(
						__DIR__ . '/../src/"$1"/Entity'
					)
				),
				
				'orm_default' => array(
					'drivers' => array(
						'"$1"\\Entity' => '"$2"_entities'
					)
				)
			)
		)
	);
	" > module.config.php
	cd ..

	mkdir src
	cd src
	mkdir $1
	cd $1
	mkdir Controller
	cd Controller
	echo "<?php
	$licence

	namespace "$1"\\Controller;
	use Onion\\Mvc\\Controller\\ControllerAction;
	use Onion\\View\\Model\\ViewModel;
	use Onion\\Log\\Debug;
	use Onion\\I18n\\Translator;
	use Onion\\Paginator\\Pagination;
	use Onion\\Application\\Application;
	use Onion\\Lib\\Search;
	use Onion\\Lib\\String;
	use Onion\\Lib\\UrlRequest;
	use Onion\\Export\\Pdf;
	use Onion\\Config\\Config;

	class "$1"Controller extends ControllerAction
	{

		/**
		 *
		 */
		public function __construct ()
		{
			\$this->_sTable = '"$1"';
		
			\$this->_sModule = '"$1"';
		
			\$this->_sRoute = '"$2"';
			
			\$this->_sWindowType = 'default';
		
			\$this->_sResponse = 'html';
		
			\$this->_sEntity = '"$1"\\Entity\\"$1"Basic';
		
			\$this->_sEntityExtended = '"$1"\\Entity\\"$1"Extended';
		
			\$this->_sForm = '"$1"\\Form\\"$1"Form';
		
			\$this->_sTitleS = Translator::i18n('"$1"');
		
			\$this->_sTitleP = Translator::i18n('"$1"');
		
			\$this->_aSearchFields = array(
				'a.id'=>Translator::i18n('Id')
			);
		
			\$this->_sSearchFieldDefault = 'a.id';
		
			\$this->_sGridOrderCol = 'id';
			
			\$this->_sGridOrder = 'ASC';
			
			\$this->_aGridCols = array(
				'id'=>Translator::i18n('Id'), 
				Translator::i18n('Cadastro')
			);
			
			\$this->_aGridAlign = array();
			
			\$this->_aGridWidth = array();
			
			\$this->_aGridColor = array();
			
			\$this->_aGridFields = array(
				'id', 'dtInsert'
			);
			
			\$this->_nGridNumRows = 30;
			
			\$this->_bSearch = true;
			
			\$this->_aSearchGridCols = array(
				'id'=>Translator::i18n('Id')
			);
			
			\$this->_aSearchGridAlign = array();
			
			\$this->_aSearchGridWidth = array();
			
			\$this->_aSearchGridColor = array(
				'', 
				'#f6f6f6'
			);		
			
			\$this->_aSearchGridFields = array(
				'id'
			);
			
			\$this->_sSearchLabelField = 'id';
			
			\$this->_nSearchGridNumRows = 6;	
		}
	}
	" > $1'Controller.php'
	cd ..

	mkdir Entity
	cd Entity
	echo "<?php
	$licence

	namespace "$1"\\Entity;
	use Doctrine\\ORM\\Mapping as ORM;
	use Onion\\Entity\\Entity;
	use Onion\\Lib\\String;
	use Onion\\Log\\Debug;

	/** 
	 * ORM\\Entity
	 * ORM\\Table(name=\""$1"\")
	 * ORM\\Entity(repositoryClass=\""$1"\\Entity\\"$1"Repository\") 
	 */
	abstract class "$1" extends Entity
	{
		protected \$_sEntity = '"$1"\\Entity\\"$1"';
		
		/**
		 * @ORM\\Id
		 * @ORM\\GeneratedValue(strategy=\"AUTO\")
		 * @ORM\\Column(type=\"integer\")
		 */
		protected \$id;
		
		/** 
		 * @ORM\\Column(type=\"integer\") 
		 * @ORM\\Column(nullable=true)
		 */
		protected \$User_id;
		

		/** 
		 * @ORM\\Column(type=\"datetime\") 
		 * @ORM\\Column(nullable=true)
		 */
		protected \$dtInsert;
		
		/** 
		 * @ORM\\Column(type=\"datetime\") 
		 * @ORM\\Column(nullable=true)
		 */
		protected \$dtUpdate;
		
		/** 
		 * @ORM\\Column(type=\"integer\") 
		 * @ORM\\Column(nullable=true)
		 */
		protected \$numStatus = 0;
		
		/** 
		 * @ORM\\Column(type=\"boolean\") 
		 * @ORM\\Column(nullable=true)
		 */
		protected \$isActive = 1;


		/**
		 *
		 */
		public function get (\$psProperty)
		{
			if (property_exists(\$this, \$psProperty))
			{
				switch (\$psProperty)
				{
					case 'dtInsert':
					case 'dtUpdate':
						return String::getDateTimeFormat(\$this->\$psProperty, 1);
						break;
					default:
						return \$this->\$psProperty;
				}
			}
		}
		
		
		/**
		 *
		 */	
		public function getObject ()
		{
			return \$this;
		}	
		
		
		/**
		 *
		 */	
		public function getFormatedData ()
		{
			\$laData['id'] = \$this->id;
			\$laData['dtInsert'] = String::getDateTimeFormat(\$this->dtInsert, 1);
			\$laData['dtUpdate'] = String::getDateTimeFormat(\$this->dtUpdate, 1);
			\$laData['numStatus'] = \$this->numStatus;
			\$laData['isActive'] = \$this->isActive;		
			
			return \$laData;
		}
	}
	" > $1'.php'

	echo "<?php
	$licence

	namespace "$1"\\Entity;
	use Doctrine\\ORM\\Mapping as ORM;
	use Onion\\Lib\\String;
	use Onion\\Log\\Debug;

	/** 
	 * @ORM\\Entity
	 * @ORM\\Table(name=\""$1"\")
	 * @ORM\\Entity(repositoryClass=\""$1"\\Entity\\"$1"Repository\") 
	 */
	class "$1"Basic extends "$1" 
	{
		protected \$_sEntity = '"$1"\\Entity\\"$1"Basic';
	}
	" > $1'Basic.php'

	echo "<?php
	$licence

	namespace "$1"\\Entity;
	use Doctrine\\ORM\\Mapping as ORM;

	/** 
	 * @ORM\\Entity
	 * @ORM\\Table(name=\"$1\")
	 * @ORM\\Entity(repositoryClass=\""$1"\\Entity\\"$1"Repository\")
	 */
	class "$1"Extended extends "$1" 
	{
		protected \$_sEntity = '"$1"\\Entity\\"$1"Extended';
	}
	" > $1'Extended.php'

	echo "<?php
	$licence

	namespace "$1"\\Entity;
	use Onion\\ORM\\EntityRepositoryORM;

	class "$1"Repository extends EntityRepositoryORM
	{
		
	}
	" > $1'Repository.php'
	cd ..

	mkdir Form
	cd Form
	echo "<?php
	$licence

	namespace "$1"\\Form;
	use Onion\\Form\\Form;
	use Onion\\Form\\Element\\Csrf;
	use Onion\\Log\\Debug;
	use Onion\\Lib\\String;
	use Onion\\I18n\\Translator;
	use Onion\\InputFilter\\InputFilter;
	use Onion\\InputFilter\\Factory as InputFactory;

	class "$1"Form extends Form
	{

		/**
		 *
		 */
		public function __construct ()
		{
			\$this->_sModule = '"$1"';
		
			\$this->_sForm = '"$1"';

			\$this->_sWindowType = 'default';
			
			\$this->_sRequestType = 'post';
			
			\$this->_sResponseType = 'html';
			
			\$this->_sCancelBtnType = 'cancel';
			
			// we want to ignore the name passed
			parent::__construct(\$this->_sForm);
		}


		/**
		 *
		 */
		public function setForm ()
		{
			\$this->setAttribute('method', 'post');
			\$this->setAttribute('role', 'form');

			\$lbRequired = true;
			\$lbReadOnly = false;
			
			if (\$this->_sActionType == 'edit')
			{
				\$lbRequired = false;
				\$lbReadOnly = true;
			}
			
			\$this->add(array(
				'name' => 'id',
				'attributes' => array(
					'type' => 'hidden'
				)
			));
			
			
			\$this->add(new Csrf('security'));
			
			\$this->add(
				array(
					'name' => 'submit',
					'attributes' => array(
						'type' => 'submit',
						'value' => Translator::i18n('Salvar'),
						'id' => 'submitbutton',
						'class' => 'btn btn-primary'
					)
				));
			
			// Load and set the client specific configuration for this form
			\$this->clientSets();
		}


		/**
		 *
		 */
		public function getInputFilter ()
		{
			\$loInputFilter = new InputFilter();
			\$loInputFilter->setForm(\$this);
			
			\$loFactory = new InputFactory();
			
			\$loInputFilter->add(
				\$loFactory->createInput(array(
					'name' => 'id',
					'required' => true,
					'filters' => array(
						array(
							'name' => 'Int'
						)
					)
				)));
			
			\$loInputFilter->add(
				\$loFactory->createInput(array(
					'name' => 'User_id',
					'required' => false,
					'filters' => array(
						array(
							'name' => 'Int'
						)
					)
				)));
			
			
			return \$loInputFilter;
		}


		/**
		 *
		 */
		public function isValid ()
		{
			return parent::isValid();
		}
	}
	" > $1'Form.php'
	cd ..

	cd ..
	cd ..
	mkdir view
	cd view
	mkdir $2
	cd $2
	mkdir $2
	cd $2
	echo "<?php
	$licence

	\$loForm->message($this);
	" > message.phtml

	echo "<?php
	$licence

	\$loForm->addForm(\$this, \$lsRoute, \$lsTitleS, \$lsBack);
	" > add.phtml

	echo "<?php
	$licence

	\$loForm->editForm(\$this, \$lnId, \$lsRoute, \$lsTitleS, \$lsBack);
	" > edit.phtml

	echo "<?php
	$licence

	\$this->headTitle(\$lsTitleP . \$lsFolder);
	echo '<h1>' . \$this->escapeHtml(\$lsTitleP . \$lsFolder) . '</h1>';

	echo \$lsGrid;
	" > index.phtml

	echo "<?php
	$licence

	\$this->headTitle(\$lsTitleP . \$lsFolder);
	echo '<h1>' . \$this->escapeHtml(\$lsTitleP . \$lsFolder) . '</h1>';

	echo \$lsGrid;
	" > trash.phtml

	echo "<?php
	$licence

	\$this->headTitle(\$lsTitle);
	echo \$lsView;
	" > view.phtml
else
	echo -e "\n\E[31mERROR: Params not found\E[0m";
	echo -e "\E[3;31mUsage: $ ./create_client_module.sh ModuleName module-name client-folder\E[0m\n\n"
fi
