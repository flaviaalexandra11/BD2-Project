use gradebook;

-- Aloca profesorii pe clase.
set @class_id = 0;

select class_id into @class_id from class where year = 9 and name = "A";
-- select class_id into @class_id from class where year = 10 and name = "A";

select subject_id into @subject_id from subject where subject_name = "istorie";
select user_id into @user_id from user_account where username = "viorica.aresteanu";
insert into class_allocation(`class_id`, `teacher_user_id`, `subject_id`) values (@class_id, @user_id, @subject_id);

select subject_id into @subject_id from subject where subject_name = "filozofie";
select user_id into @user_id from user_account where username = "denisa.popescu";
insert into class_allocation(`class_id`, `teacher_user_id`, `subject_id`) values (@class_id, @user_id, @subject_id);

-- select subject_id into @subject_id from subject where subject_name = "informatica";
-- select user_id into @user_id from user_account where username = "valiana.petrisor";
-- insert into class_allocation(`class_id`, `teacher_user_id`, `subject_id`) values (@class_id, @user_id, @subject_id);

-- select subject_id into @subject_id from subject where subject_name = "fizica";
-- select user_id into @user_id from user_account where username = "gabriela.stoenescu";
-- insert into class_allocation(`class_id`, `teacher_user_id`, `subject_id`) values (@class_id, @user_id, @subject_id);

-- select subject_id into @subject_id from subject where subject_name = "matematica";
-- select user_id into @user_id from user_account where username = "valentin.preda";
-- insert into class_allocation(`class_id`, `teacher_user_id`, `subject_id`) values (@class_id, @user_id, @subject_id);

-- select subject_id into @subject_id from subject where subject_name = "franceza";
-- select user_id into @user_id from user_account where username = "corina.chelaru";
-- insert into class_allocation(`class_id`, `teacher_user_id`, `subject_id`) values (@class_id, @user_id, @subject_id);

-- select subject_id into @subject_id from subject where subject_name = "chimie";
-- select user_id into @user_id from user_account where username = "carmen.podar";
-- insert into class_allocation(`class_id`, `teacher_user_id`, `subject_id`) values (@class_id, @user_id, @subject_id);

select * from class_allocation;

-- Selecteaza toti profesorii care predau la o materie.
select * from teacher
join teacher_allocation 
on teacher.user_id = teacher_allocation.teacher_user_id
where teacher_allocation.subject_id = (select subject_id from subject where subject_name = "filozofie");
