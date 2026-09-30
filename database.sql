CREATE TABLE IF NOT EXISTS admin_buttons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    button_name VARCHAR(50) NOT NULL,
    action_time DATETIME NOT NULL,
    FOREIGN KEY (player_id) REFERENCES users(identifier)
);