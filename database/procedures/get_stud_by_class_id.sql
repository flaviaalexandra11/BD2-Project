CREATE DEFINER=`root`@`localhost` PROCEDURE `get_stud_by_class_id`(class_id INT)
BEGIN
	-- Error handling.
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SELECT 'An error has occurred, the stored procedure was terminated';
    END;
    
    -- Actual select. 
    SELECT s.user_id, s.student_id, s.first_name, s.last_name, s.email
    FROM student s
    WHERE s.class_id = class_id;
END