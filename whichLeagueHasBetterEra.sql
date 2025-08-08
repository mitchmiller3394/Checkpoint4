-- TODO: which league has the lowest average ERA? 

-- all players for a team


-- average ERA for all players.
SELECT AVG(era),player_id FROM pitching
group by player_id
order by player_id;