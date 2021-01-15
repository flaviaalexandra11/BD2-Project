
-- Functii.
select login("denisa.popescu", "paroladenisa") as user_id;

select * from class;
select get_class_master_id(1) as class_master_id;

select get_subject_by_tuid(3) as subject_id;

select * from class;
select * from teacher;
select * from subject;

-- Proceduri.
call get_students_with_parents;

call compute_average(1, 3, 2, 1);

select * from mean_grade;

delete from mean_grade where mean_grade_id = 1;

select s.user_id
from student s
where s.class_id = 1;


select * from user_account;
