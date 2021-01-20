DELIMITER ;;

CREATE DEFINER=`root`@`localhost` TRIGGER `teacher_AFTER_UPDATE` AFTER UPDATE ON `teacher` FOR EACH ROW BEGIN
	DECLARE log_type_id INT DEFAULT 0;
    
    SELECT lt.log_type_id INTO log_type_id 
	FROM log_type lt
    WHERE lt.log_type = "updated profile";
    
	insert into log(`log_type_id`, `user_id`, `log_date`)
    values (log_type_id , new.user_id, CURRENT_DATE());
END;;

DELIMITER ;