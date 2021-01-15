use gradebook;

ALTER TABLE `class_allocation` ADD FOREIGN KEY (`class_id`) REFERENCES `class` (`class_id`);

ALTER TABLE `class_allocation` ADD FOREIGN KEY (`teacher_user_id`) REFERENCES `teacher` (`user_id`);

ALTER TABLE `class_allocation` ADD FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`);

ALTER TABLE `parent` ADD FOREIGN KEY (`user_id`) REFERENCES `user_account` (`user_id`);

ALTER TABLE `student` ADD FOREIGN KEY (`user_id`) REFERENCES `user_account` (`user_id`);

ALTER TABLE `teacher` ADD FOREIGN KEY (`user_id`) REFERENCES `user_account` (`user_id`);

ALTER TABLE `admin` ADD FOREIGN KEY (`user_id`) REFERENCES `user_account` (`user_id`);

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
