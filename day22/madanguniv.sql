-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema madanguniv
-- -----------------------------------------------------
-- 마당대학 모델링

-- -----------------------------------------------------
-- Schema madanguniv
--
-- 마당대학 모델링
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `madanguniv` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `madanguniv` ;

-- -----------------------------------------------------
-- Table `madanguniv`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madanguniv`.`professor` (
  `ssn` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `age` INT NULL,
  `rank` VARCHAR(20) NOT NULL,
  `speciality` VARCHAR(40) NULL,
  PRIMARY KEY (`ssn`))
ENGINE = MyISAM;


-- -----------------------------------------------------
-- Table `madanguniv`.`dept`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madanguniv`.`dept` (
  `dno` INT NOT NULL,
  `dname` VARCHAR(45) NOT NULL,
  `office` VARCHAR(45) NULL,
  `runprofessorssn` INT NOT NULL,
  PRIMARY KEY (`dno`),
  INDEX `fk_dept_professor_idx` (`runprofessorssn` ASC) VISIBLE,
  CONSTRAINT `fk_dept_professor`
    FOREIGN KEY (`runprofessorssn`)
    REFERENCES `madanguniv`.`professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madanguniv`.`graduate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madanguniv`.`graduate` (
  `ssn` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `age` INT NULL,
  `deg_prog` VARCHAR(45) NULL,
  `dno` INT NOT NULL,
  `graduatessn` INT NOT NULL,
  PRIMARY KEY (`ssn`),
  INDEX `fk_graduate_dept1_idx` (`dno` ASC) VISIBLE,
  INDEX `fk_graduate_graduate1_idx` (`graduatessn` ASC) VISIBLE,
  CONSTRAINT `fk_graduate_dept1`
    FOREIGN KEY (`dno`)
    REFERENCES `madanguniv`.`dept` (`dno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_graduate_graduate1`
    FOREIGN KEY (`graduatessn`)
    REFERENCES `madanguniv`.`graduate` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madanguniv`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madanguniv`.`project` (
  `pid` INT NOT NULL,
  `pname` VARCHAR(50) NOT NULL,
  `sponsor` VARCHAR(45) NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `budget` INT NULL,
  `managessn` INT NOT NULL,
  PRIMARY KEY (`pid`),
  INDEX `fk_project_professor1_idx` (`managessn` ASC) VISIBLE,
  CONSTRAINT `fk_project_professor1`
    FOREIGN KEY (`managessn`)
    REFERENCES `madanguniv`.`professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madanguniv`.`work_dept`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madanguniv`.`work_dept` (
  `professor_ssn` INT NOT NULL,
  `dept_dno` INT NOT NULL,
  `pct_time` INT NOT NULL,
  PRIMARY KEY (`professor_ssn`, `dept_dno`),
  INDEX `fk_work_dept_dept1_idx` (`dept_dno` ASC) VISIBLE,
  CONSTRAINT `fk_work_dept_professor1`
    FOREIGN KEY (`professor_ssn`)
    REFERENCES `madanguniv`.`professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_work_dept_dept1`
    FOREIGN KEY (`dept_dno`)
    REFERENCES `madanguniv`.`dept` (`dno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madanguniv`.`work_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madanguniv`.`work_in` (
  `professor_ssn` INT NOT NULL,
  `project_pid` INT NOT NULL,
  PRIMARY KEY (`professor_ssn`, `project_pid`),
  INDEX `fk_work_in_project1_idx` (`project_pid` ASC) VISIBLE,
  CONSTRAINT `fk_work_in_professor1`
    FOREIGN KEY (`professor_ssn`)
    REFERENCES `madanguniv`.`professor` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_work_in_project1`
    FOREIGN KEY (`project_pid`)
    REFERENCES `madanguniv`.`project` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madanguniv`.`work_prog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madanguniv`.`work_prog` (
  `project_pid` INT NOT NULL,
  `graduate_ssn` INT NOT NULL,
  PRIMARY KEY (`project_pid`, `graduate_ssn`),
  INDEX `fk_work_prog_graduate1_idx` (`graduate_ssn` ASC) VISIBLE,
  CONSTRAINT `fk_work_prog_project1`
    FOREIGN KEY (`project_pid`)
    REFERENCES `madanguniv`.`project` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_work_prog_graduate1`
    FOREIGN KEY (`graduate_ssn`)
    REFERENCES `madanguniv`.`graduate` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
