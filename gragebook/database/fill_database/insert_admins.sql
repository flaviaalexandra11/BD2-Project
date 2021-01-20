use gradebook;

insert into admin_type(`admin_type`) values ("director");
insert into admin_type(`admin_type`) values ("secretar");

set @dir_admin_type_id = 0;
select admin_type_id into @dir_admin_type_id from admin_type where admin_type = "director";

set @sec_admin_type_id = 0;
select admin_type_id into @sec_admin_type_id from admin_type where admin_type = "secretar";

select * from admin_type;

-- Selecteaza userii care sunt admini.
select * from user_account where user_type_id = (select user_type_id from user_types where user_type = "admin");

-- Inserare admini. 
set @user_id = 0;
select user_id into @user_id from user_account where username = "flavia.popescu";
insert into admin(`user_id`, `user_ssn`, `first_name`, `last_name`, `admin_type_id`) 
values(@user_id, "1827364510091", "Flavia", "Popescu", @dir_admin_type_id);

select user_id into @user_id from user_account where username = "alexandra.popescu";
insert into admin(`user_id`, `user_ssn`, `first_name`, `last_name`, `admin_type_id`) 
values (@user_id, "1827364512091", "Alexandra", "Popescu", @sec_admin_type_id);

select * from admin;
