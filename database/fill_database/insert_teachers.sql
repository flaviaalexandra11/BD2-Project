use gradebook;

-- Selecteaza userii care sunt profesori.
select * from user_account where user_type_id = (select user_type_id from user_types where user_type = "teacher");

-- Insereaza profesorii.
set @user_id = 0;

select user_id into @user_id from user_account where username = "viorica.aresteanu";
select * from user_account where user_id = @user_id;

insert into teacher(`user_id`, `user_ssn`, `first_name`, `last_name`, `email`, `phone_number`, `is_class_master`)
values (@user_id, "1827364519928", "Viorica", "Aresteanu", "viorica.aresteanu@email.com", "0715226172", 1);

select user_id into @user_id from user_account where username = "denisa.popescu";
insert into teacher(`user_id`, `user_ssn`, `first_name`, `last_name`, `email`, `phone_number`, `is_class_master`)
values (@user_id, "2827364519928", "Denisa", "Popescu", "denisa.popescu@email.com", "0717321172", 1);

-- update teacher set is_class_master = 1 where user_id = @user_id;

-- select user_id into @user_id from user_account where username = "valiana.petrisor";
-- insert into teacher(`user_id`, `user_ssn`, `first_name`, `last_name`, `email`, `phone_number`, `is_class_master`)
-- values (@user_id, "1827364519928", "Valiana", "Petrisor", "valiana.petrisor@email.com", "0765296171", 1);

-- select user_id into @user_id from user_account where username = "gabriela.stoenescu";
-- insert into teacher(`user_id`, `user_ssn`, `first_name`, `last_name`, `email`, `phone_number`, `is_class_master`)
-- values (@user_id, "3827364519928", "Gabriela", "Stoenescu", "gabriela.stoenescu@email.com", "0711296473", 0);

-- select user_id into @user_id from user_account where username = "valentin.preda";
-- insert into teacher(`user_id`, `user_ssn`, `first_name`, `last_name`, `email`, `phone_number`, `is_class_master`)
-- values (@user_id, "4827364519627", "Valentin", "Preda", "valentin.preda@email.com", "0715921171", 0);

-- select user_id into @user_id from user_account where username = "corina.chelaru";
-- insert into teacher(`user_id`, `user_ssn`, `first_name`, `last_name`, `email`, `phone_number`, `is_class_master`)
-- values (@user_id, "1827364519928", "Corina", "Chelaru", "corina.chelaru@email.com", "0735236132", 1);

-- select user_id into @user_id from user_account where username = "carmen.podar";
-- insert into teacher(`user_id`, `user_ssn`, `first_name`, `last_name`, `email`, `phone_number`, `is_class_master`)
-- values (@user_id, "1827364519928", "Carmen", "Podar", "carmen.podar@email.com", "0710220178", 0);

-- Inserare materii.
-- insert into subject(`subject_name`) values ("romana");
-- insert into subject(`subject_name`) values ("engleza");
-- insert into subject(`subject_name`) values ("informatica");
-- insert into subject(`subject_name`) values ("matematica");
-- insert into subject(`subject_name`) values ("fizica");
insert into subject(`subject_name`) values ("filozofie");
-- insert into subject(`subject_name`) values ("chimie");
-- insert into subject(`subject_name`) values ("franceza");
insert into subject(`subject_name`) values ("istorie");

select * from subject;

-- Aloca profesorii pe materii. 
set @subject_id = 0;

select subject_id into @subject_id from subject where subject_name = "istorie";
select user_id into @user_id from user_account where username = "viorica.aresteanu";
insert into teacher_allocation(`teacher_user_id`, `subject_id`)
values(@user_id, @subject_id);

select subject_id into @subject_id from subject where subject_name = "filozofie";
select user_id into @user_id from user_account where username = "denisa.popescu";
insert into teacher_allocation(`teacher_user_id`, `subject_id`)
values(@user_id, @subject_id);

-- select subject_id into @subject_id from subject where subject_name = "informatica";
-- select user_id into @user_id from user_account where username = "valiana.petrisor";
-- insert into teacher_allocation(`teacher_user_id`, `subject_id`)
-- values(@user_id, @subject_id);

-- select subject_id into @subject_id from subject where subject_name = "fizica";
-- select user_id into @user_id from user_account where username = "gabriela.stoenescu";
-- insert into teacher_allocation(`teacher_user_id`, `subject_id`)
-- values(@user_id, @subject_id);

-- select subject_id into @subject_id from subject where subject_name = "matematica";
-- select user_id into @user_id from user_account where username = "valentin.preda";
-- insert into teacher_allocation(`teacher_user_id`, `subject_id`)
-- values(@user_id, @subject_id);

-- select subject_id into @subject_id from subject where subject_name = "franceza";
-- select user_id into @user_id from user_account where username = "corina.chelaru";
-- insert into teacher_allocation(`teacher_user_id`, `subject_id`)
-- values(@user_id, @subject_id);

-- select subject_id into @subject_id from subject where subject_name = "chimie";
-- select user_id into @user_id from user_account where username = "carmen.podar";
-- insert into teacher_allocation(`teacher_user_id`, `subject_id`)
-- values(@user_id, @subject_id);

select * from teacher_allocation;