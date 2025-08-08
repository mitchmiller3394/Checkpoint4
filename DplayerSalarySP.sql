DELIMITER $$
DROP PROCEDURE IF EXISTS deletePlayerSalary;
CREATE PROCEDURE deletePlayerSalary(IN playerID_IN VARCHAR(50), IN teamID_IN VARCHAR(50), IN year_IN INT)
BEGIN
    SET SQL_SAFE_UPDATES = 0; -- Disable safe updates to allow DELETE

    DELETE s, c
    FROM salary s
    INNER JOIN cost c ON c.salary_id = s.salary_id
    WHERE c.player_id = playerID_IN 
        AND c.team_id = teamID_IN 
        AND s.year = year_IN
        AND s.salary_id IS NOT NULL;
END$$
DELIMITER ;
