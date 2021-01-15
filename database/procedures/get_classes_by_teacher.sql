CREATE DEFINER=`root`@`localhost` 
PROCEDURE `get_classes_by_teacher`(teacher_user_id INT)
BEGIN
	DECLARE c_class_id int default 0;  
    DECLARE finished int default 0;
    DECLARE c_class CURSOR FOR
		select ca.class_id
		from class_allocation ca
		join teacher t on ca.teacher_user_id = t.user_id
		where t.user_id = teacher_user_id;
        
    open c_class;
    
    get_class_id: LOOP
		FETCH c_class INTO c_class_id;
        
        select c.class_id, c.year, c.name, c.class_master_id, c.specialization_id
        from class c where c.class_id = c_class_id;
        
	end loop get_class_id;
	close c_class;
    
    select distinct c.class_id, c.year, c.name, c.class_master_id, c.specialization_id from class c
	join class_allocation ca on c.class_id = ca.class_id
	join teacher t on ca.teacher_user_id = t.user_id;
END