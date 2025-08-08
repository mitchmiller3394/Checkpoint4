DELIMITER $$
DROP PROCEDURE IF EXISTS insertTeamWins;
CREATE PROCEDURE insertTeamWins(
    IN p_team_id INT,
    IN p_year INT,
    IN p_g INT,
    IN p_wins INT,
    IN p_losses INT,
    IN p_div_win BOOLEAN,
    IN p_wc_win BOOLEAN,
    IN p_lg_win BOOLEAN,
    IN p_ws_win BOOLEAN,
    IN p_name VARCHAR(255),
    IN p_attendance INT
)
BEGIN
    INSERT INTO team (team_id, year, g, w, l, div_win, wc_win, lg_win, ws_win, name, attendance)
    VALUES (p_team_id, p_year, p_g, p_wins, p_losses, p_div_win, p_wc_win, p_lg_win, p_ws_win, p_name, p_attendance);
END$$
DELIMITER ;