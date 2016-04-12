SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';


-- -----------------------------------------------------
-- Table `Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Person` (
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
  CONSTRAINT `fk_Person_User1`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Person data ';

CREATE INDEX `idx_Person_stName_stCitizenId` ON `Person` (`stName` ASC);

CREATE INDEX `idx_Person_stDoc2` ON `Person` (`stDoc2` ASC);

CREATE INDEX `idx_Person_stPassport` ON `Person` (`stPassport` ASC);

CREATE INDEX `idx_Person_stCitzenId` ON `Person` (`stCitizenId` ASC);


-- -----------------------------------------------------
-- Table `User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `User` (
  `id` INT UNSIGNED NOT NULL,
  `User_id` INT UNSIGNED NULL COMMENT 'User owner or the user that created this user',
  `Person_id` INT UNSIGNED NULL COMMENT 'Relationship with on person',
  `Group_id` SMALLINT UNSIGNED NULL COMMENT 'Relashionship with a group that this user is a member',
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
  CONSTRAINT `fk_User_Person1`
    FOREIGN KEY (`Person_id`)
    REFERENCES `Person` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_Group1`
    FOREIGN KEY (`Group_id`)
    REFERENCES `Group` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Table that make part of system ACL';

CREATE UNIQUE INDEX `idx_User_stUsername_UNIQUE` ON `User` (`stUsername` ASC);


-- -----------------------------------------------------
-- Table `Group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Group` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT UNSIGNED NULL COMMENT 'group owner or the user that created this group',
  `Group_id` SMALLINT UNSIGNED NULL COMMENT 'Father group',
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
  CONSTRAINT `fk_Group_Group1`
    FOREIGN KEY (`Group_id`)
    REFERENCES `Group` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Group_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Table that make part of system ACL';

CREATE UNIQUE INDEX `idx_Group_stName_UNIQUE` ON `Group` (`stName` ASC);


-- -----------------------------------------------------
-- Table `Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Country` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
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
  CONSTRAINT `fk_Country_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A data base of countries';

CREATE INDEX `idx_Country_stCountry` ON `Country` (`stCountry` ASC);

CREATE INDEX `idx_Country_stAbreviation` ON `Country` (`stAbreviation` ASC);

CREATE INDEX `idx_Country_stLocation` ON `Country` (`stLocation` ASC);


-- -----------------------------------------------------
-- Table `Estate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Estate` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Country_id` INT(10) UNSIGNED NOT NULL COMMENT '- País ao qual o estado pertence',
  `stEstate` VARCHAR(250) NOT NULL COMMENT '- Nome do estado ou província',
  `stAbreviation` VARCHAR(5) NULL DEFAULT NULL COMMENT '- Abreviação do nome da do estado',
  `City_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT ' - Id da capital do estado',
  `stTimeZone` VARCHAR(10) NULL DEFAULT NULL COMMENT '- Time zone padrão GMT',
  `stTimeZone2` VARCHAR(10) NULL DEFAULT NULL COMMENT '- Abreviação do nome da do estado',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`, `Country_id`),
  CONSTRAINT `fk_Estate_Country1`
    FOREIGN KEY (`Country_id`)
    REFERENCES `Country` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estate_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A data base of federation estates';

CREATE INDEX `idx_Estate_stEstate` ON `Estate` (`stEstate` ASC);

CREATE INDEX `idx_Estate_stAbreviation` ON `Estate` (`stAbreviation` ASC);


-- -----------------------------------------------------
-- Table `City`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `City` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Estate_id` INT(10) UNSIGNED NOT NULL COMMENT '- Estado ao qual a cidade pertence',
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
  PRIMARY KEY (`id`, `Estate_id`),
  CONSTRAINT `fk_City_Estate1`
    FOREIGN KEY (`Estate_id`)
    REFERENCES `Estate` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_City_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A data base of cities';

CREATE INDEX `idx_City_stCity` ON `City` (`stCity` ASC);

CREATE INDEX `idx_City_stAbreviation` ON `City` (`stAbreviation` ASC);


-- -----------------------------------------------------
-- Table `Logradouro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Logradouro` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `City_id` INT(10) UNSIGNED NOT NULL COMMENT '- Cidade ao qual o endereço pertence',
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
  PRIMARY KEY (`id`, `City_id`),
  CONSTRAINT `fk_Logradouro_City`
    FOREIGN KEY (`City_id`)
    REFERENCES `City` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Logradouro_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A data base of streets, avenues e others';

CREATE INDEX `idx_Logradouro_stAddress` ON `Logradouro` (`stAddress` ASC);

CREATE INDEX `idx_Logradouro_stNeighborhood` ON `Logradouro` (`stNeighborhood` ASC);


-- -----------------------------------------------------
-- Table `ZipCode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZipCode` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Country_id` INT(10) UNSIGNED NULL COMMENT '- País ao qual o CEP pertence',
  `Estate_id` INT(10) UNSIGNED NULL COMMENT '- Estado ao qual o CEP pertence',
  `City_id` INT(10) UNSIGNED NULL COMMENT '- Cidade ao qual o CEP pertence',
  `stZipCode` VARCHAR(20) NOT NULL COMMENT '- Nome do estado ou província',
  `stRange` VARCHAR(20) NULL DEFAULT NULL COMMENT '- Faixa de número da rua ex: 1000 a 2000',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ZipCode_City1`
    FOREIGN KEY (`City_id`)
    REFERENCES `City` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ZipCode_Country1`
    FOREIGN KEY (`Country_id`)
    REFERENCES `Country` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ZipCode_Estate1`
    FOREIGN KEY (`Estate_id`)
    REFERENCES `Estate` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A data base of Zip Code';

CREATE UNIQUE INDEX `idx_ZipCode_stZipCode_UNIQUE` ON `ZipCode` (`stZipCode` ASC);

CREATE INDEX `fk_User_ZipCode` ON `ZipCode` (`User_id` ASC);


-- -----------------------------------------------------
-- Table `Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Address` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Country_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '- País ao qual o endereço pertence',
  `Estate_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '- Estado ao qual o endereço pertence',
  `City_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '- Cidade ao qual o endereço pertence',
  `Logradouro_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '- Rua ao qual o endereço pertence',
  `ZipCode_id` INT(10) UNSIGNED NULL COMMENT '- CEP ao qual o endereço pertence',
  `stNumber` VARCHAR(10) NULL DEFAULT NULL COMMENT '- Número',
  `stComplement` VARCHAR(50) NULL DEFAULT NULL COMMENT '- Complemento',
  `stPlace` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Local (ex.: casa, escritório, filial, etc.)',
  `stGeoLocalization` VARCHAR(100) NULL DEFAULT NULL COMMENT '- Geo posição x e y para posicionamento em mapa',
  `stZoomMap` VARCHAR(3) NULL DEFAULT NULL COMMENT '- Nível de zoom para visualização de mapa',
  `enumMasterAddr` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '- Se o endereço é o principal ou não',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Address_City1`
    FOREIGN KEY (`City_id`)
    REFERENCES `City` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_Country`
    FOREIGN KEY (`Country_id`)
    REFERENCES `Country` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_Estate`
    FOREIGN KEY (`Estate_id`)
    REFERENCES `Estate` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_Logradouro`
    FOREIGN KEY (`Logradouro_id`)
    REFERENCES `Logradouro` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_ZipCode`
    FOREIGN KEY (`ZipCode_id`)
    REFERENCES `ZipCode` (`id`)
    ON DELETE RESTRICT
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Address or location, it registre a specific place.';

CREATE INDEX `idx_Address_stNumber` ON `Address` (`stNumber` ASC);

CREATE INDEX `idx_Address_stGeoLocalization` ON `Address` (`stGeoLocalization` ASC);

CREATE INDEX `idx_Address_Place` ON `Address` (`stPlace` ASC);


-- -----------------------------------------------------
-- Table `Resource_has_Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Resource_has_Address` (
  `stResource` VARCHAR(45) NOT NULL,
  `Resource_Id` INT UNSIGNED NOT NULL,
  `Address_id` INT(10) UNSIGNED NOT NULL,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL COMMENT '- Data de Cadastro do registro.',
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '- Data de Alteração',
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`Address_id`, `Resource_Id`, `stResource`),
  CONSTRAINT `fk_Person_has_Address_Address1`
    FOREIGN KEY (`Address_id`)
    REFERENCES `Address` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Person_has_Address_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between person and address';


-- -----------------------------------------------------
-- Table `Contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Contact` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
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
  CONSTRAINT `fk_Contact_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Table contatos.';

CREATE INDEX `idx_Contact_enumType` ON `Contact` (`enumType` ASC);

CREATE INDEX `idx_Contact_stLabel` ON `Contact` (`stLabel` ASC);

CREATE INDEX `idx_Contact_stValue` ON `Contact` (`stValue` ASC);


-- -----------------------------------------------------
-- Table `Resource_has_Contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Resource_has_Contact` (
  `stResource` VARCHAR(45) NOT NULL,
  `Resource_id` INT UNSIGNED NOT NULL,
  `Contact_id` INT UNSIGNED NOT NULL,
  `User_id` INT UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`Contact_id`, `Resource_id`, `stResource`),
  CONSTRAINT `fk_Resource_has_Contact_Contact1`
    FOREIGN KEY (`Contact_id`)
    REFERENCES `Contact` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Resource_has_Contact_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between person and contacts';


-- -----------------------------------------------------
-- Table `Logradouro_has_ZipCode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Logradouro_has_ZipCode` (
  `Logradouro_id` INT(10) UNSIGNED NOT NULL COMMENT '- Id do logradouro',
  `ZipCode_id` INT(10) UNSIGNED NOT NULL COMMENT '- Id do ZipCode.',
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`Logradouro_id`, `ZipCode_id`),
  CONSTRAINT `fk_Logradouro_has_ZipCode_Logradouro`
    FOREIGN KEY (`Logradouro_id`)
    REFERENCES `Logradouro` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Logradouro_has_ZipCode_ZipCode`
    FOREIGN KEY (`ZipCode_id`)
    REFERENCES `ZipCode` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Logradouro_has_ZipCode_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A relationship between addrLogradouro and addrZipCode, becau' /* comment truncated */ /*se a street can have more than 1 Zip Code.*/;


-- -----------------------------------------------------
-- Table `Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Category` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Category_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'Category father',
  `stResource` VARCHAR(50) NOT NULL COMMENT 'Table to use this category',
  `stValue` VARCHAR(250) NOT NULL COMMENT 'Name of this category',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_coreCategory_category1`
    FOREIGN KEY (`Category_id`)
    REFERENCES `Category` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coreCategory_coreUser`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Table of categories for all purposes in the system. Can be t' /* comment truncated */ /*ags as well*/;

CREATE INDEX `idx_coreCategory_stResource` ON `Category` (`stResource` ASC);


-- -----------------------------------------------------
-- Table `Link`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Link` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stTitle` VARCHAR(100) NULL DEFAULT NULL,
  `stLinkPrefix` VARCHAR(45) NULL DEFAULT NULL COMMENT '- Prefixo do link ex.: http://www.',
  `stLinkDomain` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Domínio do link google.com',
  `stDescription` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Descrição do link',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Link_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'It can store some links for all purposes';

CREATE INDEX `idx_Link_stLinkDomain` ON `Link` (`stLinkDomain` ASC);

CREATE INDEX `idx_Link_stTitle` ON `Link` (`stTitle` ASC);


-- -----------------------------------------------------
-- Table `Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Company` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
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
  CONSTRAINT `fk_Company_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Table of companies for all purposes';

CREATE UNIQUE INDEX `idx_Company_stName_UNIQUE` ON `Company` (`stName` ASC);

CREATE INDEX `idx_Company_stAliasName` ON `Company` (`stAliasName` ASC);

CREATE INDEX `idx_Company_stRegistry` ON `Company` (`stRegistry` ASC);

CREATE INDEX `idx_Company_stRegistry2` ON `Company` (`stRegistry2` ASC);

CREATE INDEX `idx_Company_stArea` ON `Company` (`stArea` ASC);


-- -----------------------------------------------------
-- Table `Resource_has_Link`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Resource_has_Link` (
  `stResource` VARCHAR(45) NOT NULL,
  `Resource_Id` INT UNSIGNED NOT NULL,
  `Link_id` INT(10) UNSIGNED NOT NULL,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`Link_id`, `Resource_Id`, `stResource`),
  CONSTRAINT `fk_Resource_has_Link_Link1`
    FOREIGN KEY (`Link_id`)
    REFERENCES `Link` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Resource_has_Link_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between company and some links';


-- -----------------------------------------------------
-- Table `Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Product` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id do produto',
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Company_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'Id da empresa',
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
  `photo_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '- Id da foto principal do produto',
  `stLink` VARCHAR(255) NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Product_Company1`
    FOREIGN KEY (`Company_id`)
    REFERENCES `Company` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Product records';

CREATE INDEX `idx_Product_stName` ON `Product` (`stName` ASC);

CREATE INDEX `idx_Product_numPrice` ON `Product` (`numPrice` ASC);

CREATE INDEX `idx_Product_numDescount` ON `Product` (`numDescount` ASC);


-- -----------------------------------------------------
-- Table `Feature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Feature` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '- id do campo',
  `CoreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stGroup` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Group of related fields as color, size ...',
  `stLabel` VARCHAR(250) NULL DEFAULT NULL COMMENT 'The field name for exibition',
  `txtValue` TEXT NULL DEFAULT NULL COMMENT 'field value, can be anything',
  `enumType` ENUM('text','checkbox','radiobox','file','textarea','password') NULL DEFAULT NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ProductExtraField_User`
    FOREIGN KEY (`CoreUser_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Product features, fields to compare product by product';

CREATE INDEX `idx_Feature_stGroup` ON `Feature` (`stGroup` ASC);

CREATE INDEX `idx_Feature_stLabel` ON `Feature` (`stLabel` ASC);


-- -----------------------------------------------------
-- Table `Product_has_Feature`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Product_has_Feature` (
  `Product_id` INT(10) UNSIGNED NOT NULL COMMENT '- id do produto',
  `Feature_id` INT(10) UNSIGNED NOT NULL COMMENT '- Id da categoria',
  `CoreUser_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`Product_id`, `Feature_id`),
  CONSTRAINT `fk_Product_has_ProductExtraField_Product`
    FOREIGN KEY (`Product_id`)
    REFERENCES `Product` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_has_ProductExtraField_ProductExtraField`
    FOREIGN KEY (`Feature_id`)
    REFERENCES `Feature` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_has_ProductExtraField_User`
    FOREIGN KEY (`CoreUser_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between product record and the features';


-- -----------------------------------------------------
-- Table `Billing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Billing` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '- id da fatura',
  `User_idClient` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'Client id. He need to be registred',
  `User_idVendor` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'Saller id, if someone helped sell',
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
  CONSTRAINT `fk_Billing_User_Client`
    FOREIGN KEY (`User_idClient`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Billing_User_Vendor`
    FOREIGN KEY (`User_idVendor`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Sales revenue for products';

CREATE INDEX `idx_Billing_stVoucher` ON `Billing` (`stVoucher` ASC);

CREATE INDEX `idx_Billing_stTransactionCode` ON `Billing` (`stTransactionCode` ASC);

CREATE INDEX `idx_Billing_stPostCode` ON `Billing` (`stPostCode` ASC);


-- -----------------------------------------------------
-- Table `Billing_has_Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Billing_has_Product` (
  `Billing_id` INT(10) UNSIGNED NOT NULL COMMENT '- Id da fatura',
  `Product_id` INT(10) UNSIGNED NOT NULL COMMENT '- id do produto',
  `numPrice` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'Unit price',
  `numDescount` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'unit descount',
  `numQuantity` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'hou many products',
  `txtSpecification` TEXT NULL DEFAULT NULL COMMENT 'Product specification as color, size ...',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`Billing_id`, `Product_id`),
  CONSTRAINT `fk_Billing_has_Product_Product`
    FOREIGN KEY (`Product_id`)
    REFERENCES `Product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Billing_has_Product_Billing`
    FOREIGN KEY (`Billing_id`)
    REFERENCES `Billing` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between billing and products sold';


-- -----------------------------------------------------
-- Table `Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Menu` (
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
    REFERENCES `Menu` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coreMenu_coreUser`
    FOREIGN KEY (`coreUser_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Can be used for create dinamic menu in frontend';

CREATE INDEX `idx_coreMenu_stTitle` ON `Menu` (`stTitle` ASC);

CREATE INDEX `idx_coreMenu_stUrlDomain` ON `Menu` (`stUrlDomain` ASC);

CREATE UNIQUE INDEX `idx_coreMenu_stValue_UNIQUE` ON `Menu` (`stValue` ASC);


-- -----------------------------------------------------
-- Table `Section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Section` (
  `id` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Section_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL COMMENT 'Section father',
  `stArea` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Same a group',
  `stValue` VARCHAR(250) NOT NULL COMMENT 'Name used for this section',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Section_Section1`
    FOREIGN KEY (`Section_id`)
    REFERENCES `Section` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Section_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'This table can be used for create sections or areas in front' /* comment truncated */ /* end, bringing diferent content for each section*/;

CREATE UNIQUE INDEX `idx_Section_stValue_UNIQUE` ON `Section` (`stValue` ASC);

CREATE INDEX `idx_Section_stArea` ON `Section` (`stArea` ASC);


-- -----------------------------------------------------
-- Table `Route`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Route` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Section_id` SMALLINT(5) UNSIGNED NULL DEFAULT NULL,
  `Category_id` INT(10) UNSIGNED NULL DEFAULT NULL,
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
    FOREIGN KEY (`Category_id`)
    REFERENCES `Category` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coreRoute_coreSection1`
    FOREIGN KEY (`Section_id`)
    REFERENCES `Section` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_coreRoute_coreUser`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Can be used to create site map';

CREATE INDEX `idx_coreRoute_stTitle` ON `Route` (`stTitle` ASC);

CREATE INDEX `idx_coreRoute_stkeywords` ON `Route` (`stKeywords` ASC);

CREATE INDEX `idx_coreRoute_stSlung` ON `Route` (`stSlung` ASC);

CREATE INDEX `idx_coreRoute_stUri` ON `Route` (`stUri` ASC);


-- -----------------------------------------------------
-- Table `LogAccess`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LogAccess` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dtInsert` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record. The user registred',
  `txtCredentials` TEXT NOT NULL,
  `stSession` VARCHAR(255) NULL DEFAULT NULL,
  `stIP` VARCHAR(20) NULL DEFAULT NULL,
  `txtServer` TEXT NOT NULL,
  `stPriority` VARCHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_coreLogAccess_coreUser`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Records of access log';

CREATE INDEX `idx_LogAccess_dtInsert` ON `LogAccess` (`dtInsert` ASC);


-- -----------------------------------------------------
-- Table `LogEvent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LogEvent` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dtInsert` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stIP` VARCHAR(20) NULL DEFAULT NULL,
  `txtServer` TEXT NOT NULL,
  `stPriority` VARCHAR(1) NULL DEFAULT NULL,
  `stMsg` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_LogEvent_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Records of system event log';

CREATE INDEX `idx_LogEvent_dtInsert` ON `LogEvent` (`dtInsert` ASC);


-- -----------------------------------------------------
-- Table `LogSearch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LogSearch` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dtInsert` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stQuery` VARCHAR(250) NULL DEFAULT NULL,
  `numResults` INT(10) UNSIGNED NULL DEFAULT NULL,
  `stPriority` VARCHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Records of key words used in search action';

CREATE INDEX `idx_LogSearch_dtInsert` ON `LogSearch` (`dtInsert` ASC);

CREATE INDEX `idx_LogSearch_stQuery` ON `LogSearch` (`stQuery` ASC);


-- -----------------------------------------------------
-- Table `LogView`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LogView` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dtInsert` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stResource` VARCHAR(50) NULL DEFAULT NULL,
  `Resource_Id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `stUrl` VARCHAR(250) NULL DEFAULT NULL,
  `stPriority` VARCHAR(1) NULL DEFAULT NULL,
  `stIP` VARCHAR(20) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Records of view logs. Can be used for count view action for ' /* comment truncated */ /*all tables or modules*/;

CREATE INDEX `idx_LogView_dtInsert` ON `LogView` (`dtInsert` ASC);

CREATE INDEX `idx_LogView_stTable` ON `LogView` (`stResource` ASC);

CREATE INDEX `idx_LogView_numId` ON `LogView` (`Resource_Id` ASC);

CREATE INDEX `idx_LogView_stUrl` ON `LogView` (`stUrl` ASC);


-- -----------------------------------------------------
-- Table `LogClick`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LogClick` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `dtInsert` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stResource` VARCHAR(50) NULL DEFAULT NULL,
  `Resource_Id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `stUrl` VARCHAR(250) NULL DEFAULT NULL,
  `stPriority` VARCHAR(1) NULL DEFAULT NULL,
  `stIP` VARCHAR(20) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Log of click action. Can be used for all tables or modules';

CREATE INDEX `idx_LogClick_dtInsert` ON `LogClick` (`dtInsert` ASC);

CREATE INDEX `idx_LogClick_stTable` ON `LogClick` (`stResource` ASC);

CREATE INDEX `idx_LogClick_numId` ON `LogClick` (`Resource_Id` ASC);

CREATE INDEX `idx_LogClick_stUrl` ON `LogClick` (`stUrl` ASC);


-- -----------------------------------------------------
-- Table `File`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `File` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
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
  CONSTRAINT `fk_File_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'File is a table that records and manage upload files, as pdf' /* comment truncated */ /*, doc, xls, ppt and others, except images*/;

CREATE UNIQUE INDEX `idx_File_stTitle_stVersion_UNIQUE` ON `File` (`stVersion` ASC, `stTitle` ASC, `stFilePath` ASC);

CREATE INDEX `idx_File_dtPublish` ON `File` (`dtPublish` ASC);


-- -----------------------------------------------------
-- Table `Newsletter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Newsletter` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '- id do produto',
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'If registred, it is the user id',
  `stName` VARCHAR(255) NOT NULL COMMENT 'Name used for contact',
  `stEmail` VARCHAR(255) NOT NULL COMMENT 'e-mail account used for contact',
  `txtInterest` TEXT NULL COMMENT 'A json data containig a list of subjects',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Newsletter_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Record the customer intention of receive newsletter from thi' /* comment truncated */ /*s system*/;

CREATE INDEX `idx_Newsletter_stName` ON `Newsletter` (`stName` ASC);

CREATE INDEX `idx_Newsletter_stEmail` ON `Newsletter` (`stEmail` ASC);

CREATE UNIQUE INDEX `idx_Newsletter_stEmail_UNIQUE` ON `Newsletter` (`stEmail` ASC);


-- -----------------------------------------------------
-- Table `Product_has_Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Product_has_Product` (
  `Product_id` INT(10) UNSIGNED NOT NULL COMMENT 'id do produto',
  `ProductRel_id` INT(10) UNSIGNED NOT NULL COMMENT 'Produto relacionado',
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`ProductRel_id`, `Product_id`),
  CONSTRAINT `fk_Product_has_Product_Product`
    FOREIGN KEY (`Product_id`)
    REFERENCES `Product` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_has_Product_ProductRel`
    FOREIGN KEY (`ProductRel_id`)
    REFERENCES `Product` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_has_Product_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Products recomended';

CREATE INDEX `fk_Product_has_Product_ProductRel_idx` ON `Product_has_Product` (`ProductRel_id` ASC);


-- -----------------------------------------------------
-- Table `Voucher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Voucher` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '- id da fatura',
  `stCode` VARCHAR(250) NOT NULL COMMENT 'Promotional code to give some sale descount',
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `User_idClient` INT(10) UNSIGNED NULL COMMENT 'The registred client id',
  `numValue` DECIMAL(10,3) NULL DEFAULT NULL COMMENT 'Descount value',
  `stOrigin` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Origin of voucher, supplier, promotion ...',
  `dtValid` TIMESTAMP NULL DEFAULT NULL COMMENT 'expirate date for this code',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Voucher_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Voucher_UserClient`
    FOREIGN KEY (`User_idClient`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'This is a voucher control, that containing all of voucher co' /* comment truncated */ /*de distributed to give a sells discount*/;

CREATE INDEX `idx_Voucher_stOrigin` ON `Voucher` (`stOrigin` ASC);

CREATE UNIQUE INDEX `idx_Voucehr_stCode_UNIQUE` ON `Voucher` (`stCode` ASC);


-- -----------------------------------------------------
-- Table `Faq`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Faq` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stQuestion` VARCHAR(250) NULL DEFAULT NULL COMMENT 'Título que identifica o classificado',
  `txtAnswer` TEXT NULL DEFAULT NULL COMMENT 'Conteúdo do classificado',
  `stKeywords` VARCHAR(255) NULL DEFAULT NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Faq_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Frequent Ask Question, is a table with questions and answers' /* comment truncated */ /* to show in a frontend area*/;

CREATE INDEX `idx_Faq_stQuestion` ON `Faq` (`stQuestion` ASC);


-- -----------------------------------------------------
-- Table `InviteKey`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `InviteKey` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL COMMENT 'User owner or the user that created this record.' /* comment truncated */ /*The user that need to check autenticity.*/,
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
  CONSTRAINT `fk_InviteKey_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'InviteKey can be used to verify e-mail account before activa' /* comment truncated */ /*te an user or to give access for some section of the system once*/;

CREATE INDEX `idx_InviteKey_stKey` ON `InviteKey` (`stKey` ASC);

CREATE INDEX `idx_InviteKey_dtValid` ON `InviteKey` (`dtValid` ASC);

CREATE INDEX `idx_InviteKey_dtActivate` ON `InviteKey` (`dtActivate` ASC);


-- -----------------------------------------------------
-- Table `Pref`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pref` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL COMMENT 'User owner or the user that created this record',
  `stModule` VARCHAR(50) NULL DEFAULT NULL COMMENT 'Module name or idendifier',
  `stTable` VARCHAR(50) NULL DEFAULT NULL COMMENT 'DB Table name',
  `numRecord_id` INT UNSIGNED NULL DEFAULT NULL COMMENT 'DB Table record id',
  `txtPref` TEXT NULL DEFAULT NULL COMMENT 'A json data pref for som table, record or module in the system',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Pref_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'CorePref can be used to store module, table or record prefer' /* comment truncated */ /*ence, as number of display records, template, color, order, size, time, css, js, js function, plugin ... It is always a json data*/;

CREATE INDEX `idx_Pref_stTable` ON `Pref` (`stTable` ASC);

CREATE INDEX `idx_Pref_stModule` ON `Pref` (`stModule` ASC);

CREATE INDEX `idx_Pref_numRecord_id` ON `Pref` (`numRecord_id` ASC);


-- -----------------------------------------------------
-- Table `Service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Service` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Id do produto',
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `Company_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'Id da empresa',
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
  `photo_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT '- Id da foto principal do produto',
  `stLink` VARCHAR(255) NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Service_Company`
    FOREIGN KEY (`Company_id`)
    REFERENCES `Company` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Service_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Service records';

CREATE INDEX `idx_Service_stName` ON `Service` (`stName` ASC);

CREATE INDEX `idx_Service_numPrice` ON `Service` (`numPrice` ASC);

CREATE INDEX `idx_Service_numDescount` ON `Service` (`numDescount` ASC);


-- -----------------------------------------------------
-- Table `Address_has_ZipCode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Address_has_ZipCode` (
  `Address_id` INT(10) UNSIGNED NOT NULL,
  `ZipCode_id` INT(10) UNSIGNED NOT NULL,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`Address_id`, `ZipCode_id`),
  CONSTRAINT `fk_Address_has_ZipCode_Address`
    FOREIGN KEY (`Address_id`)
    REFERENCES `Address` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_has_ZipCode_ZipCode`
    FOREIGN KEY (`ZipCode_id`)
    REFERENCES `ZipCode` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Address_has_ZipCode_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A relationship between addrAddress and addrZipCode, because ' /* comment truncated */ /*a street can have more than 1 Zip Code.*/;


-- -----------------------------------------------------
-- Table `File_has_User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `File_has_User` (
  `File_id` INT(10) UNSIGNED NOT NULL COMMENT '- id do produto',
  `User_id` INT(10) UNSIGNED NOT NULL COMMENT '- Id da categoria',
  `dtLastAccess` TIMESTAMP NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`File_id`, `User_id`),
  CONSTRAINT `fk_File_has_User_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_File_has_User_File`
    FOREIGN KEY (`File_id`)
    REFERENCES `File` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between file and its category';

CREATE INDEX `fk_File_has_User_File_idx` ON `File_has_User` (`File_id` ASC);


-- -----------------------------------------------------
-- Table `Category_has_Resource`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Category_has_Resource` (
  `Category_id` INT(10) UNSIGNED NOT NULL,
  `stResource` VARCHAR(100) NOT NULL,
  `Resource_id` INT(10) UNSIGNED NOT NULL,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`Category_id`, `Resource_id`),
  CONSTRAINT `fk_Category_has_Resource_Category`
    FOREIGN KEY (`Category_id`)
    REFERENCES `Category` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Category_has_Resource_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between categories and any resource row';


-- -----------------------------------------------------
-- Table `Ratio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ratio` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `stResource` VARCHAR(45) NOT NULL,
  `Resource_id` INT UNSIGNED NOT NULL,
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

CREATE INDEX `idx_Ratio_stResource` ON `Ratio` (`stResource` ASC);

CREATE INDEX `idx_Ratio_Resoutce_id` ON `Ratio` (`Resource_id` ASC);

CREATE INDEX `idx_Ratio_numRate1` ON `Ratio` (`numRate1` ASC);

CREATE INDEX `idx_Ratio_numRate2` ON `Ratio` (`numRate2` ASC);

CREATE INDEX `idx_Ratio_numRate3` ON `Ratio` (`numRate3` ASC);

CREATE INDEX `idx_Ratio_numRate4` ON `Ratio` (`numRate4` ASC);

CREATE INDEX `idx_Ratio_numRate5` ON `Ratio` (`numRate5` ASC);


-- -----------------------------------------------------
-- Table `CallAnalyser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CallAnalyser` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT UNSIGNED NULL,
  `stCallCode` VARCHAR(45) NULL,
  `stType` VARCHAR(45) NULL,
  `dtCall` DATE NULL,
  `tmStartCall` TIME NULL,
  `tmEndCall` TIME NULL,
  `tmTime` TIME NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT 0,
  `isActive` ENUM('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Integration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Integration` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT UNSIGNED NULL,
  `stSystem` VARCHAR(45) NOT NULL,
  `stSystemId` INT UNSIGNED NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT 0,
  `isActive` ENUM('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Invoice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Invoice` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT UNSIGNED NULL,
  `stCallCode` VARCHAR(45) NULL,
  `stType` VARCHAR(45) NULL,
  `dtCall` DATE NULL,
  `tmStartCall` TIME NULL,
  `tmEndCall` TIME NULL,
  `tmTime` TIME NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT 0,
  `isActive` ENUM('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Resource_has_Ratio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Resource_has_Ratio` (
  `stResource` VARCHAR(45) NOT NULL,
  `Resource_Id` INT UNSIGNED NOT NULL,
  `Ratio_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT UNSIGNED NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '1',
  PRIMARY KEY (`stResource`, `Resource_Id`, `Ratio_id`),
  CONSTRAINT `fk_Resource_has_Ratio_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Resource_has_Ratio_Ratio`
    FOREIGN KEY (`Ratio_id`)
    REFERENCES `Ratio` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE INDEX `idx_Resource_has_Ratio_Ratio_id` ON `Resource_has_Ratio` (`Ratio_id` ASC);


-- -----------------------------------------------------
-- Table `Photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Photo` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stTitle` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Titulo da foto',
  `stDescription` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Descrição da foto',
  `stSource` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Fonte da foto, autor ...',
  `stPath` VARCHAR(250) NULL DEFAULT NULL COMMENT '- Caminho para o arquivo físico (Nome do arquivo)',
  `stTags` VARCHAR(250) NULL DEFAULT NULL,
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '- É ativo: 0 (inativo) | 1 (ativo)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Photo_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A base of images and photos';

CREATE INDEX `idx_Photo_stTitle` ON `Photo` (`stTitle` ASC);


-- -----------------------------------------------------
-- Table `Gallery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gallery` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `stTitle` VARCHAR(250) NULL DEFAULT NULL,
  `stDescription` VARCHAR(250) NULL DEFAULT NULL,
  `stKeywords` VARCHAR(255) NULL DEFAULT NULL,
  `photo_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'Cover photo for this gallery',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Gallery_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gallery_Photo`
    FOREIGN KEY (`photo_id`)
    REFERENCES `Photo` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Gallery of photos';

CREATE INDEX `idx_Gallery_stTitle` ON `Gallery` (`stTitle` ASC);


-- -----------------------------------------------------
-- Table `Gallery_has_Photo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Gallery_has_Photo` (
  `Gallery_id` INT(10) UNSIGNED NOT NULL,
  `Photo_id` INT(10) UNSIGNED NOT NULL,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`Gallery_id`, `Photo_id`),
  CONSTRAINT `fk_Gallery_has_Photo_Gallery1`
    FOREIGN KEY (`Gallery_id`)
    REFERENCES `Gallery` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gallery_has_Photo_Photo1`
    FOREIGN KEY (`Photo_id`)
    REFERENCES `Photo` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gallery_has_Photo_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between gallery and its photos';

CREATE INDEX `fk_Gallery_has_Photo_Gallery1_idx` ON `Gallery_has_Photo` (`Gallery_id` ASC);


-- -----------------------------------------------------
-- Table `Resource_has_Gallery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Resource_has_Gallery` (
  `stResource` VARCHAR(45) NOT NULL,
  `Resource_id` INT UNSIGNED NOT NULL,
  `Gallery_id` INT(10) UNSIGNED NOT NULL,
  `User_id` INT(10) UNSIGNED NULL DEFAULT NULL COMMENT 'User owner or the user that created this record',
  `dtInsert` TIMESTAMP NULL DEFAULT NULL,
  `dtUpdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numStatus` TINYINT(4) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'It represents the record situation (ex.: active, new, blocked, deleted, etc)',
  `isActive` ENUM('0','1') NOT NULL DEFAULT '0' COMMENT '0 (desable) | 1 (active)',
  PRIMARY KEY (`Gallery_id`, `Resource_id`, `stResource`),
  CONSTRAINT `fk_Gallery_has_Photo_Gallery10`
    FOREIGN KEY (`Gallery_id`)
    REFERENCES `Gallery` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Gallery_has_Photo_User0`
    FOREIGN KEY (`User_id`)
    REFERENCES `User` (`id`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relationship between resources and gallery';

CREATE INDEX `fk_Gallery_has_Photo_Gallery1_idx` ON `Resource_has_Gallery` (`Gallery_id` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `Person`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Person` (`id`, `coreUser_id`, `stName`, `enumGender`, `dtBirthdate`, `stCitizenId`, `stDoc2`, `stPassport`, `stNationality`, `txtData`, `dtInsert`, `dtUpdate`, `numStatus`, `isActive`) VALUES (NULL, 1, 'Administrator NTG', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1');

COMMIT;


-- -----------------------------------------------------
-- Data for table `User`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `User` (`id`, `User_id`, `Person_id`, `Group_id`, `stUsername`, `stPassword`, `txtUserRole`, `txtUserPref`, `isSystem`, `dtInsert`, `dtUpdate`, `numStatus`, `isActive`) VALUES (NULL, 1, NULL, 1, 'admin@novatagti.com', '111qqqAAA', NULL, NULL, '1', NULL, NULL, 0, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Group`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `Group` (`id`, `User_id`, `Group_id`, `stName`, `stLabel`, `isSystem`, `txtGroupRole`, `txtGroupPref`, `dtInsert`, `dtUpdate`, `numStatus`, `isActive`) VALUES (NULL, 1, NULL, 'admin', 'Administrator', '1', NULL, NULL, NULL, NULL, 0, '1');

COMMIT;

