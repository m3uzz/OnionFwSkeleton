SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `person` (
  `id` INT UNSIGNED NOT NULL,
  `coreUser_id` INT UNSIGNED NULL COMMENT 'User owner or the user that created this record',
  `stName` VARCHAR(250) NULL COMMENT '- Nome do ser humano',
  `enumGender` ENUM('F','M') NULL COMMENT '- Sexo do ser humano (Genero)',
  `dtBirthdate` DATE NULL DEFAULT NULL COMMENT '- Data de nascimento',
  `stCitizenId` CHAR(20) NULL DEFAULT NULL COMMENT '- Documento de identidade RG',
  `stDoc2` CHAR(14) NULL DEFAULT NULL COMMENT '- Documento de identidade 2 CPF',
  `stPassport` CHAR(10) NULL DEFAULT NULL COMMENT '- Numero de passaporte',
  `stNationality` VARCHAR(100) NULL DEFAULT NULL COMMENT '- Nacionalidade',
  `txtData` TEXT NULL DEFAULT NULL COMMENT 'json with extra data about person',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_person_coreUser1`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Person data ';

CREATE INDEX `idx_person_stName_stCitizenId` ON `person` (`stName` ASC);

CREATE INDEX `idx_person_stDoc2` ON `person` (`stDoc2` ASC);

CREATE INDEX `idx_person_stPassport` ON `person` (`stPassport` ASC);

CREATE INDEX `idx_person_stCitzenId` ON `person` (`stCitizenId` ASC);


-- -----------------------------------------------------
-- Table `coreUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coreUser` (
  `id` INT UNSIGNED NOT NULL,
  `coreUser_id` INT UNSIGNED NULL COMMENT 'User owner or the user that created this user',
  `person_id` INT UNSIGNED NULL COMMENT 'Relationship with on person',
  `coreGroup_id` SMALLINT UNSIGNED NULL COMMENT 'Relashionship with a group that this user is a member',
  `stUsername` VARCHAR(250) NOT NULL COMMENT 'Access login, in usual it is a valid e-mail',
  `stPassword` VARCHAR(250) NOT NULL COMMENT 'Encripted password',
  `txtUserRole` TEXT NULL DEFAULT NULL COMMENT 'The Access Control Level data, ia a json conteining the access rules for this user.',
  `txtUserPref` TEXT NULL DEFAULT NULL COMMENT 'It is a json data that can be used to registre the user pref, as color, template, language, timezone, avatar, social id, photo ...',
  `isSystem` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT 'If 1, it can\'t be deleted',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_coreUser_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `person` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coreUser_coreGroup1`
    FOREIGN KEY (`coreGroup_id`)
    REFERENCES `coreGroup` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coreUser_coreUser1`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Table that make part of system ACL';

CREATE UNIQUE INDEX `idx_coreUser_stUsername_UNIQUE` ON `coreUser` (`stUsername` ASC);


-- -----------------------------------------------------
-- Table `coreGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coreGroup` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT UNSIGNED NULL COMMENT 'group owner or the user that created this group',
  `coreGroup_id` SMALLINT UNSIGNED NULL COMMENT 'Father group',
  `stName` VARCHAR(45) NOT NULL COMMENT 'Group name unique that identify this one',
  `stLabel` VARCHAR(15) NOT NULL COMMENT 'Title that identify the group.',
  `isSystem` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT 'If 1, it can\'t be deleted',
  `txtGroupRole` TEXT NULL DEFAULT NULL COMMENT 'The Access Control Level data, ia a json conteining the access rules for this group.',
  `txtGroupPref` TEXT NULL DEFAULT NULL COMMENT 'it is a json data that can be used to registre the group pref, as color, template, language, timezone, avatar ...',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_coreGroup_coreGroup1`
    FOREIGN KEY (`coreGroup_id`)
    REFERENCES `coreGroup` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coreGroup_coreUser1`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Table that make part of system ACL';

CREATE UNIQUE INDEX `idx_coreGroup_stName_UNIQUE` ON `coreGroup` (`stName` ASC);


-- -----------------------------------------------------
-- Table `addrCountry`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addrCountry` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stCountry` VARCHAR(250) NOT NULL COMMENT '- Nome do país',
  `stAbreviation` VARCHAR(3) NULL DEFAULT NULL COMMENT '- Abreviação do nome do país com 3 letras',
  `stAbreviation2` VARCHAR(2) NULL DEFAULT NULL COMMENT '- Abreviação do nome do país com 2 letras',
  `stTLD` VARCHAR(3) NULL DEFAULT NULL COMMENT '- Código TLD',
  `stLocation` VARCHAR(5) NULL DEFAULT NULL COMMENT '- Código ANSI para a língua, ex.: pt_br',
  `stCurrency` VARCHAR(5) NULL DEFAULT NULL COMMENT '- Simbolo de moeda do país',
  `stCurrencyLabel` VARCHAR(30) NULL DEFAULT NULL COMMENT '- Nome da moeda do país',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_addrCountry_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A data base of countries';

CREATE INDEX `idx_addrCountry_stCountry` ON `addrCountry` (`stCountry` ASC);

CREATE INDEX `idx_addrCountry_stAbreviation` ON `addrCountry` (`stAbreviation` ASC);

CREATE INDEX `idx_addrCountry_stLocation` ON `addrCountry` (`stLocation` ASC);


-- -----------------------------------------------------
-- Table `addrEstate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addrEstate` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `addrCountry_id` INT(10) UNSIGNED NOT NULL COMMENT '- País ao qual o estado pertence',
  `stEstate` VARCHAR(250) NOT NULL COMMENT '- Nome do estado ou província',
  `stAbreviation` VARCHAR(5) NULL DEFAULT NULL COMMENT '- Abreviação do nome da do estado',
  `coreCity_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT ' - Id da capital do estado',
  `stTimeZone` VARCHAR(10) NULL DEFAULT NULL COMMENT '- Time zone padrão GMT',
  `stTimeZone2` VARCHAR(10) NULL DEFAULT NULL COMMENT '- Abreviação do nome da do estado',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`, `addrCountry_id`),
  CONSTRAINT `fk_addrEstate_addrCountry1`
    FOREIGN KEY (`addrCountry_id`)
    REFERENCES `addrCountry` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addrEstate_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A data base of federation estates';

CREATE INDEX `idx_addrEstate_stEstate` ON `addrEstate` (`stEstate` ASC);

CREATE INDEX `idx_addrEstate_stAbreviation` ON `addrEstate` (`stAbreviation` ASC);


-- -----------------------------------------------------
-- Table `addrCity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addrCity` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `addrEstate_id` INT(10) UNSIGNED NOT NULL COMMENT '- Estado ao qual a cidade pertence',
  `stCity` VARCHAR(250) NOT NULL COMMENT '- Nome da cidade',
  `stAbreviation` VARCHAR(5) NULL DEFAULT NULL COMMENT '- Abreviação do nome da cidade',
  `stZipCode` VARCHAR(10) NULL DEFAULT NULL COMMENT '- Código postal da cidade',
  `stLatitude` VARCHAR(10) NULL DEFAULT NULL COMMENT '- Latitude de geo localização',
  `stLongitude` VARCHAR(10) NULL DEFAULT NULL COMMENT '- Longitude de geo localização',
  `stGeoLocalization` VARCHAR(100) NULL DEFAULT NULL COMMENT '- Geo posição x e y para posicionamento em mapa',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`, `addrEstate_id`),
  CONSTRAINT `fk_addrCity_addrEstate1`
    FOREIGN KEY (`addrEstate_id`)
    REFERENCES `addrEstate` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addrCity_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A data base of cities';

CREATE INDEX `idx_addrCity_stCity` ON `addrCity` (`stCity` ASC);

CREATE INDEX `idx_addrCity_stAbreviation` ON `addrCity` (`stAbreviation` ASC);


-- -----------------------------------------------------
-- Table `addrLogradouro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addrLogradouro` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `addrCity_id` INT(10) UNSIGNED NOT NULL COMMENT '- Cidade ao qual o endereço pertence',
  `stType` VARCHAR(10) NOT NULL COMMENT '- Logradouro',
  `stAddress` VARCHAR(250) NOT NULL COMMENT '- Endereço',
  `stNeighborhood` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Bairro',
  `stLatitude` VARCHAR(10) NULL DEFAULT NULL COMMENT '- Latitude de geo localização',
  `stLongitude` VARCHAR(10) NULL DEFAULT NULL COMMENT '- Longitude de geo localização',
  `stZoomMap` VARCHAR(3) NULL DEFAULT NULL COMMENT '- Nível de zoom para visualização de mapa',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`, `addrCity_id`),
  CONSTRAINT `fk_addrLogradouro_addrCity`
    FOREIGN KEY (`addrCity_id`)
    REFERENCES `addrCity` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addrLogradouro_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A data base of streets, avenues e others';

CREATE INDEX `idx_addrLogradouro_stAddress` ON `addrLogradouro` (`stAddress` ASC);

CREATE INDEX `idx_addrLogradouro_stNeighborhood` ON `addrLogradouro` (`stNeighborhood` ASC);


-- -----------------------------------------------------
-- Table `addrZipCode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addrZipCode` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `addrCountry_id` INT(10) UNSIGNED NULL COMMENT '- País ao qual o CEP pertence',
  `addrEstate_id` INT(10) UNSIGNED NULL COMMENT '- Estado ao qual o CEP pertence',
  `addrCity_id` INT(10) UNSIGNED NULL COMMENT '- Cidade ao qual o CEP pertence',
  `stZipCode` VARCHAR(20) NOT NULL COMMENT '- Nome do estado ou província',
  `stRange` VARCHAR(20) NULL DEFAULT NULL COMMENT '- Faixa de número da rua ex: 1000 a 2000',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_addrZipCode_addrCity1`
    FOREIGN KEY (`addrCity_id`)
    REFERENCES `addrCity` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addrZipCode_addrCountry1`
    FOREIGN KEY (`addrCountry_id`)
    REFERENCES `addrCountry` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addrZipCode_addrEstate1`
    FOREIGN KEY (`addrEstate_id`)
    REFERENCES `addrEstate` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A data base of Zip Code';

CREATE UNIQUE INDEX `stZipCode_UNIQUE` ON `addrZipCode` (`stZipCode` ASC);

CREATE INDEX `fk_coreUser_addrZipCode` ON `addrZipCode` (`coreUser_id` ASC);


-- -----------------------------------------------------
-- Table `addrAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addrAddress` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `addrCountry_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '- País ao qual o endereço pertence',
  `addrEstate_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '- Estado ao qual o endereço pertence',
  `addrCity_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '- Cidade ao qual o endereço pertence',
  `addrLogradouro_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '- Rua ao qual o endereço pertence',
  `addrZipCode_id` INT(10) UNSIGNED NULL COMMENT '- CEP ao qual o endereço pertence',
  `stCountry` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Nome do país',
  `stEstate` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Nome do estado',
  `stCity` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Nome da cidade',
  `stNeighborhood` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Bairro',
  `stType` VARCHAR(10) NULL DEFAULT NULL COMMENT '- Tipo de logradouro: rua, avenida, travessa ...',
  `stLogradouro` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Nome do logradouro',
  `stNumber` VARCHAR(10) NULL DEFAULT NULL COMMENT '- Número',
  `stComplement` VARCHAR(50) NULL DEFAULT NULL COMMENT '- Complemento',
  `stZipCode` VARCHAR(15) NULL DEFAULT NULL COMMENT '- CEP',
  `stAddress` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Endereço',
  `stPlace` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Local (ex.: casa, escritório, filial, etc.)',
  `stGeoLocalization` VARCHAR(100) NULL DEFAULT NULL COMMENT '- Geo posição x e y para posicionamento em mapa',
  `stZoomMap` VARCHAR(3) NULL DEFAULT NULL COMMENT '- Nível de zoom para visualização de mapa',
  `enumMasterAddr` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '- Se o endereço é o principal ou não',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_addrAddress_addrCity1`
    FOREIGN KEY (`addrCity_id`)
    REFERENCES `addrCity` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addrAddress_addrCountry`
    FOREIGN KEY (`addrCountry_id`)
    REFERENCES `addrCountry` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addrAddress_addrEstate`
    FOREIGN KEY (`addrEstate_id`)
    REFERENCES `addrEstate` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addrAddress_addrLogradouro`
    FOREIGN KEY (`addrLogradouro_id`)
    REFERENCES `addrLogradouro` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addrAddress_addrZipCode`
    FOREIGN KEY (`addrZipCode_id`)
    REFERENCES `addrZipCode` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addrAddress_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Address or location, it registre a specific place.';

CREATE INDEX `idx_addrAddress_stAddress` ON `addrAddress` (`stAddress` ASC);

CREATE INDEX `idx_addrAddress_stNeigborhood` ON `addrAddress` (`stNeighborhood` ASC);

CREATE INDEX `idx_addrAddress_stNumber` ON `addrAddress` (`stNumber` ASC);

CREATE INDEX `idx_addrAddress_stGeoLocalization` ON `addrAddress` (`stGeoLocalization` ASC);

CREATE INDEX `idx_addrAddress_stCountry` ON `addrAddress` (`stCountry` ASC);

CREATE INDEX `idx_addrAddress_stEstate` ON `addrAddress` (`stEstate` ASC);

CREATE INDEX `idx_addrAddress_stCity` ON `addrAddress` (`stCity` ASC);

CREATE INDEX `idx_addrAddress_stLogradouro` ON `addrAddress` (`stLogradouro` ASC);

CREATE INDEX `idx_addrAddress_stZipCode` ON `addrAddress` (`stZipCode` ASC);

CREATE INDEX `idx_addrAddress_stType` ON `addrAddress` (`stType` ASC);

CREATE INDEX `idx_addrAddress_Place` ON `addrAddress` (`stPlace` ASC);


-- -----------------------------------------------------
-- Table `person_has_addrAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `person_has_addrAddress` (
  `person_id` INT(10) UNSIGNED NOT NULL,
  `addrAddress_id` INT(10) UNSIGNED NOT NULL,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL COMMENT '- Data de Cadastro do registro.',
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '- Data de Alteração',
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`person_id`, `addrAddress_id`),
  CONSTRAINT `fk_person_has_addrAddress_addrAddress1`
    FOREIGN KEY (`addrAddress_id`)
    REFERENCES `addrAddress` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_has_addrAddress_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `person` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_has_addrAddress_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between person and address';

CREATE INDEX `fk_person_has_addrAddress_person1_idx` ON `person_has_addrAddress` (`person_id` ASC);


-- -----------------------------------------------------
-- Table `contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `contact` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `enumType` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0',
  `stLabel` VARCHAR(100) NULL DEFAULT NULL COMMENT '- Ex.: se tipo for telefone o label pode ser, celular, residencial, comercial celular 2 ...',
  `stValue` VARCHAR(250) NULL COMMENT '- valor referente ao tipo',
  `stPerson` VARCHAR(250) NULL COMMENT '- Nome da pessoa',
  `enumMasterContact` ENUM('0','1') NULL DEFAULT '0' COMMENT '- Se o contato é o principal ou não',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_contact_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Table contatos.';

CREATE INDEX `idx_contact_enumType` ON `contact` (`enumType` ASC);

CREATE INDEX `idx_contact_stLabel` ON `contact` (`stLabel` ASC);

CREATE INDEX `idx_contact_stValue` ON `contact` (`stValue` ASC);


-- -----------------------------------------------------
-- Table `person_has_contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `person_has_contact` (
  `person_id` INT UNSIGNED NOT NULL,
  `contact_id` INT UNSIGNED NOT NULL,
  `coreUser_id` INT UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`person_id`, `contact_id`),
  CONSTRAINT `fk_person_has_contact_contact1`
    FOREIGN KEY (`contact_id`)
    REFERENCES `contact` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_has_contact_person1`
    FOREIGN KEY (`person_id`)
    REFERENCES `person` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_has_contact_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between person and contacts';

CREATE INDEX `fk_person_has_contact_person1_idx` ON `person_has_contact` (`person_id` ASC);


-- -----------------------------------------------------
-- Table `coreUser_has_coreGroup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coreUser_has_coreGroup` (
  `coreUser_id` INT UNSIGNED NOT NULL,
  `coreGroup_id` SMALLINT(5) UNSIGNED NOT NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`coreUser_id`, `coreGroup_id`),
  CONSTRAINT `fk_coreUser_has_coreGroup_coreGroup1`
    FOREIGN KEY (`coreGroup_id`)
    REFERENCES `coreGroup` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coreUser_has_coreGroup_coreUser1`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between user and group. Each user can join to m' /* comment truncated */ /*ore than one group*/;

CREATE INDEX `fk_coreUser_has_coreGroup_coreUser1_idx` ON `coreUser_has_coreGroup` (`coreUser_id` ASC);


-- -----------------------------------------------------
-- Table `addrLogradouro_has_addrZipCode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addrLogradouro_has_addrZipCode` (
  `addrLogradouro_id` INT(10) UNSIGNED NOT NULL COMMENT '- Id do logradouro',
  `addrZipCode_id` INT(10) UNSIGNED NOT NULL COMMENT '- Id do ZipCode.',
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`addrLogradouro_id`, `addrZipCode_id`),
  CONSTRAINT `fk_addrLogradouro_has_addrZipCode_addrLogradouro`
    FOREIGN KEY (`addrLogradouro_id`)
    REFERENCES `addrLogradouro` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addrLogradouro_has_addrZipCode_addrZipCode`
    FOREIGN KEY (`addrZipCode_id`)
    REFERENCES `addrZipCode` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addrLogradouro_has_addrZipCode_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A relationship between addrLogradouro and addrZipCode, becau' /* comment truncated */ /*se a street can have more than 1 Zip Code.*/;


-- -----------------------------------------------------
-- Table `coreCategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coreCategory` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `coreCategory_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'Category father',
  `stResource` VARCHAR(50) NOT NULL COMMENT 'group to use this category',
  `stValue` VARCHAR(250) NOT NULL COMMENT 'Name of this category',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_coreCategory_category1`
    FOREIGN KEY (`coreCategory_id`)
    REFERENCES `coreCategory` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coreCategory_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Table of categories for all purposes in the system. Can be t' /* comment truncated */ /*ags as well*/;

CREATE INDEX `idx_coreCategory_stResource` ON `coreCategory` (`stResource` ASC);


-- -----------------------------------------------------
-- Table `link`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `link` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stTitle` VARCHAR(100) NULL DEFAULT NULL,
  `stLinkPrefix` VARCHAR(45) NULL DEFAULT NULL COMMENT '- Prefixo do link ex.: http://www.',
  `stLinkDomain` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Domínio do link google.com',
  `stDescription` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Descrição do link',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_link_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'It can store some links for all purposes';

CREATE INDEX `idx_link_stLinkDomain` ON `link` (`stLinkDomain` ASC);

CREATE INDEX `idx_link_stTitle` ON `link` (`stTitle` ASC);


-- -----------------------------------------------------
-- Table `company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stName` VARCHAR(250) NOT NULL COMMENT '- Razão social;',
  `stAliasName` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Nome Fantasia',
  `stRegistry` VARCHAR(25) NULL DEFAULT NULL COMMENT '- Registro (ex.: Cnpj)',
  `stRegistry2` VARCHAR(25) NULL DEFAULT NULL COMMENT '- Inscrição Estadual',
  `stArea` VARCHAR(25) NULL DEFAULT NULL COMMENT '- Área de atuação da empresa',
  `stDescription` TEXT NULL DEFAULT NULL COMMENT '- Descrição da empresa',
  `stLogoPath` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Caminho para o arquivo físico da logo',
  `stLinkPrefix` VARCHAR(45) NULL DEFAULT NULL COMMENT '- Prefixo do link ex.: http://www.',
  `stLinkDomain` VARCHAR(100) NULL DEFAULT NULL COMMENT '- Domínio do link google.com',
  `photo_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `stKeywords` VARCHAR(255) NULL DEFAULT NULL,
  `txtData` TEXT NULL DEFAULT NULL COMMENT 'json with extra data about company',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_company_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Table of companies for all purposes';

CREATE UNIQUE INDEX `idx_company_stName_UNIQUE` ON `company` (`stName` ASC);

CREATE INDEX `idx_company_stAliasName` ON `company` (`stAliasName` ASC);

CREATE INDEX `idx_company_stRegistry` ON `company` (`stRegistry` ASC);

CREATE INDEX `idx_company_stRegistry2` ON `company` (`stRegistry2` ASC);

CREATE INDEX `idx_company_stArea` ON `company` (`stArea` ASC);


-- -----------------------------------------------------
-- Table `company_has_addrAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company_has_addrAddress` (
  `company_id` INT(10) UNSIGNED NOT NULL,
  `addrAddress_id` INT(10) UNSIGNED NOT NULL,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`company_id`, `addrAddress_id`),
  CONSTRAINT `fk_company_has_addrAddress_addrAddress1`
    FOREIGN KEY (`addrAddress_id`)
    REFERENCES `addrAddress` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_has_addrAddress_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `company` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_has_addrAddress_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between company and address location';

CREATE INDEX `fk_company_has_addrAddress_company1_idx` ON `company_has_addrAddress` (`company_id` ASC);


-- -----------------------------------------------------
-- Table `company_has_contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company_has_contact` (
  `company_id` INT(10) UNSIGNED NOT NULL,
  `contact_id` INT(10) UNSIGNED NOT NULL,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`company_id`, `contact_id`),
  CONSTRAINT `fk_company_has_contact_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `company` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_has_contact_contact1`
    FOREIGN KEY (`contact_id`)
    REFERENCES `contact` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_has_contact_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between company and contacts';

CREATE INDEX `fk_company_has_contact_company1_idx` ON `company_has_contact` (`company_id` ASC);


-- -----------------------------------------------------
-- Table `company_has_link`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `company_has_link` (
  `company_id` INT(10) UNSIGNED NOT NULL,
  `link_id` INT(10) UNSIGNED NOT NULL,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`company_id`, `link_id`),
  CONSTRAINT `fk_company_has_link_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `company` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_has_link_link1`
    FOREIGN KEY (`link_id`)
    REFERENCES `link` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_has_link_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between company and some links';

CREATE INDEX `fk_company_has_link_company1_idx` ON `company_has_link` (`company_id` ASC);


-- -----------------------------------------------------
-- Table `product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id do produto',
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `company_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'Id da empresa',
  `stProductKey` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Código do produto (especificado pela empresa)',
  `stName` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Nome do produto',
  `txtDescription` TEXT NULL DEFAULT NULL COMMENT 'detalhes do produto',
  `txtSpecification` TEXT NULL DEFAULT NULL COMMENT 'especificação técnica',
  `txtApplication` TEXT NULL DEFAULT NULL COMMENT 'modo de uso',
  `txtWarranty` TEXT NULL DEFAULT NULL COMMENT 'garantia',
  `stKeywords` VARCHAR(250) NULL DEFAULT NULL,
  `numOldPrice` DECIMAL(10,3) UNSIGNED NULL DEFAULT NULL COMMENT 'preço antigo',
  `numPrice` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'preço',
  `numDescount` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'preço com desconto',
  `isInterestFree` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT 'Sem juros?',
  `numDivideInto` INT(5) UNSIGNED NULL DEFAULT NULL COMMENT 'Numero de parcelas',
  `numStock` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'Estoque de produtos',
  `isPromotion` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT 'É promoção',
  `dtEndPromotion` TIMESTAMP NULL DEFAULT NULL COMMENT 'Data de finalização de promoção.',
  `isHighlighted` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT 'É destaque?',
  `isNew` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT 'Se é um produto em lançamento',
  `numWeight` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'peso em gramas',
  `numWidth` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'largura em cm',
  `numHeight` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'altura em cm',
  `numDepth` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'profundidade em cm',
  `isFreeShipping` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT 'Frete grátis?',
  `stWhereFreeShipping` VARCHAR(100) NULL DEFAULT NULL COMMENT 'Estados ou cidades onde o frete é grátis',
  `dtEndFreeShipping` TIMESTAMP NULL DEFAULT NULL COMMENT 'Data de finalização para frete grátis',
  `enumPresentation` ENUM('0','1','2') NOT NULL DEFAULT '0' COMMENT '0=apenas orçamento, 1=disponível para venda online, 2=somente apresentação',
  `numRate1` INT(6) UNSIGNED NULL DEFAULT NULL COMMENT 'Avaliação 1 estrala',
  `numRate2` INT(6) UNSIGNED NULL DEFAULT NULL COMMENT 'Avaliação 2 estralas',
  `numRate3` INT(6) UNSIGNED NULL DEFAULT NULL COMMENT 'Avaliação 3 estralas',
  `numRate4` INT(6) UNSIGNED NULL DEFAULT NULL COMMENT 'Avaliação 4 estralas',
  `numRate5` INT(6) UNSIGNED NULL DEFAULT NULL COMMENT 'Avaliação 5 estralas',
  `photo_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '- Id da foto principal do produto',
  `stLink` VARCHAR(255) NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_product_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `company` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_photo`
    FOREIGN KEY (`photo_id`)
    REFERENCES `photo` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Product records';

CREATE INDEX `idx_product_stName` ON `product` (`stName` ASC);

CREATE INDEX `idx_product_numPrice` ON `product` (`numPrice` ASC);

CREATE INDEX `idx_product_numDescount` ON `product` (`numDescount` ASC);


-- -----------------------------------------------------
-- Table `productExtraField`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `productExtraField` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '- id do campo',
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stGroup` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Group of related fields as color, size ...',
  `stLabel` VARCHAR(250) NULL DEFAULT NULL COMMENT 'The field name for exibition',
  `txtValue` TEXT NULL DEFAULT NULL COMMENT 'field value, can be anything',
  `enumType` ENUM('text','checkbox','radiobox','file','textarea','password') NULL DEFAULT NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_productExtraField_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Product features, fields to compare product by product';

CREATE INDEX `idx_productExtraField_stGroup` ON `productExtraField` (`stGroup` ASC);

CREATE INDEX `idx_productExtraField_stLabel` ON `productExtraField` (`stLabel` ASC);


-- -----------------------------------------------------
-- Table `product_has_productExtraField`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product_has_productExtraField` (
  `product_id` INT(10) UNSIGNED NOT NULL COMMENT '- id do produto',
  `productExtraField_id` INT(10) UNSIGNED NOT NULL COMMENT '- Id da categoria',
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`product_id`, `productExtraField_id`),
  CONSTRAINT `fk_product_has_productExtraField_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `product` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_productExtraField_productExtraField`
    FOREIGN KEY (`productExtraField_id`)
    REFERENCES `productExtraField` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_productExtraField_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between product record and the extra fields';


-- -----------------------------------------------------
-- Table `billing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billing` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '- id da fatura',
  `coreUser_idClient` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'Client id. He need to be registred',
  `coreUser_idVendor` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'Saller id, if someone helped sell',
  `stVoucher` VARCHAR(250) NULL DEFAULT NULL COMMENT 'A promotional code to give descount',
  `numDescount` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'Total descount offered',
  `numTotal` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'Total bill',
  `stGateway` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Gateway identification, can be a name as PayPal',
  `enumSaleType` ENUM('debit','credit','billet','money','deposit','check','permutation','change') NULL DEFAULT NULL COMMENT 'Payment kind',
  `numDivideInto` INT(5) UNSIGNED NULL DEFAULT NULL COMMENT 'how many plots were divided',
  `numMissing` INT(5) UNSIGNED NULL DEFAULT NULL COMMENT 'how many plots still missing',
  `enumTansactionStatus` ENUM('started','sent','waiting','approved','refused','canceled','error','contest') NULL DEFAULT NULL COMMENT 'Gateway transaction status ',
  `stTransactionCode` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Code that identify the gateway transaction',
  `txtTransactionDetails` TEXT NULL DEFAULT NULL,
  `stPostCode` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Post code for tracker the package',
  `enumDeliveryStatus` ENUM('waiting','sent','on the way','delivered', 'returned', 'lost') NULL DEFAULT NULL,
  `txtObs` TEXT NULL DEFAULT NULL COMMENT 'Observation about anything',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_billing_coreUser_client`
    FOREIGN KEY (`coreUser_idClient`)
    REFERENCES `coreUser` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_billing_coreUser_vendor`
    FOREIGN KEY (`coreUser_idVendor`)
    REFERENCES `coreUser` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Sales revenue for products';

CREATE INDEX `idx_billing_stVoucher` ON `billing` (`stVoucher` ASC);

CREATE INDEX `idx_billing_stTransactionCode` ON `billing` (`stTransactionCode` ASC);

CREATE INDEX `idx_billing_stPostCode` ON `billing` (`stPostCode` ASC);


-- -----------------------------------------------------
-- Table `billing_has_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `billing_has_product` (
  `billing_id` INT(10) UNSIGNED NOT NULL COMMENT '- Id da fatura',
  `product_id` INT(10) UNSIGNED NOT NULL COMMENT '- id do produto',
  `numPrice` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'Unit price',
  `numDescount` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'unit descount',
  `numQuantity` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'hou many products',
  `txtSpecification` TEXT NULL DEFAULT NULL COMMENT 'Product specification as color, size ...',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`billing_id`, `product_id`),
  CONSTRAINT `fk_billing_has_product_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_billing_has_product_billing`
    FOREIGN KEY (`billing_id`)
    REFERENCES `billing` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between billing and products sold';


-- -----------------------------------------------------
-- Table `service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `service` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id do produto',
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `company_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'Id da empresa',
  `stServicetKey` VARCHAR(45) NULL DEFAULT NULL COMMENT 'Código do produto (especificado pela empresa)',
  `stName` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Nome do produto',
  `txtDescription` TEXT NULL DEFAULT NULL COMMENT 'detalhes do produto',
  `txtSpecification` TEXT NULL DEFAULT NULL COMMENT 'especificação técnica',
  `txtApplication` TEXT NULL DEFAULT NULL COMMENT 'modo de uso',
  `txtWarranty` TEXT NULL DEFAULT NULL COMMENT 'garantia',
  `stKeywords` VARCHAR(250) NULL DEFAULT NULL,
  `numOldPrice` DECIMAL(10,3) UNSIGNED NULL DEFAULT NULL COMMENT 'preço antigo',
  `numPrice` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'preço',
  `numDescount` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'preço com desconto',
  `isInterestFree` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT 'Sem juros?',
  `numDivideInto` INT(5) UNSIGNED NULL DEFAULT NULL COMMENT 'Numero de parcelas',
  `isPromotion` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT 'É promoção',
  `dtEndPromotion` TIMESTAMP NULL DEFAULT NULL COMMENT 'Data de finalização de promoção.',
  `isHighlighted` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT 'É destaque?',
  `isNew` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT 'Se é um produto em lançamento',
  `enumPresentation` ENUM('0','1','2') NOT NULL DEFAULT '0' COMMENT '0=apenas orçamento, 1=disponível para venda online, 2=somente apresentação',
  `numRate1` INT(6) UNSIGNED NULL DEFAULT NULL COMMENT 'Avaliação 1 estrala',
  `numRate2` INT(6) UNSIGNED NULL DEFAULT NULL COMMENT 'Avaliação 2 estralas',
  `numRate3` INT(6) UNSIGNED NULL DEFAULT NULL COMMENT 'Avaliação 3 estralas',
  `numRate4` INT(6) UNSIGNED NULL DEFAULT NULL COMMENT 'Avaliação 4 estralas',
  `numRate5` INT(6) UNSIGNED NULL DEFAULT NULL COMMENT 'Avaliação 5 estralas',
  `photo_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '- Id da foto principal do produto',
  `stLink` VARCHAR(255) NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_service_company`
    FOREIGN KEY (`company_id`)
    REFERENCES `company` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_service_photo`
    FOREIGN KEY (`photo_id`)
    REFERENCES `photo` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_service_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Service records';

CREATE INDEX `idx_service_stName` ON `service` (`stName` ASC);

CREATE INDEX `idx_service_numPrice` ON `service` (`numPrice` ASC);

CREATE INDEX `idx_service_numDescount` ON `service` (`numDescount` ASC);


-- -----------------------------------------------------
-- Table `coreMenu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coreMenu` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `coreMenu_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'Menu father',
  `stTitle` VARCHAR(250) NOT NULL COMMENT 'Menu title to show',
  `isExternal` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT 'if the link action redirect to a external site',
  `stUrlPrefix` VARCHAR(15) NULL DEFAULT NULL COMMENT 'url prefix, as http://www. or other common prefix',
  `stUrlDomain` VARCHAR(250) NULL DEFAULT NULL COMMENT 'the link whitout prefix',
  `stIcon` VARCHAR(255) NULL DEFAULT NULL COMMENT 'An icon file name that can represent this menu iten',
  `stValue` VARCHAR(50) NOT NULL COMMENT 'Internal name',
  `stDescription` VARCHAR(255) NULL DEFAULT NULL,
  `numOrder` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT 'Ordem do menu.',
  `isSystem` ENUM('0','1') NOT NULL DEFAULT '0',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_coreMenu_coreMenu1`
    FOREIGN KEY (`coreMenu_id`)
    REFERENCES `coreMenu` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coreMenu_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Can be used for create dinamic menu in frontend';

CREATE INDEX `idx_coreMenu_stTitle` ON `coreMenu` (`stTitle` ASC);

CREATE INDEX `idx_coreMenu_stUrlDomain` ON `coreMenu` (`stUrlDomain` ASC);

CREATE UNIQUE INDEX `idx_coreMenu_stValue_UNIQUE` ON `coreMenu` (`stValue` ASC);


-- -----------------------------------------------------
-- Table `coreSection`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coreSection` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `coreSection_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT 'Section father',
  `stArea` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Same a group',
  `stValue` VARCHAR(250) NOT NULL COMMENT 'Name used for this section',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_coreSection_coreSection1`
    FOREIGN KEY (`coreSection_id`)
    REFERENCES `coreSection` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coreSection_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'This table can be used for create sections or areas in front' /* comment truncated */ /* end, bringing diferent content for each section*/;

CREATE UNIQUE INDEX `idx_coreSection_stValue_UNIQUE` ON `coreSection` (`stValue` ASC);

CREATE INDEX `idx_coreSection_stArea` ON `coreSection` (`stArea` ASC);


-- -----------------------------------------------------
-- Table `coreRoute`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coreRoute` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `coreSection_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL,
  `coreCategory_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `stTitle` VARCHAR(250) NULL DEFAULT NULL,
  `stUri` VARCHAR(250) NULL DEFAULT NULL,
  `stDescription` VARCHAR(250) NULL DEFAULT NULL,
  `stKeywords` VARCHAR(250) NULL DEFAULT NULL,
  `stSlung` VARCHAR(50) NULL DEFAULT NULL,
  `stTemplate` VARCHAR(250) NULL DEFAULT NULL,
  `enumIndex` ENUM('0','1') NULL DEFAULT '1',
  `enumFollow` ENUM('0','1') NULL DEFAULT '1',
  `stLanguage` VARCHAR(5) NULL DEFAULT NULL,
  `enumRestrict` ENUM('0','1') NULL DEFAULT '0',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_coreRoute_coreCategory1`
    FOREIGN KEY (`coreCategory_id`)
    REFERENCES `coreCategory` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coreRoute_coreSection1`
    FOREIGN KEY (`coreSection_id`)
    REFERENCES `coreSection` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coreRoute_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Can be used to create site map';

CREATE INDEX `idx_coreRoute_stTitle` ON `coreRoute` (`stTitle` ASC);

CREATE INDEX `idx_coreRoute_stkeywords` ON `coreRoute` (`stKeywords` ASC);

CREATE INDEX `idx_coreRoute_stSlung` ON `coreRoute` (`stSlung` ASC);

CREATE INDEX `idx_coreRoute_stUri` ON `coreRoute` (`stUri` ASC);


-- -----------------------------------------------------
-- Table `coreLogAccess`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coreLogAccess` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dtInsert` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record. The user registred',
  `txtCredentials` TEXT NOT NULL,
  `stSession` VARCHAR(255) NULL DEFAULT NULL,
  `stIP` VARCHAR(20) NULL DEFAULT NULL,
  `txtServer` TEXT NOT NULL,
  `stPriority` VARCHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_coreLogAccess_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Records of access log';

CREATE INDEX `idx_coreLogAccess_dtInsert` ON `coreLogAccess` (`dtInsert` ASC);


-- -----------------------------------------------------
-- Table `coreLogEvent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coreLogEvent` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dtInsert` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stIP` VARCHAR(20) NULL DEFAULT NULL,
  `txtServer` TEXT NOT NULL,
  `stPriority` VARCHAR(1) NULL DEFAULT NULL,
  `stMsg` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_coreLogError_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Records of system event log';

CREATE INDEX `idx_coreLogError_dtInsert` ON `coreLogEvent` (`dtInsert` ASC);


-- -----------------------------------------------------
-- Table `coreLogSearch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coreLogSearch` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dtInsert` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stQuery` VARCHAR(250) NULL DEFAULT NULL,
  `numResults` INT(10) UNSIGNED NULL DEFAULT NULL,
  `stPriority` VARCHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Records of key words used in search action';

CREATE INDEX `idx_coreLogSearch_dtInsert` ON `coreLogSearch` (`dtInsert` ASC);

CREATE INDEX `idx_coreLogSearch_stQuery` ON `coreLogSearch` (`stQuery` ASC);


-- -----------------------------------------------------
-- Table `coreLogView`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coreLogView` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dtInsert` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stResource` VARCHAR(50) NULL DEFAULT NULL,
  `resource_Id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `stUrl` VARCHAR(250) NULL DEFAULT NULL,
  `stPriority` VARCHAR(1) NULL DEFAULT NULL,
  `stIP` VARCHAR(20) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Records of view logs. Can be used for count view action for ' /* comment truncated */ /*all tables or modules*/;

CREATE INDEX `idx_coreLogView_dtInsert` ON `coreLogView` (`dtInsert` ASC);

CREATE INDEX `idx_coreLogView_stTable` ON `coreLogView` (`stResource` ASC);

CREATE INDEX `idx_coreLogView_numId` ON `coreLogView` (`resource_Id` ASC);

CREATE INDEX `idx_coreLogView_stUrl` ON `coreLogView` (`stUrl` ASC);


-- -----------------------------------------------------
-- Table `coreLogClick`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coreLogClick` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dtInsert` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stResource` VARCHAR(50) NULL DEFAULT NULL,
  `resource_Id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `stUrl` VARCHAR(250) NULL DEFAULT NULL,
  `stPriority` VARCHAR(1) NULL DEFAULT NULL,
  `stIP` VARCHAR(20) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Log of click action. Can be used for all tables or modules';

CREATE INDEX `idx_coreLogClick_dtInsert` ON `coreLogClick` (`dtInsert` ASC);

CREATE INDEX `idx_coreLogClick_stTable` ON `coreLogClick` (`stResource` ASC);

CREATE INDEX `idx_coreLogClick_numId` ON `coreLogClick` (`resource_Id` ASC);

CREATE INDEX `idx_coreLogClick_stUrl` ON `coreLogClick` (`stUrl` ASC);


-- -----------------------------------------------------
-- Table `file`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `file` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stType` VARCHAR(6) NOT NULL DEFAULT 'other',
  `stTitle` VARCHAR(250) NOT NULL COMMENT '- Titulo da foto',
  `stVersion` VARCHAR(15) NOT NULL DEFAULT '1',
  `stDescription` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Descrição da foto',
  `stSource` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Fonte da foto, autor ...',
  `stFilePath` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Caminho para o arquivo físico (Nome do arquivo)',
  `stKeywords` VARCHAR(250) NULL DEFAULT NULL,
  `isNew` ENUM('0','1') NOT NULL DEFAULT '0',
  `isHighlighted` ENUM('0','1') NOT NULL DEFAULT '0',
  `dtPublish` DATETIME NULL,
  `stThumb` VARCHAR(255) NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_file_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'File is a table that records and manage upload files, as pdf' /* comment truncated */ /*, doc, xls, ppt and others, except images*/;

CREATE UNIQUE INDEX `idx_file_stTitle_stVersion_UNIQUE` ON `file` (`stVersion` ASC, `stTitle` ASC, `stFilePath` ASC);

CREATE INDEX `idx_file_dtPublish` ON `file` (`dtPublish` ASC);


-- -----------------------------------------------------
-- Table `file_has_coreCategory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `file_has_coreCategory` (
  `file_id` INT(10) UNSIGNED NOT NULL COMMENT '- id do produto',
  `coreCategory_id` INT(10) UNSIGNED NOT NULL COMMENT '- Id da categoria',
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`file_id`, `coreCategory_id`),
  CONSTRAINT `fk_file_has_coreCategory_coreCategory`
    FOREIGN KEY (`coreCategory_id`)
    REFERENCES `coreCategory` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_file_has_coreCategory_file`
    FOREIGN KEY (`file_id`)
    REFERENCES `file` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_file_has_coreCategory_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between file and its category';

CREATE INDEX `fk_file_has_coreCategory_file_idx` ON `file_has_coreCategory` (`file_id` ASC);


-- -----------------------------------------------------
-- Table `newsletter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `newsletter` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '- id do produto',
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'If registred, it is the user id',
  `stName` VARCHAR(255) NOT NULL COMMENT 'Name used for contact',
  `stEmail` VARCHAR(255) NOT NULL COMMENT 'e-mail account used for contact',
  `txtInterest` TEXT NULL COMMENT 'A json data containig a list of subjects',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_newsletter_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Record the customer intention of receive newsletter from thi' /* comment truncated */ /*s system*/;

CREATE INDEX `idx_newsletter_stName` ON `newsletter` (`stName` ASC);

CREATE INDEX `idx_newsletter_stEmail` ON `newsletter` (`stEmail` ASC);

CREATE UNIQUE INDEX `stEmail_UNIQUE` ON `newsletter` (`stEmail` ASC);


-- -----------------------------------------------------
-- Table `product_has_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `product_has_product` (
  `product_id` INT(10) UNSIGNED NOT NULL COMMENT 'id do produto',
  `productRel_id` INT(10) UNSIGNED NOT NULL COMMENT 'Produto relacionado',
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`productRel_id`, `product_id`),
  CONSTRAINT `fk_product_has_product_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `product` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_product_productRel`
    FOREIGN KEY (`productRel_id`)
    REFERENCES `product` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_has_product_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Products recomended';

CREATE INDEX `fk_product_has_product_productRel_idx` ON `product_has_product` (`productRel_id` ASC);


-- -----------------------------------------------------
-- Table `voucher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `voucher` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '- id da fatura',
  `stCode` VARCHAR(250) NOT NULL COMMENT 'Promotional code to give some sale descount',
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `coreUser_idClient` INT(10) UNSIGNED NULL COMMENT 'The registred client id',
  `numValue` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'Descount value',
  `stOrigin` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Origin of voucher, supplier, promotion ...',
  `dtValid` TIMESTAMP NULL DEFAULT NULL COMMENT 'expirate date for this code',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_voucher_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_voucher_coreUserClient`
    FOREIGN KEY (`coreUser_idClient`)
    REFERENCES `coreUser` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'This is a voucher control, that containing all of voucher co' /* comment truncated */ /*de distributed to give a sells discount*/;

CREATE INDEX `idx_voucher_stOrigin` ON `voucher` (`stOrigin` ASC);

CREATE UNIQUE INDEX `idx_voucehr_stCode_UNIQUE` ON `voucher` (`stCode` ASC);


-- -----------------------------------------------------
-- Table `faq`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `faq` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stQuestion` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Título que identifica o classificado',
  `txtAnswer` TEXT NULL DEFAULT NULL COMMENT 'Conteúdo do classificado',
  `stKeywords` VARCHAR(255) NULL DEFAULT NULL,
  `numRate1` INT(6) UNSIGNED NULL DEFAULT 0,
  `numRate2` INT(6) UNSIGNED NULL DEFAULT 0,
  `numRate3` INT(6) UNSIGNED NULL DEFAULT 0,
  `numRate4` INT(6) UNSIGNED NULL DEFAULT 0,
  `numRate5` INT(6) UNSIGNED NULL DEFAULT 0,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_faq_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Frequent Ask Question, is a table with questions and answers' /* comment truncated */ /* to show in a frontend area*/;

CREATE INDEX `idx_faq_stQuestion` ON `faq` (`stQuestion` ASC);


-- -----------------------------------------------------
-- Table `coreInviteKey`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coreInviteKey` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL COMMENT 'User owner or the user that created this record.' /* comment truncated */ /*The user that need to check autenticity.*/,
  `stKey` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Título que identifica o classificado',
  `stEmail` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Email a ser validado',
  `stName` VARCHAR(250) NULL DEFAULT NULL,
  `dtValid` TIMESTAMP NULL DEFAULT NULL COMMENT 'Data de inicio do anúncio.',
  `dtActivate` TIMESTAMP NULL DEFAULT NULL COMMENT 'Data de encerramento do anúncio.',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_coreInviteKey_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'InviteKey can be used to verify e-mail account before activa' /* comment truncated */ /*te an user or to give access for some section of the system once*/;

CREATE INDEX `idx_coreInviteKey_stKey` ON `coreInviteKey` (`stKey` ASC);

CREATE INDEX `idx_coreInviteKey_dtValid` ON `coreInviteKey` (`dtValid` ASC);

CREATE INDEX `idx_coreInviteKey_dtActivate` ON `coreInviteKey` (`dtActivate` ASC);


-- -----------------------------------------------------
-- Table `corePref`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `corePref` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `coreUser_id` INT(10) UNSIGNED NULL COMMENT 'User owner or the user that created this record',
  `stModule` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Module name or idendifier',
  `stTable` VARCHAR(50) NULL DEFAULT NULL COMMENT 'DB Table name',
  `numRecord_id` INT UNSIGNED NULL DEFAULT NULL COMMENT 'DB Table record id',
  `txtPref` TEXT NULL DEFAULT NULL COMMENT 'A json data pref for som table, record or module in the system',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_corePref_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'CorePref can be used to store module, table or record prefer' /* comment truncated */ /*ence, as number of display records, template, color, order, size, time, css, js, js function, plugin ... It is always a json data*/;

CREATE INDEX `idx_corePref_stTable` ON `corePref` (`stTable` ASC);

CREATE INDEX `idx_corePref_stModule` ON `corePref` (`stModule` ASC);

CREATE INDEX `idx_corePref_numRecord_id` ON `corePref` (`numRecord_id` ASC);


-- -----------------------------------------------------
-- Table `addrAddress_has_addrZipCode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `addrAddress_has_addrZipCode` (
  `addrAddress_id` INT(10) UNSIGNED NOT NULL,
  `addrZipCode_id` INT(10) UNSIGNED NOT NULL,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`addrAddress_id`, `addrZipCode_id`),
  CONSTRAINT `fk_addrAddress_has_addrZipCode_addrAddress`
    FOREIGN KEY (`addrAddress_id`)
    REFERENCES `addrAddress` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addrAddress_has_addrZipCode_addrZipCode`
    FOREIGN KEY (`addrZipCode_id`)
    REFERENCES `addrZipCode` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addrAddress_has_addrZipCode_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A relationship between addrAddress and addrZipCode, because ' /* comment truncated */ /*a street can have more than 1 Zip Code.*/;


-- -----------------------------------------------------
-- Table `file_has_coreUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `file_has_coreUser` (
  `file_id` INT(10) UNSIGNED NOT NULL COMMENT '- id do produto',
  `coreUser_id` INT(10) UNSIGNED NOT NULL COMMENT '- Id da categoria',
  `dtLastAccess` TIMESTAMP NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`file_id`, `coreUser_id`),
  CONSTRAINT `fk_file_has_coreUser_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_file_has_coreUser_file`
    FOREIGN KEY (`file_id`)
    REFERENCES `file` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between file and its category';

CREATE INDEX `fk_file_has_coreUser_file_idx` ON `file_has_coreUser` (`file_id` ASC);


-- -----------------------------------------------------
-- Table `coreCategory_has_resource`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coreCategory_has_resource` (
  `coreCategory_id` INT(10) UNSIGNED NOT NULL,
  `resource_id` INT(10) UNSIGNED NOT NULL,
  `coreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`coreCategory_id`, `resource_id`),
  CONSTRAINT `fk_coreCategory_has_resource_coreCategory`
    FOREIGN KEY (`coreCategory_id`)
    REFERENCES `coreCategory` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coreCategory_has_resource_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `coreUser` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between categories and any resource row';


-- -----------------------------------------------------
-- Table `ratio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ratio` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `stResource` VARCHAR(45) NOT NULL,
  `resource_id` INT UNSIGNED NOT NULL,
  `numRate1` INT UNSIGNED NOT NULL DEFAULT 0,
  `numRate2` INT UNSIGNED NOT NULL DEFAULT 0,
  `numRate3` INT UNSIGNED NOT NULL DEFAULT 0,
  `numRate4` INT UNSIGNED NOT NULL DEFAULT 0,
  `numRate5` INT UNSIGNED NOT NULL DEFAULT 0,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT UNSIGNED NOT NULL DEFAULT 0,
  `isActive` ENUM('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE INDEX `idx_stResource` ON `ratio` (`stResource` ASC);

CREATE INDEX `idx_resoutce_id` ON `ratio` (`resource_id` ASC);

CREATE INDEX `idx_numRate1` ON `ratio` (`numRate1` ASC);

CREATE INDEX `idx_numRate2` ON `ratio` (`numRate2` ASC);

CREATE INDEX `idx_numRate3` ON `ratio` (`numRate3` ASC);

CREATE INDEX `idx_numRate4` ON `ratio` (`numRate4` ASC);

CREATE INDEX `idx_numRate5` ON `ratio` (`numRate5` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
