DELIMITER $$

DROP PROCEDURE IF EXISTS GetTopStadiumsWithTeams $$

CREATE PROCEDURE GetTopStadiumsWithTeams(IN top_n INT)
BEGIN
    WITH distinct_teams AS (
      SELECT DISTINCT
        l.park_id,
        t.name AS team_name
      FROM Location l
      JOIN team t ON l.team_id = t.team_id AND l.year = t.year
    )
    SELECT
      dt.park_id,
      MIN(p.park_name) AS park_name,
      COUNT(DISTINCT dt.team_name) AS teams,
      GROUP_CONCAT(DISTINCT dt.team_name ORDER BY dt.team_name SEPARATOR ', ') AS teams_hosted
    FROM distinct_teams dt
    JOIN park p ON dt.park_id = p.park_id
    GROUP BY dt.park_id
    ORDER BY teams DESC
    LIMIT top_n;
END $$

DELIMITER ;
