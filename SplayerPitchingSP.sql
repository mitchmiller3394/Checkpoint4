DELIMITER $$
DROP PROCEDURE IF EXISTS searchPlayerPitching;
CREATE PROCEDURE searchPlayerPitching(IN playerID_IN VARCHAR(50))
BEGIN
SELECT
    *
FROM
    player p,
    pitching pitch
WHERE
    p.player_id = pitch.player_id
    AND p.player_id = playerID_IN;
END$$
DELIMITER ;