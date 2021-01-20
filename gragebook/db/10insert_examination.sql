use gradebook;

-- Inserare tipuri de evaluare.
insert into examination_type(`examination_type`) values ("evaluare scrisa");
insert into examination_type(`examination_type`) values ("evaluare orala");
insert into examination_type(`examination_type`) values ("proiect");

select * from examination_type;

-- Inserare examinari.
set @subject_id = 0;
set @class_id = 0;
set @student_user_id = 0;
set @teacher_user_id = 0;
set @examination_type_id = 0;
set @examination_id = 0;

select class_id into @class_id from class where year = 9 and name = "A";
select class_id  from class where year = 9 and name = "A";

-- Gets subject_id & examination_type_id.
select subject_id into @subject_id from subject where subject_name = "istorie";
select examination_type_id into @examination_type_id from examination_type where examination_type = "evaluare scrisa";

select subject_id from subject where subject_name = "istorie";
select examination_type_id from examination_type where examination_type = "evaluare scrisa";

-- Gets teacher_user_id.
select user_id into @teacher_user_id from teacher t
join class_allocation ca on ca.teacher_user_id = t.user_id
join class c on c.class_id = ca.class_id
where ca.subject_id = @subject_id
and c.class_id = @class_id;

-- test istorie clasa 9A
-- Elena Angelescu
select user_id into @student_user_id from student where email = "elena.angelescu@email.com";
call add_examination(@student_user_id, @teacher_user_id, @subject_id, "evaluare scrisa", 8, "Mai multa atentie!", "Tot asa!");

-- Matei Bargau
select user_id into @student_user_id from student where email = "matei.bargau@email.com";
call add_examination(@student_user_id, @teacher_user_id, @subject_id, "evaluare scrisa", 9, "Atentie la cronologie!", "Bine!");

select * from examination;
select * from grade;

-- -- Andrei Ion
-- select user_id into @student_user_id from student where email = "andrei.ion@email.com";
-- call add_examination(@student_user_id, @teacher_user_id, @subject_id, "evaluare scrisa", 7, "Recapituleaza Pitagora!", "Poate mai mult!");

-- -- Mihai Zamfir
-- select user_id into @student_user_id from student where email = "mihai.zamfir@email.com";
-- call add_examination(@student_user_id, @teacher_user_id, @subject_id, "evaluare scrisa", 10, "Bravo, Mihai!", "Foarte bine!");

-- -- Maria Enache
-- select user_id into @student_user_id from student where email = "maria.enache@email.com";
-- call add_examination(@student_user_id, @teacher_user_id, @subject_id, "evaluare scrisa", 9, "Bine, Maria!", "Bine!");

-- -- proiect franceza clasa 9A

-- -- Gets subject_id & examination_type_id.
-- select subject_id into @subject_id from subject where subject_name = "franceza";
-- select examination_type_id into @examination_type_id from examination_type where examination_type = "proiect";

-- -- Gets teacher_user_id.
-- select user_id into @teacher_user_id from teacher t
-- join class_allocation ca on ca.teacher_user_id = t.user_id
-- join class c on c.class_id = ca.class_id
-- where ca.subject_id = @subject_id
-- and c.class_id = @class_id;


-- -- Elena Angelescu
-- select user_id into @student_user_id from student where email = "elena.angelescu@email.com";
-- call add_examination(@student_user_id, @teacher_user_id, @subject_id, "evaluare scrisa", 9, "Bravo, Elena!", "Tot asa!");

-- -- Matei Bargau
-- select user_id into @student_user_id from student where email = "matei.bargau@email.com";
-- call add_examination(@student_user_id, @teacher_user_id, @subject_id, "evaluare scrisa", 6, "Bravo, Matei!", "Bine!");

-- -- Andrei Ion
-- select user_id into @student_user_id from student where email = "andrei.ion@email.com";
-- call add_examination(@student_user_id, @teacher_user_id, @subject_id, "evaluare scrisa", 9, "Bravo, Andrei!", "Poate mai mult!");

-- -- Mihai Zamfir
-- select user_id into @student_user_id from student where email = "mihai.zamfir@email.com";
-- call add_examination(@student_user_id, @teacher_user_id, @subject_id, "evaluare scrisa", 9, "Bravo, Mihai!", "Foarte bine!");

-- -- Maria Enache
-- select user_id into @student_user_id from student where email = "maria.enache@email.com";
-- call add_examination(@student_user_id, @teacher_user_id, @subject_id, "evaluare scrisa", 10, "Bravo, Maria!", "Bine!");

-- select * from examination;
-- select * from grade;

-- call get_classes_by_teacher(@teacher_user_id);

-- -- select login("denisa.popescu", "paroladenisa");
-- rollback;