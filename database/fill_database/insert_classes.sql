use gradebook;

-- Inserare specializari.
insert into specialization(`spec_name`) values ("matematica-informatica");
insert into specialization(`spec_name`) values ("stiintele naturii");
insert into specialization(`spec_name`) values ("filologie");
insert into specialization(`spec_name`) values ("stiinte sociale");

select * from specialization;

-- Inserare clase.
set @class_master_id = 0;
set @specialization_id = 0;

select spec_id into @specialization_id from specialization where spec_name = "matematica-informatica";

select teacher.user_id into @class_master_id from teacher 
join user_account on teacher.user_id = user_account.user_id
where user_account.username = "viorica.aresteanu";

insert into class (`year`, `name`, `class_master_id`, `specialization_id`)
values (9, "A", @class_master_id, @specialization_id);

-- select teacher.user_id into @class_master_id from teacher 
-- join user_account on teacher.user_id = user_account.user_id
-- where user_account.username = "valiana.petrisor";

-- insert into class (`year`, `name`, `class_master_id`, `specialization_id`)
-- values (10, "A", @class_master_id, @specialization_id);

-- select teacher.user_id into @class_master_id from teacher 
-- join user_account on teacher.user_id = user_account.user_id
-- where user_account.username = "denisa.popescu";

-- insert into class (`year`, `name`, `class_master_id`, `specialization_id`)
-- values (11, "A", @class_master_id, @specialization_id);

-- select teacher.user_id into @class_master_id from teacher 
-- join user_account on teacher.user_id = user_account.user_id
-- where user_account.username = "corina.chelaru";

-- insert into class (`year`, `name`, `class_master_id`, `specialization_id`)
-- values (12, "A", @class_master_id, @specialization_id);

select * from class;