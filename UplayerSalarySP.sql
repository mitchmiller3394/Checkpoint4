DELIMITER $$
DROP PROCEDURE IF EXISTS updatePlayerSalary;
CREATE PROCEDURE updatePlayerSalary(IN playerID_IN VARCHAR(50), IN teamID_IN VARCHAR(50), IN year_IN INT, IN salary_IN DECIMAL(10,2))
BEGIN
    UPDATE salary s
    JOIN cost c ON c.salary_id = s.salary_id
    SET s.salary = salary_IN
    WHERE c.player_id = playerID_IN AND c.team_id = teamID_IN AND s.year = year_IN;
END$$
DELIMITER ;
