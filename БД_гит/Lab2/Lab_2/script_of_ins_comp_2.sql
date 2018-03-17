-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ins_companies
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ins_companies
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ins_companies` DEFAULT CHARACTER SET utf8 ;
USE `ins_companies` ;

-- -----------------------------------------------------
-- Table `ins_companies`.`branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ins_companies`.`branch` (
  `ID` INT(11) NOT NULL COMMENT 'ID of each company, that is a primary key',
  `BRANCH_NAME` VARCHAR(50) NOT NULL COMMENT 'The name of each company',
  `ADRESS` VARCHAR(50) NOT NULL COMMENT 'Each company has an adress',
  `PHONE_NUMBER` INT(11) NOT NULL COMMENT 'Each company has its phone number',
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'A table that describes the branches of insurance companies w';


-- -----------------------------------------------------
-- Table `ins_companies`.`agent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ins_companies`.`agent` (
  `ID` INT(11) NOT NULL,
  `NAME` VARCHAR(50) NOT NULL,
  `FAM` VARCHAR(50) NOT NULL,
  `PATRONYMIC` VARCHAR(50) NOT NULL,
  `ADRESS` VARCHAR(50) NOT NULL,
  `PHONE_NUMBER` INT(11) NOT NULL,
  `MONEY` INT(11) NOT NULL,
  `BRANCH_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_agent_branch1_idx` (`BRANCH_ID` ASC),
  CONSTRAINT `fk_agent_branch1`
    FOREIGN KEY (`BRANCH_ID`)
    REFERENCES `ins_companies`.`branch` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'We should have information about agents because they create contracts with their clients ';


-- -----------------------------------------------------
-- Table `ins_companies`.`type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ins_companies`.`type` (
  `ID` INT(11) NOT NULL,
  `TYPE_NAME` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'The table wich describes the type of ins_c';


-- -----------------------------------------------------
-- Table `ins_companies`.`contract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ins_companies`.`contract` (
  `ID` INT(11) NOT NULL,
  `CONTRACT_NUM` INT(11) NOT NULL COMMENT 'The number of each contract. Usually unique but can have the same ones ',
  `INS_SUM` INT(11) NOT NULL,
  `TARRIF_RATE` INT(11) NOT NULL,
  `CONCLUSION_DATE` DATE NOT NULL COMMENT 'The date when the contract was created',
  `BRANCH_ID` INT(11) NOT NULL,
  `INS_TYPE_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_contract_branch_idx` (`BRANCH_ID` ASC),
  INDEX `fk_contract_type1_idx` (`INS_TYPE_ID` ASC),
  CONSTRAINT `fk_contract_branch`
    FOREIGN KEY (`BRANCH_ID`)
    REFERENCES `ins_companies`.`branch` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contract_type1`
    FOREIGN KEY (`INS_TYPE_ID`)
    REFERENCES `ins_companies`.`type` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'The table which describes the main information needed for co';


-- -----------------------------------------------------
-- Table `ins_companies`.`money`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ins_companies`.`money` (
  `ID` INT(11) NOT NULL,
  `INS_SUM` INT(11) NOT NULL,
  `TARRIF_RATE` INT(11) NOT NULL,
  `MONEY` INT(11) NOT NULL,
  `CONTRACT_ID` INT(11) NOT NULL,
  `AGENT_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC),
  INDEX `fk_money_contract1_idx` (`CONTRACT_ID` ASC),
  INDEX `fk_money_agent1_idx` (`AGENT_ID` ASC),
  CONSTRAINT `fk_money_contract1`
    FOREIGN KEY (`CONTRACT_ID`)
    REFERENCES `ins_companies`.`contract` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_money_agent1`
    FOREIGN KEY (`AGENT_ID`)
    REFERENCES `ins_companies`.`agent` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'The table which describes points, which are necessary for counting salary for agents';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
