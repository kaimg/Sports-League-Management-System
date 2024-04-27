-- Create tables for users, teams, players, and games
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE players (
    player_id SERIAL PRIMARY KEY,
    team_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    position VARCHAR(255),
    FOREIGN KEY (team_id) REFERENCES teams(team_id)
);

CREATE TABLE games (
    game_id SERIAL PRIMARY KEY,
    team1_id INTEGER NOT NULL,
    team2_id INTEGER NOT NULL,
    date TIMESTAMP NOT NULL,
    FOREIGN KEY (team1_id) REFERENCES teams(team_id),
    FOREIGN KEY (team2_id) REFERENCES teams(team_id)
);
