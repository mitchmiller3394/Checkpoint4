DELIMITER $$
Drop procedure if exists getPlayersForTeam;
Create Procedure getPlayersForTeam(IN teamName_IN VARCHAR(50),IN year_in INT)
BEGIN
Select distinct players.name_first,players.name_last from players 
inner join playedFor on players.player_id = playedfor.player_id
where playedfor.team_id IN (select team.team_id from team where team.name like Concat('%','new','%') and team.year = year_in)
END$$
DELIMITER ;