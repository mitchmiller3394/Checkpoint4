DELIMITER $$
DROP PROCEDURE IF EXISTS getleagueStats;
CREATE PROCEDURE getleagueStats(IN league_id_in VARCHAR(50))
BEGIN
WITH a_pitch as (
        SELECT AVG(era) as avg_era ,player_id FROM pitching
        group by player_id
            ), 
    a_bat as (
        Select AVG(h/ab) as avg_bp ,player_id FROM batting
        GROUP BY player_id
            ),
    a_fielding as (
        Select AVG(e) as avg_err ,player_id FROM fielding
        GROUP BY player_id
    ),
    team_Avg_era as (
        Select AVG(avg_era) as era from a_pitch 
        where a_pitch.player_id IN (
            Select played_for.player_id as pid from played_for
            where played_for.team_id IN (
            SELECT team_id from played_in where league_id = league_id_in)
        )
    ),
    team_Avg_bat as (
		Select AVG(avg_bp) as bp from a_bat 
        where a_bat.player_id IN (
            Select played_for.player_id as pid from played_for
            where played_for.team_id IN (
            SELECT team_id from played_in where league_id = league_id_in)
        )
    ),
     team_Avg_err as (
		Select AVG(avg_err) as err from a_fielding
        where a_fielding.player_id IN (
            Select played_for.player_id as pid from played_for
            where played_for.team_id IN (
            SELECT team_id from played_in where league_id = league_id_in)
        )
    )
    Select era, bp, err from team_Avg_era 
    join team_avg_bat,team_avg_err;
END$$
DELIMITER ;