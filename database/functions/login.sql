CREATE DEFINER=`root`@`localhost` 
FUNCTION `login`(username varchar(255), password varchar(255)) RETURNS int
BEGIN
	-- Declare result = user's user_id.
    DECLARE result INT DEFAULT 0;
    
    -- Exception handler.
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN RETURN -1; END;
    
    -- Find user_id by username & pssword.
    SELECT user_id INTO result FROM user_account 
    WHERE user_account.username = username
    AND user_account.password = password;

RETURN result;
END