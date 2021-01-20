CREATE DEFINER=`root`@`localhost` 
PROCEDURE `add_examination`(
	student_user_id INT, teacher_user_id INT, 
	subject_id INT, examination_type VARCHAR(255), score INT, 
    student_feedback VARCHAR(255), parent_feedback VARCHAR(255))
BEGIN
	-- Exception handler.
    -- DECLARE EXIT HANDLER FOR SQLEXCEPTION
    -- BEGIN
	-- 	ROLLBACK;
	-- 	SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
    -- END;

	-- Partial result set.
	SET @examination_type_id = 0;
    SET @examination_id = 0;
    SET @examination_id = 0;
    
    -- Find out examination_type_id.
    SELECT et.examination_type_id into @examination_type_id 
    FROM examination_type et
    WHERE et.examination_type = examination_type;

	-- Insert examination.
	INSERT INTO examination(`student_user_id`, `teacher_user_id`, `subject_id`, 
							`examination_type_id`, `examination_date`)
	VALUES(student_user_id, teacher_user_id, subject_id, @examination_type_id, CURRENT_DATE());

	-- Get the examination id that was just inserted.
    SELECT max(examination_id) INTO @examination_id FROM examination;
    
    -- Set score and feedback in grade table.
    UPDATE grade g
	SET 
		g.score = score, 
        g.student_feedback = student_feedback, 
        g.parent_feedback = parent_feedback
    WHERE g.examination_id = @examination_id;
END