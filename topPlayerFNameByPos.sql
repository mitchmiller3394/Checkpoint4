DELIMITER $$

DROP PROCEDURE IF EXISTS GetTopFirstNamesByPosition $$

CREATE PROCEDURE GetTopFirstNamesByPosition(IN in_position VARCHAR(5))
BEGIN
    SELECT
        p.name_first,
        COUNT(DISTINCT a.player_id) AS player_count
    FROM appearances a
    JOIN player p ON a.player_id = p.player_id
    WHERE 
      (CASE
        WHEN in_position = 'P' THEN a.g_p
        WHEN in_position = 'C' THEN a.g_c
        WHEN in_position = '1B' THEN a.g_1b
        WHEN in_position = '2B' THEN a.g_2b
        WHEN in_position = '3B' THEN a.g_3b
        WHEN in_position = 'SS' THEN a.g_ss
        WHEN in_position = 'LF' THEN a.g_lf
        WHEN in_position = 'CF' THEN a.g_cf
        WHEN in_position = 'RF' THEN a.g_rf
        WHEN in_position = 'DH' THEN a.g_dh
        WHEN in_position = 'PH' THEN a.g_ph
        WHEN in_position = 'PR' THEN a.g_pr
        ELSE 0
      END) > 0
    GROUP BY p.name_first
    ORDER BY player_count DESC
    LIMIT 10;
END $$

DELIMITER ;
