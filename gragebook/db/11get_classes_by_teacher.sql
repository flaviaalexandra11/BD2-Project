DELIMITER ;;

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_classes_by_teacher`(teacher_user_id INT)
BEGIN
	-- Error handling.
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SELECT 'An error has occurred, the stored procedure was terminated';
    END;
    
    select distinct c.class_id, c.year, c.name, c.class_master_id
    from class c
	join class_allocation ca on c.class_id = ca.class_id
	join teacher t on ca.teacher_user_id = t.user_id
    where t.user_id = teacher_user_id;
END;;

DELIMITER ;