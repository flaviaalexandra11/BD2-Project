DELIMITER ;;

CREATE DEFINER=`root`@`localhost` 
PROCEDURE `get_all_teachers`()
BEGIN
	SELECT * FROM teacher;
END;;

DELIMITER ;