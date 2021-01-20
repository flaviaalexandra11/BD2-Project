DELIMITER ;;

CREATE DEFINER=`root`@`localhost` FUNCTION `get_class_spec_id`(class_id INT) RETURNS varchar(255) CHARSET utf8mb4
BEGIN
	-- Declare result = class specialization name.
    DECLARE result VARCHAR(255) DEFAULT ("");
    
    -- Exception handler.
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN RETURN "ERROR"; END;
    
    -- Find class specialization by clas_id.
    SELECT s.spec_name INTO result 
    FROM specialization s
    JOIN class c ON s.spec_id = c.specialization_id
    WHERE c.class_id = class_id;

RETURN result;
END;;

DELIMITER ;