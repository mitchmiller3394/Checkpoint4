DELIMITER $$
Drop procedure if exists getPlayersForTeam;
Create Procedure getPlayersForTeam(IN teamName_IN VARCHAR(50),IN year_in INT)
BEGIN
Select distinct player.name_first,player.name_last from player 
inner join playedfor on player.player_id = playedfor.player_id
where playedfor.team_id IN (select team.team_id from team where team.name LIKE CONCAT('%', teamName_IN, '%') and team.year = year_in);
END$$
DELIMITER ;