-- Given <first name>, what are the avg stats ? 

DELIMITER $$
Drop procedure if exists getStatsForFirstName;
Create Procedure getStatsForFirstName(IN playerName_in VARCHAR(50))
BEGIN 
SELECT Avg(era) as avg_era, Avg(w) as avg_wins, Avg(e) average_errors, Avg(bat.h/bat.ab) as avg_ba FROM pitching AS pitch
	INNER JOIN fielding AS field ON field.player_id = pitch.player_id
	INNER JOIN batting AS bat ON bat.player_id = pitch.player_id
	WHERE pitch.player_id IN (SELECT player_id FROM player WHERE name_first LIKE playerName_in);
END$$
DELIMITER ;