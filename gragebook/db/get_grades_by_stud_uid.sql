DELIMITER ;;

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_grades_by_stud_uid`(student_user_id INT, teacher_user_id INT)
BEGIN
	-- Error handling.
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SELECT 'An error has occurred, the stored procedure was terminated';
    END;
    
    -- Actual select.
    SELECT g.score, e.examination_date
    FROM grade g
    JOIN examination e 
		ON g.examination_id = e.examination_id
    WHERE e.student_user_id = student_user_id
		AND e.teacher_user_id = teacher_user_id;
END;;

DELIMITER ;