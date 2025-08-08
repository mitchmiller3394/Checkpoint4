DELIMITER $$
DROP PROCEDURE IF EXISTS insertPlayerSalary;
CREATE PROCEDURE insertPlayerSalary(IN playerID_IN VARCHAR(50), IN teamID_IN VARCHAR(50), IN year_IN INT, IN salary_IN DECIMAL(10,2))
BEGIN
    INSERT INTO salary (year, salary) 
    VALUES (year_IN, salary_IN);

    INSERT INTO cost (team_id, player_id, salary_id)
    VALUES (teamID_IN, playerID_IN, LAST_INSERT_ID());
END$$
DELIMITER ;