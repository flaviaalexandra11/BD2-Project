CREATE DEFINER=`root`@`localhost` PROCEDURE `get_students_with_parents`()
BEGIN
	-- Error handling.
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		 ROLLBACK;
		SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
    END;
	SELECT 
		s.first_name AS "stud_first_name", s.last_name AS "stud_last_name",
        s.email AS "student_email",  s.address AS "address",
        c.year AS "year", c.name AS "class_name",
        p.first_name AS "par_first_name", p.last_name AS "par_last_name",
        p.email AS "parent_email", p.phone_number AS "phone_number"
	FROM student s
    JOIN class c ON s.class_id = c.class_id 
    JOIN parent_allocation pa ON s.user_id = pa.student_user_id
	JOIN parent p ON p.user_id = pa.parent_user_id;
END