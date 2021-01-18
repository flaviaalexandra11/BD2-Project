
-- Functii.
select login("denisa.popescu", "paroladenisa") as user_id;

select * from class;
select get_class_master_id(1) as class_master_id;

select get_subject_by_tuid(3) as subject_id;

select get_class_spec(1) as specialization;

select * from teacher;

select * from class;
select * from teacher;
select * from subject;

-- Proceduri.
call get_students_with_parents;

select * from student;

call compute_average(1, 3, 2, 1);

delete from mean_grade where mean_grade_id = 9;

call get_classes_by_teacher(3);

call get_stud_by_class_id(1);

call get_parents_by_class_id(1);

call get_grades_by_stud_uid(7, 3);

call get_mean_grade_by_stud_uid(7, 3);

call get_teacher_profile(3);

update teacher set phone_number = "076281823" where user_id = 3;

select * from examination_type;

call add_examination(7, 4, 1, "proiect", );

select * from log;

select * from teacher;

select * from grade;

select * from examination
where student_user_id = 7;

select * from mean_grade;

delete from mean_grade where mean_grade_id = 1;

select s.user_id
from student s
where s.class_id = 1;

select * from user_account;
