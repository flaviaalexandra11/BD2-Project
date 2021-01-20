use gradebook;

-- Selecteaza userii care sunt parinti.
select * from user_account where user_type_id = (select user_type_id from user_types where user_type = "parent");

-- Inserare parinti. 
set @user_id = 0;
set @class_id = 0;

select user_id into @user_id from user_account where username = "eleonora.angelescu";
insert into parent(`user_id`, `user_ssn`, `first_name`, `last_name`, `email`, `phone_number`) 
values(@user_id, "2718168271314", "Eleonora", "Angelescu", "eleonora.angelescu@email.com", "0752991728");

select user_id into @user_id from user_account where username = "maria.bargau";
insert into parent(`user_id`, `user_ssn`, `first_name`, `last_name`, `email`, `phone_number`) 
values(@user_id, "9168168271323", "Maria", "Bargau", "maria.bargau@email.com", "0757271722");

-- select user_id into @user_id from user_account where username = "adrian.ion";
-- insert into parent(`user_id`, `user_ssn`, `first_name`, `last_name`, `email`, `phone_number`) 
-- values(@user_id, "2166168276326", "Adrian", "Ion", "adrian.ion@email.com", "0767271726");

-- select user_id into @user_id from user_account where username = "daria.zamfir";
-- insert into parent(`user_id`, `user_ssn`, `first_name`, `last_name`, `email`, `phone_number`) 
-- values(@user_id, "9161168296321", "Daria", "Zamfir", "daria.zamfir@email.com", "0774244724");

-- select user_id into @user_id from user_account where username = "marius.enache";
-- insert into parent(`user_id`, `user_ssn`, `first_name`, `last_name`, `email`, `phone_number`) 
-- values(@user_id, "7161668296326", "Marius", "Enache", "marius.enache@email.com", "0754243725");

-- select user_id into @user_id from user_account where username = "miruna.enache";
-- insert into parent(`user_id`, `user_ssn`, `first_name`, `last_name`, `email`, `phone_number`) 
-- values(@user_id, "5165665296353", "Miruna", "Enache", "miruna.enache@email.com", "0724263721");

select * from parent;

-- Alocare parinti - studenti.
set @student_user_id = 0;
set @parent_user_id = 0;

select user_id into @student_user_id from user_account where username = "elena.angelescu";
select user_id into @parent_user_id from user_account where username = "eleonora.angelescu";
insert into parent_allocation(`student_user_id`, `parent_user_id`) values(@student_user_id, @parent_user_id);

select user_id into @student_user_id from user_account where username = "matei.bargau";
select user_id into @parent_user_id from user_account where username = "maria.bargau";
insert into parent_allocation(`student_user_id`, `parent_user_id`) values(@student_user_id, @parent_user_id);

-- select user_id into @student_user_id from user_account where username = "andrei.ion";
-- select user_id into @parent_user_id from user_account where username = "adrian.ion";
-- insert into parent_allocation(`student_user_id`, `parent_user_id`) values(@student_user_id, @parent_user_id);

-- select user_id into @student_user_id from user_account where username = "mihai.zamfir";
-- select user_id into @parent_user_id from user_account where username = "daria.zamfir";
-- insert into parent_allocation(`student_user_id`, `parent_user_id`) values(@student_user_id, @parent_user_id);

-- select user_id into @student_user_id from user_account where username = "maria.enache";
-- select user_id into @parent_user_id from user_account where username = "marius.enache";
-- insert into parent_allocation(`student_user_id`, `parent_user_id`) values(@student_user_id, @parent_user_id);
-- select user_id into @parent_user_id from user_account where username = "miruna.enache";
-- insert into parent_allocation(`student_user_id`, `parent_user_id`) values(@student_user_id, @parent_user_id);

select * from parent_allocation;
delete from parent_allocation where parent_allocation_id = 6;