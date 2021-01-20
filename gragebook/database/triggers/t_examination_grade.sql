CREATE TRIGGER t_examination_grade
    AFTER INSERT
    ON examination 
    FOR EACH ROW
        begin
			insert into grade(`examination_id`)
            values(new.examination_id)
        END$$
DELIMITER ;