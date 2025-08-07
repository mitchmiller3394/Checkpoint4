DELIMITER $$
DROP PROCEDURE IF EXISTS searchTeamDollarsPerWin;
CREATE PROCEDURE searchTeamDollarsPerWin(IN teamID_IN VARCHAR(50))
BEGIN
SELECT
    c.team_id,
    s.year,
    sum(s.salary) / max(t.w) AS dollarsPerWin
FROM
    cost c,
    salary s,
    team t
WHERE
    c.salary_id = s.salary_id
    AND c.team_id = teamID_IN
    AND c.team_id = t.team_id
    AND t.year = s.year
GROUP BY
    c.team_id, s.year;
END$$
DELIMITER ;