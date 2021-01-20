
-- drop database gradebook;
-- create database gradebook;

use gradebook;

CREATE TABLE `user_account` (
  `user_id` int PRIMARY KEY auto_increment,
  `username` varchar(255),
  `password` varchar(255),
  `user_type_id` int
);

CREATE TABLE `user_types` (
  `user_type_id` int PRIMARY KEY auto_increment,
  `user_type` varchar(255)
);

CREATE TABLE `parent` (
  `user_id` int UNIQUE NOT NULL,
  `user_ssn` varchar(255),
  `first_name` varchar(255),
  `last_name` varchar(255),
  `email` varchar(255),
  `phone_number` varchar(255)
);

CREATE TABLE `student` (
  `student_id` int PRIMARY KEY auto_increment,
  `user_ssn` varchar(255),
  `user_id` int unique NOT NULL,
  `class_id` int,
  `first_name` varchar(255),
  `last_name` varchar(255),
  `email` varchar(255),
  `address` text
);

CREATE TABLE `parent_allocation` (
  `parent_allocation_id` int PRIMARY KEY auto_increment,
  `student_user_id` int,
  `parent_user_id` int
);

CREATE TABLE `teacher` (
  `user_id` int UNIQUE NOT NULL,
  `user_ssn` varchar(255),
  `first_name` varchar(255),
  `last_name` varchar(255),
  `email` varchar(255),
  `phone_number` varchar(255),
  `is_class_master` boolean
);

CREATE TABLE `admin` (
  `user_id` int NOT NULL,
  `user_ssn` varchar(255),
  `first_name` varchar(255),
  `last_name` varchar(255),
  `admin_type_id` int
);

CREATE TABLE `admin_type` (
  `admin_type_id` int PRIMARY KEY auto_increment,
  `admin_type` varchar(255)
);

CREATE TABLE `examination` (
  `examination_id` int PRIMARY KEY auto_increment,
  `student_user_id` int,
  `teacher_user_id` int,
  `subject_id` int,
  `examination_type_id` int,
  `examination_date` date
);

CREATE TABLE `examination_type` (
  `examination_type_id` int PRIMARY KEY auto_increment,
  `examination_type` varchar(255)
);

CREATE TABLE `grade` (
  `examination_id` int,
  `score` int,
  `student_feedback` varchar(255),
  `parent_feedback` varchar(255)
);

CREATE TABLE `class` (
  `class_id` int PRIMARY KEY auto_increment,
  `year` int,
  `name` varchar(255),
  `class_master_id` int UNIQUE,
  `specialization_id` int
);

CREATE TABLE `specialization` (
  `spec_id` int PRIMARY KEY auto_increment,
  `spec_name` varchar(255)
);

CREATE TABLE `subject` (
  `subject_id` int PRIMARY KEY auto_increment,
  `subject_name` varchar(255)
);

CREATE TABLE `teacher_allocation` (
  `teacher_allocation_id` int PRIMARY KEY auto_increment,
  `teacher_user_id` int,
  `subject_id` int
);

CREATE TABLE `mean_grade` (
  `mean_grade_id` int PRIMARY KEY auto_increment,
  `student_user_id` int,
  `teacher_user_id` int,
  `subject_id` int,
  `semester` int,
  `score` double
);

CREATE TABLE `class_allocation` (
  `class_allocation_id` int PRIMARY KEY auto_increment,
  `class_id` int,
  `teacher_user_id` int,
  `subject_id` int
);

CREATE TABLE `log` (
  `log_id` int PRIMARY KEY auto_increment,
  `log_type_id` int,
  `user_id` int,
  `log_date` date
);

CREATE TABLE `log_type` (
  `log_type_id` int PRIMARY KEY auto_increment,
  `log_type` VARCHAR(255)
);

use gradebook;

ALTER TABLE `class_allocation` ADD FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`);

ALTER TABLE `class_allocation` ADD FOREIGN KEY (`teacher_user_id`) REFERENCES `teacher` (`user_id`);

ALTER TABLE `class_allocation` ADD FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`);

ALTER TABLE `parent` ADD FOREIGN KEY (`user_id`) REFERENCES `user_account` (`user_id`);

ALTER TABLE `student` ADD FOREIGN KEY (`user_id`) REFERENCES `user_account` (`user_id`);

ALTER TABLE `teacher` ADD FOREIGN KEY (`user_id`) REFERENCES `user_account` (`user_id`);

ALTER TABLE `admin` ADD FOREIGN KEY (`user_id`) REFERENCES `user_account` (`user_id`);

ALTER TABLE `log` ADD FOREIGN KEY (`user_id`) REFERENCES `user_account` (`user_id`);

ALTER TABLE `log` ADD FOREIGN KEY (`log_type_id`) REFERENCES `log_type` (`log_type_id`);

ALTER TABLE `user_account` ADD FOREIGN KEY (`user_type_id`) REFERENCES `user_types` (`user_type_id`);

ALTER TABLE `parent_allocation` ADD FOREIGN KEY (`parent_user_id`) REFERENCES `parent` (`user_id`);

ALTER TABLE `parent_allocation` ADD FOREIGN KEY (`student_user_id`) REFERENCES `student` (`user_id`);

ALTER TABLE `student` ADD FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`);

ALTER TABLE `class` ADD FOREIGN KEY (`specialization_id`) REFERENCES `specialization` (`spec_id`);

ALTER TABLE `class` ADD FOREIGN KEY (`class_master_id`) REFERENCES `teacher` (`user_id`);

ALTER TABLE `examination` ADD FOREIGN KEY (`teacher_user_id`) REFERENCES `teacher` (`user_id`);

ALTER TABLE `examination` ADD FOREIGN KEY (`student_user_id`) REFERENCES `student` (`user_id`);

ALTER TABLE `examination` ADD FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`);

ALTER TABLE `grade` ADD FOREIGN KEY (`examination_id`) REFERENCES `examination` (`examination_id`);

ALTER TABLE `examination`  ADD FOREIGN KEY (`examination_type_id`) REFERENCES `examination_type` (`examination_type_id`) ;

ALTER TABLE `admin` ADD FOREIGN KEY (`admin_type_id`) REFERENCES `admin_type` (`admin_type_id`);

ALTER TABLE `mean_grade` ADD FOREIGN KEY (`student_user_id`) REFERENCES `student` (`user_id`);

ALTER TABLE `mean_grade` ADD FOREIGN KEY (`teacher_user_id`) REFERENCES `teacher` (`user_id`);

ALTER TABLE `mean_grade` ADD FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`);

ALTER TABLE `teacher_allocation` ADD FOREIGN KEY (`teacher_user_id`) REFERENCES `teacher` (`user_id`);

ALTER TABLE `teacher_allocation` ADD FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`);

-- CREATE USER 'flavia'@'localhost' IDENTIFIED BY 'parola';
-- GRANT ALL PRIVILEGES ON * . * TO 'flavia'@'localhost';

SET GLOBAL log_bin_trust_function_creators = 1;