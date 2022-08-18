

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Insurance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Insurance` (
  `Insurance_id` INT NOT NULL,
  `Insurance_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`Insurance_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `Patient_id` INT NOT NULL,
  `Patient_Lname` VARCHAR(45) NULL,
  `Patient_Fname` VARCHAR(45) NULL,
  `Gender` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Contact` VARCHAR(45) NULL,
  `Insurance_id` INT NOT NULL,
  PRIMARY KEY (`Patient_id`),
  INDEX `fk_Patient_Insurance1_idx` (`Insurance_id` ASC) VISIBLE,
  CONSTRAINT `fk_Patient_Insurance1`
    FOREIGN KEY (`Insurance_id`)
    REFERENCES `mydb`.`Insurance` (`Insurance_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Hospital`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Hospital` (
  `Hospital_Name` VARCHAR(45) NULL,
  `Hospital_Contact` VARCHAR(45) NULL,
  `Hospital_Address` VARCHAR(45) NULL,
  `Hospital_id` INT NOT NULL,
  PRIMARY KEY (`Hospital_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `Doctor_id` INT NOT NULL,
  `Doctor_Lname` VARCHAR(45) NULL,
  `Doctor_Fname` VARCHAR(45) NULL,
  `Specialization` VARCHAR(45) NULL,
  `Hospital_id` INT NOT NULL,
  PRIMARY KEY (`Doctor_id`),
  INDEX `fk_Doctor_Hospital1_idx` (`Hospital_id` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_Hospital1`
    FOREIGN KEY (`Hospital_id`)
    REFERENCES `mydb`.`Hospital` (`Hospital_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `Employee_id` INT NOT NULL,
  `Employee_Lname` VARCHAR(45) NULL,
  `Employee_Fname` VARCHAR(45) NULL,
  `Employee_Contact` VARCHAR(45) NULL,
  `Employee_Address` VARCHAR(45) NULL,
  `Hospital_id` INT NOT NULL,
  PRIMARY KEY (`Employee_id`),
  INDEX `fk_Employee_Hospital1_idx` (`Hospital_id` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Hospital1`
    FOREIGN KEY (`Hospital_id`)
    REFERENCES `mydb`.`Hospital` (`Hospital_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medicine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medicine` (
  `Medicine_Name` VARCHAR(45) NULL,
  `Medicine_id` INT NOT NULL,
  PRIMARY KEY (`Medicine_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Services` (
  `Service_Name` VARCHAR(45) NULL,
  `Service_Fee` INT NULL,
  `Hospital_id` INT NOT NULL,
  `Service_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Service_id`),
  INDEX `fk_Services_Hospital1_idx` (`Hospital_id` ASC) VISIBLE,
  CONSTRAINT `fk_Services_Hospital1`
    FOREIGN KEY (`Hospital_id`)
    REFERENCES `mydb`.`Hospital` (`Hospital_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointment` (
  `Appointment_id` INT NOT NULL,
  `Appointment_Date` DATE NULL,
  `Appointment_Time` TIME NULL,
  `Patient_id` INT NOT NULL,
  `Doctor_id` INT NOT NULL,
  `Hospital_id` INT NOT NULL,
  `Service_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Appointment_id`),
  INDEX `fk_Appointment_Patient_idx` (`Patient_id` ASC) VISIBLE,
  INDEX `fk_Appointment_Doctor1_idx` (`Doctor_id` ASC) VISIBLE,
  INDEX `fk_Appointment_Hospital1_idx` (`Hospital_id` ASC) VISIBLE,
  INDEX `fk_Appointment_Services1_idx` (`Service_id` ASC) VISIBLE,
  CONSTRAINT `fk_Appointment_Patient`
    FOREIGN KEY (`Patient_id`)
    REFERENCES `mydb`.`Patient` (`Patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Doctor1`
    FOREIGN KEY (`Doctor_id`)
    REFERENCES `mydb`.`Doctor` (`Doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Hospital1`
    FOREIGN KEY (`Hospital_id`)
    REFERENCES `mydb`.`Hospital` (`Hospital_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointment_Services1`
    FOREIGN KEY (`Service_id`)
    REFERENCES `mydb`.`Services` (`Service_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Billing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Billing` (
  `Billing_id` INT NOT NULL,
  `Date_Due` DATE NULL,
  `Date_Paid` DATE NULL,
  `Current_Balance` INT NULL,
  `Patient_id` INT NOT NULL,
  PRIMARY KEY (`Billing_id`),
  INDEX `fk_Billing_Patient1_idx` (`Patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_Billing_Patient1`
    FOREIGN KEY (`Patient_id`)
    REFERENCES `mydb`.`Patient` (`Patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Treatment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Treatment` (
  `Treatment_id` INT NOT NULL,
  `Treatment_Result` VARCHAR(45) NULL,
  `Appointment_id` INT NOT NULL,
  `Billing_id` INT NOT NULL,
  PRIMARY KEY (`Treatment_id`),
  INDEX `fk_Treatment_Appointment1_idx` (`Appointment_id` ASC) VISIBLE,
  INDEX `fk_Treatment_Billing1_idx` (`Billing_id` ASC) VISIBLE,
  CONSTRAINT `fk_Treatment_Appointment1`
    FOREIGN KEY (`Appointment_id`)
    REFERENCES `mydb`.`Appointment` (`Appointment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Treatment_Billing1`
    FOREIGN KEY (`Billing_id`)
    REFERENCES `mydb`.`Billing` (`Billing_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Treatment_Report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Treatment_Report` (
  `Med_Quantity` INT NOT NULL,
  `Treatment_id` INT NOT NULL,
  `Medicine_id` INT NOT NULL,
  PRIMARY KEY (`Med_Quantity`),
  INDEX `fk_Treatment_Report_Treatment1_idx` (`Treatment_id` ASC) VISIBLE,
  INDEX `fk_Treatment_Report_Medicine1_idx` (`Medicine_id` ASC) VISIBLE,
  CONSTRAINT `fk_Treatment_Report_Treatment1`
    FOREIGN KEY (`Treatment_id`)
    REFERENCES `mydb`.`Treatment` (`Treatment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Treatment_Report_Medicine1`
    FOREIGN KEY (`Medicine_id`)
    REFERENCES `mydb`.`Medicine` (`Medicine_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Insurance_Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Insurance_Payment` (
  `Billing_id` INT NOT NULL,
  `Insurance_id` INT NOT NULL,
  `Deductible_Applied` VARCHAR(45) NULL,
  INDEX `fk_Billing_has_Insurance_Insurance1_idx` (`Insurance_id` ASC) VISIBLE,
  INDEX `fk_Billing_has_Insurance_Billing1_idx` (`Billing_id` ASC) VISIBLE,
  PRIMARY KEY (`Billing_id`),
  CONSTRAINT `fk_Billing_has_Insurance_Billing1`
    FOREIGN KEY (`Billing_id`)
    REFERENCES `mydb`.`Billing` (`Billing_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Billing_has_Insurance_Insurance1`
    FOREIGN KEY (`Insurance_id`)
    REFERENCES `mydb`.`Insurance` (`Insurance_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
