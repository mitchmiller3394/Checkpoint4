DELIMITER $$
DROP PROCEDURE IF EXISTS searchPlayerFielding;
CREATE PROCEDURE searchPlayerFielding(IN playerID_IN VARCHAR(50))
BEGIN
SELECT
    *
FROM
    player p,
    fielding f
WHERE
    p.player_id = f.player_id
    AND p.player_id = playerID_IN;
END$$
DELIMITER ;