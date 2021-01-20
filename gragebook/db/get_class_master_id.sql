DELIMITER ;;

CREATE DEFINER=`root`@`localhost` FUNCTION `get_class_master_id`(class_id INT) RETURNS int
BEGIN
	-- Declare result = user's user_id.
    DECLARE result INT DEFAULT 0;
    
    -- Exception handler.
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN RETURN -1; END;
    
    -- Find class_master_id by class_id.
    SELECT class_master_id INTO result FROM class 
    WHERE class.class_id = class_id;

RETURN result;
END;;

DELIMITER ;