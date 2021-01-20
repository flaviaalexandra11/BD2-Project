DELIMITER ;;

CREATE DEFINER=`root`@`localhost` FUNCTION `get_subject_by_tuid`(teacher_user_id INT) RETURNS int
BEGIN
    -- Declare result = subject_id.
    DECLARE result INT DEFAULT 0;
    
    -- Exception handler.
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN RETURN -1; END;
    
    -- Find subject_id by teacher_user_id.
    SELECT subject_id INTO result 
    FROM teacher_allocation ta
    WHERE ta.teacher_user_id = teacher_user_id;

RETURN result;
END;;

DELIMITER ;