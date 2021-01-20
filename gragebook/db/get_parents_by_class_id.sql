DELIMITER ;;

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_parents_by_class_id`(class_id INT)
BEGIN
	-- Error handling.
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SELECT 'An error has occurred, the stored procedure was terminated';
    END;
    
    -- Actual select.
    SELECT p.first_name, p.last_name, p.email, s.address, s.first_name, s.last_name
    FROM parent p
    JOIN parent_allocation pa ON p.user_id = pa.parent_user_id
    JOIN student s ON pa.student_user_id = s.user_id
	WHERE s.class_id = class_id;
    
END;;

DELIMITER ;