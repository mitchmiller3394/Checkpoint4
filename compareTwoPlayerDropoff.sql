DELIMITER $$

DROP PROCEDURE IF EXISTS CompareTwoPlayersDropoff $$

CREATE PROCEDURE CompareTwoPlayersDropoff(
    IN player1_first VARCHAR(50),
    IN player1_last  VARCHAR(50),
    IN player2_first VARCHAR(50),
    IN player2_last  VARCHAR(50)
)
BEGIN
    -- Drop old temp tables
    DROP TEMPORARY TABLE IF EXISTS player_team_year;
    DROP TEMPORARY TABLE IF EXISTS player_team_year_copy;
    DROP TEMPORARY TABLE IF EXISTS player_moves;
    DROP TEMPORARY TABLE IF EXISTS team_dropoffs;

    CREATE TEMPORARY TABLE player_team_year AS
    SELECT so.player_id, so.year, pf.team_id
    FROM appearances so
    JOIN played_for pf ON so.player_id = pf.player_id
    JOIN played_in pi ON pf.team_id = pi.team_id AND so.year = pi.year;

    CREATE TEMPORARY TABLE player_team_year_copy AS
    SELECT * FROM player_team_year;

    CREATE TEMPORARY TABLE player_moves AS
    SELECT DISTINCT
        p1.player_id,
        p1.year AS former_year,
        p1.team_id AS former_team,
        p2.team_id AS new_team
    FROM player_team_year p1
    JOIN player_team_year_copy p2
        ON p1.player_id = p2.player_id
        AND p2.year = p1.year + 1
        AND p1.team_id != p2.team_id
    JOIN player pl ON p1.player_id = pl.player_id
    WHERE (pl.name_first = player1_first AND pl.name_last = player1_last)
       OR (pl.name_first = player2_first AND pl.name_last = player2_last);

    -- Calculate drop-off in wins for each player
    CREATE TEMPORARY TABLE team_dropoffs AS
    SELECT 
        pm.player_id,
        pl.name_first,
        pl.name_last,
        pm.former_team,
        pm.former_year,
        t1.w AS wins_before,
        t2.w AS wins_after,
        (t2.w - t1.w) AS dropoff
    FROM player_moves pm
    JOIN team t1 ON t1.team_id = pm.former_team AND t1.year = pm.former_year
    JOIN team t2 ON t2.team_id = pm.former_team AND t2.year = pm.former_year + 1
    JOIN player pl ON pm.player_id = pl.player_id;

    SELECT *
    FROM team_dropoffs
    ORDER BY dropoff ASC -- worst drop-off first
    LIMIT 1;

END$$

DELIMITER ;
