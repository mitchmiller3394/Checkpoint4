DELIMITER $$
DROP PROCEDURE IF EXISTS searchPlayerDollarsPerK;
CREATE PROCEDURE searchPlayerDollarsPerK(IN playerID_IN VARCHAR(50))
BEGIN
SELECT
    p.player_id,
    s.year,
    max(s.salary) / max(pitch.so) AS dollarsPerK
FROM
    cost c,
    salary s,
    player p,
    pitching pitch
WHERE
    c.salary_id = s.salary_id
    AND c.player_id = p.player_id
    AND p.player_id = playerID_IN
    AND p.player_id = pitch.player_id
    AND pitch.year = s.year
GROUP BY
    p.player_id, s.year;
END$$
DELIMITER ;