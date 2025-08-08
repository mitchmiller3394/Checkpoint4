DELIMITER $$

DROP PROCEDURE IF EXISTS GetTopPaidPlayerByFirstName $$

CREATE PROCEDURE GetTopPaidPlayerByFirstName(IN in_first_name VARCHAR(50))
BEGIN
    SELECT
        p.player_id,
        p.name_first,
        p.name_last,
        SUM(s.salary) AS total_salary
    FROM player p
    JOIN Cost c ON p.player_id = c.player_id
    JOIN Salary s ON c.salary_id = s.salary_id
    WHERE p.name_first = in_first_name
    GROUP BY p.player_id, p.name_first, p.name_last
    ORDER BY total_salary DESC
    LIMIT 1;
END $$

DELIMITER ;
