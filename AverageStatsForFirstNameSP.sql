-- Given <first name>, what are the avg stats ? 

-- TODO: add hitting stats 

DELIMITER $$
Drop procedure if exists getStatsForFirstName(IN playerName_in VARCHAR(100))
BEGIN 
SELECT Avg(era),Avg(w),Avg(e) FROM pitching AS pitch
INNER JOIN fielding AS field ON field.player_id = pitch.player_id
WHERE pitch.player_id IN (SELECT player_id FROM players WHERE name_first LIKE playerName_in);

END$$
DELIMITER ;