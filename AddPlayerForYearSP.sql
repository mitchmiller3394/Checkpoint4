DELIMITER $$
DROP PROCEDURE IF EXISTS insertPlayerForYear;
CREATE PROCEDURE insertPlayerForYear(
    IN in_pid VARCHAR(100),
    IN in_year INT,
    IN in_team_id VARCHAR(100),
)
BEGIN
    INSERT INTO playedfor (team_id, player_id, year)
    VALUES (in_team_id, in_pid, in_year);
END$$
DELIMITER ;