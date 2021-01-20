DELIMITER ;;

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_teacher_profile`(
	teacher_user_id INT, first_name VARCHAR(255), 
    last_name VARCHAR(255), email VARCHAR(255), phone_number VARCHAR(255))
BEGIN
	-- Exception handler.
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
		SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
    END;
    
    -- Actual update.
    UPDATE teacher t
    SET
		t.first_name = first_name,
        t.last_name = last_name, 
        t.email = email,
        t.phone_number = phone_number
    WHERE t.user_id = teacher_user_id;
END;;

DELIMITER ;