use gradebook;

-- Insert user types.
insert into user_types(`user_type`) values ("admin");
insert into user_types(`user_type`) values ("teacher");
insert into user_types(`user_type`) values ("parent");
insert into user_types(`user_type`) values ("student");

select * from user_types;

-- Insert admins.
set @admin_user_type_id = 0;
select user_type_id into @admin_user_type_id 
from user_types where user_type = "admin";

insert into user_account(`username`, `password`, `user_type_id`) values ("flavia.popescu", "parolaflavia", @admin_user_type_id);
insert into user_account(`username`, `password`, `user_type_id`) values ("alexandra.popescu", "parolaalexandra", @admin_user_type_id);

select * from user_account where user_type_id = @admin_user_type_id;

-- Insert teachers.
set @teacher_user_type_id = 0;
select user_type_id into @teacher_user_type_id 
from user_types where user_type = "teacher";

insert into user_account(`username`, `password`, `user_type_id`) values ("viorica.aresteanu", "parolaviorica", @teacher_user_type_id);
insert into user_account(`username`, `password`, `user_type_id`) values ("denisa.popescu", "paroladenisa", @teacher_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("valiana.petrisor", "parolavaliana", @teacher_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("gabriela.stoenescu", "parolagabriela", @teacher_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("valentin.preda", "parolavalentin", @teacher_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("corina.chelaru", "parolacorina", @teacher_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("carmen.podar", "parolacarmen", @teacher_user_type_id);

select * from user_account where user_type_id = @teacher_user_type_id;

-- Insert parents.
set @parent_user_type_id = 0;
select user_type_id into @parent_user_type_id 
from user_types where user_type = "parent";

insert into user_account(`username`, `password`, `user_type_id`) values ("eleonora.angelescu", "parolaeleonora", @parent_user_type_id);
insert into user_account(`username`, `password`, `user_type_id`) values ("maria.bargau", "parolamaria", @parent_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("adrian.ion", "parolaadrian", @parent_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("daria.zamfir", "paroladaria", @parent_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("marius.enache", "parolaenache", @parent_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("miruna.enache", "parolamiruna", @parent_user_type_id);

select * from user_account where user_type_id = @parent_user_type_id;

-- Insert students.
set @student_user_type_id = 0;
select user_type_id into @student_user_type_id 
from user_types where user_type = "student";

insert into user_account(`username`, `password`, `user_type_id`) values ("elena.angelescu", "parolaelena", @student_user_type_id);
insert into user_account(`username`, `password`, `user_type_id`) values ("matei.bargau", "parolamatei", @student_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("andrei.ion", "parolaandrei", @student_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("mihai.zamfir", "parolamihai", @student_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("maria.enache", "parolamaria", @student_user_type_id);

-- insert into user_account(`username`, `password`, `user_type_id`) values ("cristina.petcu", "parolacristina", @student_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("eliza.baniza", "parolaeliza", @student_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("george.radulescu", "parolageorge", @student_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("miruna.voicu", "parolamiruna", @student_user_type_id);
-- insert into user_account(`username`, `password`, `user_type_id`) values ("razvan.baba", "parolababa", @student_user_type_id);

select * from user_account where user_type_id = @student_user_type_id;

select * from user_account;