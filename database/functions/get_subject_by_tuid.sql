CREATE DEFINER=`root`@`localhost` PROCEDURE `compute_average`(class_id INT, teacher_user_id INT, subject_id INT, semester INT)
BEGIN
	DECLARE c_stud_id INT;
    DECLARE crt_avg DOUBLE;
    DECLARE finished INT DEFAULT 0;
    DECLARE c_student CURSOR FOR
		select s.user_id
        from student s
		where s.class_id = class_id;
    
    -- Exception handler.
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		ROLLBACK;
		SELECT 'An error has occurred, operation rollbacked and the stored procedure was terminated';
    END;

    DECLARE CONTINUE HANDLER 
    FOR NOT FOUND SET finished = 1;
    
    OPEN c_student;
    
    each_stud_id: LOOP
		FETCH c_student INTO c_stud_id;
		
        IF finished = 1 THEN 
			LEAVE each_stud_id;
		END IF;
        
        select avg(g.score) into crt_avg
        from grade g 
		join examination e on g.examination_id = e.examination_id
        where e.student_user_id = c_stud_id
        and e.subject_id = subject_id;
        
        insert into mean_grade(`student_user_id`, `teacher_user_id`, `subject_id`, `semester`, `score`)
        values(c_stud_id, teacher_user_id, subject_id, semester, crt_avg);
	end loop each_stud_id;
    
	close c_student;
    
    select * from mean_grade;
END