--Insert New User Stored Procedure
--"INSERT INTO users (username, email, hash, isAdmin) VALUES (?, ?, ?, 0)"
DELIMITER $$
DROP PROCEDURE IF EXISTS insertNewUser;
CREATE PROCEDURE insertNewUser(IN username_IN VARCHAR(45), IN email_IN VARCHAR(45), IN hash_IN VARCHAR(200))
BEGIN
    INSERT INTO users (username, email, hash, isAdmin) 
    VALUES (username_IN, email_IN, hash_IN, 0);
END$$
DELIMITER ;
