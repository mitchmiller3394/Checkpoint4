DELIMITER $$

DROP PROCEDURE IF EXISTS GetWorstFormerTeamAfterPlayerMove $$

CREATE PROCEDURE GetWorstFormerTeamAfterPlayerMove()
BEGIN
    -- Make sure old temp tables are gone before recreating, annoying error
    DROP TEMPORARY TABLE IF EXISTS player_team_year;
    DROP TEMPORARY TABLE IF EXISTS player_team_year_copy;
    DROP TEMPORARY TABLE IF EXISTS player_moves;
    DROP TEMPORARY TABLE IF EXISTS former_team_wins;

    CREATE TEMPORARY TABLE player_team_year AS
    SELECT so.player_id, so.year, pf.team_id
    FROM appearances so
    JOIN Played_for pf ON so.player_id = pf.player_id
    JOIN Played_In pi ON pf.team_id = pi.team_id AND so.year = pi.year;

    CREATE TEMPORARY TABLE player_team_year_copy AS
    SELECT * FROM player_team_year;

    -- Find players who moved teams between consecutive years
    CREATE TEMPORARY TABLE player_moves AS
    SELECT 
        p1.player_id,
        p1.year AS former_year,
        p1.team_id AS former_team,
        p2.team_id AS new_team
    FROM player_team_year p1
    JOIN player_team_year_copy p2
        ON p1.player_id = p2.player_id 
        AND p2.year = p1.year + 1
        AND p1.team_id != p2.team_id;

    -- Get wins for each former team in the year after the player left
    CREATE TEMPORARY TABLE former_team_wins AS
    SELECT 
        pm.player_id,
        pm.former_team,
        pm.former_year + 1 AS year_after,
        t.w AS wins
    FROM player_moves pm
    JOIN Team t 
        ON t.team_id = pm.former_team 
        AND t.year = pm.former_year + 1;

    -- Find the minimum wins among those former teams
    SET @min_wins := (
        SELECT MIN(wins) FROM former_team_wins
    );

    -- Return the players whose former team had that minimum win total
    SELECT DISTINCT
        ftw.player_id,
        ftw.former_team,
        ftw.year_after,
        ftw.wins
    FROM former_team_wins ftw
    WHERE ftw.wins = @min_wins;


END$$

DELIMITER ;
