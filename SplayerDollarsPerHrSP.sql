--Dollars per HR
DELIMITER $$
DROP PROCEDURE IF EXISTS searchPlayerDollarsPerHR;
CREATE PROCEDURE searchPlayerDollarsPerHR(IN playerID_IN VARCHAR(50))
BEGIN
SELECT
    p.player_id,
    s.year,
    max(s.salary) / max(b.hr) AS dollarsPerHR
FROM
    cost c,
    salary s,
    player p,
    batting b
WHERE
    c.salary_id = s.salary_id
    AND c.player_id = p.player_id
    AND p.player_id = playerID_IN
    AND p.player_id = b.player_id
    AND b.year = s.year
GROUP BY
    p.player_id, s.year;
END$$
DELIMITER ;