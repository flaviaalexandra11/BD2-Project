use gradebook;

-- Selecteaza userii care sunt admini.
select * from user_account where user_type_id = (select user_type_id from user_types where user_type = "student");

-- Inserare studenti. 
set @user_id = 0;
set @class_id = 0;

select class_id into @class_id from class where year = 9 and name = "A";

select user_id into @user_id from user_account where username = "elena.angelescu";
insert into student(`user_ssn`, `user_id`, `class_id`, `first_name`, `last_name`, `email`, `address`) 
values("3728198273394", @user_id, @class_id, "Elena", "Angelescu", "elena.angelescu@email.com", "Adresa pentru Elena Angelescu");

select user_id into @user_id from user_account where username = "matei.bargau";
insert into student(`user_ssn`, `user_id`, `class_id`, `first_name`, `last_name`, `email`, `address`) 
values("1718197273398", @user_id, @class_id, "Matei", "Bargau", "matei.bargau@email.com", "Adresa pentru Matei Bargau");

select * from student;

-- select user_id into @user_id from user_account where username = "andrei.ion";
-- insert into student(`user_ssn`, `user_id`, `class_id`, `first_name`, `last_name`, `email`, `address`) 
-- values("1718197273398", @user_id, @class_id, "Andrei", "Ion", "andrei.ion@email.com", "Adresa pentru Andrei Ion");

-- select user_id into @user_id from user_account where username = "mihai.zamfir";
-- insert into student(`user_ssn`, `user_id`, `class_id`, `first_name`, `last_name`, `email`, `address`) 
-- values("6712197293391", @user_id, @class_id, "Mihai", "Zamfir", "mihai.zamfir@email.com", "Adresa pentru Mihai Zamfir");

-- select user_id into @user_id from user_account where username = "maria.enache";
-- insert into student(`user_ssn`, `user_id`, `class_id`, `first_name`, `last_name`, `email`, `address`) 
-- values("2752195293345", @user_id, @class_id, "Maria", "Enache", "maria.enache@email.com", "Adresa pentru Maria Enache");

-- select class_id into @class_id from class where year = 10 and name = "A";

-- select user_id into @user_id from user_account where username = "cristina.petcu";
-- insert into student(`user_ssn`, `user_id`, `class_id`, `first_name`, `last_name`, `email`, `address`) 
-- values("8752115493344", @user_id, @class_id, "Cristina", "Petcu", "cristina.petcu@email.com", "Adresa pentru Cristina Petcu");

-- select user_id into @user_id from user_account where username = "eliza.baniza";
-- insert into student(`user_ssn`, `user_id`, `class_id`, `first_name`, `last_name`, `email`, `address`) 
-- values("8752615493344", @user_id, @class_id, "Eliza", "Baniza", "eliza.baniza@email.com", "Adresa pentru Eliza Baniza");

-- select user_id into @user_id from user_account where username = "george.radulescu";
-- insert into student(`user_ssn`, `user_id`, `class_id`, `first_name`, `last_name`, `email`, `address`) 
-- values("6252115491347", @user_id, @class_id, "George", "Radulescu", "george.radulescu@email.com", "Adresa pentru George Radulescu");

-- select user_id into @user_id from user_account where username = "miruna.voicu";
-- insert into student(`user_ssn`, `user_id`, `class_id`, `first_name`, `last_name`, `email`, `address`) 
-- values("1352145491349", @user_id, @class_id, "Miruna", "Voicu", "miruna.voicu@email.com", "Adresa pentru Miruna Voicu");

-- select user_id into @user_id from user_account where username = "razvan.baba";
-- insert into student(`user_ssn`, `user_id`, `class_id`, `first_name`, `last_name`, `email`, `address`) 
-- values("2352142491342", @user_id, @class_id, "Razvan", "Baba", "razvan.baba@email.com", "Adresa pentru Razvan Baba");

