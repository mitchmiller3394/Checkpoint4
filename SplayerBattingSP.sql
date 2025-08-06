--Player BattingDetails Stored Procedure
DELIMITER $$
DROP PROCEDURE IF EXISTS searchPlayerBatting;
CREATE PROCEDURE searchPlayerBatting(IN playerID_IN VARCHAR(50))
BEGIN
SELECT
    *
FROM
    player p,
    batting b
WHERE
    p.player_id = b.player_id
    AND p.player_id = playerID_IN;
END$$
DELIMITER ;