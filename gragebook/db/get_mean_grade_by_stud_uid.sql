DELIMITER ;;

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_mean_grade_by_stud_uid`(student_user_id INT, teacher_user_id INT)
BEGIN
	-- Error handling.
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SELECT 'An error has occurred, the stored procedure was terminated';
    END;

    -- Actual select.
    SELECT mg.score
    FROM mean_grade mg
    WHERE mg.student_user_id = student_user_id
		AND mg.teacher_user_id = teacher_user_id
	ORDER BY mg.mean_grade_id DESC
    LIMIT 1;
END;;

DELIMITER ;