--Total Salary for a given team each year
DELIMITER $$
DROP PROCEDURE IF EXISTS searchTeamTotalSalary;
CREATE PROCEDURE searchTeamTotalSalary(IN teamID_IN VARCHAR(50))
BEGIN
SELECT
    c.team_id,
    s.year,
    sum(s.salary)
FROM
    cost c,
    salary s
WHERE
    c.salary_id = s.salary_id
    AND c.team_id = teamID_IN
GROUP BY
    c.team_id, s.year;
END$$
DELIMITER ;