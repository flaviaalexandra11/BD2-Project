DELIMITER ;;

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_teacher_profile`(teacher_user_id INT)
BEGIN
	-- Error handling.
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SELECT 'An error has occurred, the stored procedure was terminated';
    END;
    
    -- Actual select.
    SELECT t.first_name, t.last_name, t.email, t.phone_number
    from teacher t
    WHERE t.user_id = teacher_user_id;
END;;

DELIMITER ;