-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema task_manager
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema task_manager
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `task_manager` DEFAULT CHARACTER SET utf8 COLLATE utf8_polish_ci ;
USE `task_manager` ;

-- -----------------------------------------------------
-- Table `task_manager`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `task_manager`.`category` (
  `category_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;


-- -----------------------------------------------------
-- Table `task_manager`.`task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `task_manager`.`task` (
  `task_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`task_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;


-- -----------------------------------------------------
-- Table `task_manager`.`subtask`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `task_manager`.`subtask` (
  `subtask_id` INT(11) NOT NULL AUTO_INCREMENT,
  `description` TEXT NOT NULL,
  `date_start` DATE NOT NULL,
  `date_stop` DATE NOT NULL,
  `task_id` INT(11) NOT NULL,
  PRIMARY KEY (`subtask_id`),
  INDEX `task_id` (`task_id` ASC) VISIBLE,
  CONSTRAINT `subtask_ibfk_1`
    FOREIGN KEY (`task_id`)
    REFERENCES `task_manager`.`task` (`task_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;


-- -----------------------------------------------------
-- Table `task_manager`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `task_manager`.`user` (
  `user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;


-- -----------------------------------------------------
-- Table `task_manager`.`subtask_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `task_manager`.`subtask_user` (
  `subtask_user_id` INT(11) NOT NULL AUTO_INCREMENT,
  `subtask_id` INT(11) NULL DEFAULT NULL,
  `user_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`subtask_user_id`),
  INDEX `subtask_id` (`subtask_id` ASC) VISIBLE,
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `subtask_user_ibfk_1`
    FOREIGN KEY (`subtask_id`)
    REFERENCES `task_manager`.`subtask` (`subtask_id`),
  CONSTRAINT `subtask_user_ibfk_2`
    FOREIGN KEY (`user_id`)
    REFERENCES `task_manager`.`user` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;


-- -----------------------------------------------------
-- Table `task_manager`.`task_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `task_manager`.`task_category` (
  `task_category_id` INT(11) NOT NULL AUTO_INCREMENT,
  `task_id` INT(11) NULL DEFAULT NULL,
  `category_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`task_category_id`),
  INDEX `task_id` (`task_id` ASC) VISIBLE,
  INDEX `category_id` (`category_id` ASC) VISIBLE,
  CONSTRAINT `task_category_ibfk_1`
    FOREIGN KEY (`task_id`)
    REFERENCES `task_manager`.`task` (`task_id`),
  CONSTRAINT `task_category_ibfk_2`
    FOREIGN KEY (`category_id`)
    REFERENCES `task_manager`.`category` (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_polish_ci;


-- -----------------------------------------------------
-- Table `task_manager`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `task_manager`.`role` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `task_manager`.`user_role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `task_manager`.`user_role` (
  `role_id` INT NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`role_id`, `user_id`),
  INDEX `fk_role_has_user_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_role_has_user_role1_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_role_has_user_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `task_manager`.`role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `task_manager`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `task_manager`.`role`
-- -----------------------------------------------------
START TRANSACTION;
USE `task_manager`;
INSERT INTO `task_manager`.`role` (`role_id`, `role_name`) VALUES (DEFAULT, 'ROLE_USER');
INSERT INTO `task_manager`.`role` (`role_id`, `role_name`) VALUES (DEFAULT, 'ROLE_ADMIN');
INSERT INTO `task_manager`.`role` (`role_id`, `role_name`) VALUES (DEFAULT, 'ROLE_MODERATOR');

COMMIT;

