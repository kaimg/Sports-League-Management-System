# Sports League Management System

## Overview
The Sports League Management System is a comprehensive tool designed to manage data associated with sports leagues, including teams, players, coaches, referees, matches, scores, and standings. This project leverages real-time data integration, ensuring accuracy and efficiency in managing sports league data.

## Table of Contents
1. [Project Description](#project-description)
2. [Features](#features)
3. [Technologies Used](#technologies-used)
4. [Installation](#installation)
5. [Usage](#usage)
6. [Database Schema](#database-schema)
7. [ER Diagram](#er-diagram)
8. [Screenshots](#screenshots)

## Project Description
The Sports League Management System aims to manage comprehensive data associated with sports leagues. The project utilizes real-time data from [football-data.org](https://www.football-data.org/), maintaining an updated database with minimal manual data entry, enhancing the system's efficiency and reliability.

## Features
- Real-time data integration
- Management of teams, players, coaches, referees, matches, scores, and standings
- User-friendly interface for administrators and users
- Detailed search and filtering options
- Secure authentication and authorization
- Modular design for easy maintenance and scalability

## Technologies Used
- **Frontend:** HTML, CSS (Bootstrap), JavaScript
- **Backend:** Flask (Python framework)
- **Database:** PostgreSQL
- **Other Libraries:** Requests, Gunicorn, Psycopg2, Python-Dotenv, Werkzeug

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/sports-league-management.git
   cd sports-league-management
   ```

2. Create and activate a virtual environment:
   ```sh
   python3 -m venv env
   source env/bin/activate
   ```

3. Install the required packages:
   ```sh
   pip install -r requirements.txt
   ```

4. Set up the environment variables:
   - Create a `.env` file in the project root directory.
   - Add the following environment variables to the `.env` file:
     ```sh
     FLASK_APP=run.py
     FLASK_ENV=development
     DATABASE_URL=postgresql://username:password@localhost:5432/sports_league_db
     API_TOKEN=your_api_token
     ```

5. Initialize the database:
   ```sh
   flask db init
   flask db migrate -m "Initial migration."
   flask db upgrade
   ```

6. Run the application:
   ```sh
   flask run
   ```

## Usage
### Admin Panel
- **Manage Users:** View and modify user privileges.
- **Manage Teams:** Add, update, or delete teams.
- **Manage Players:** Add, update, or delete players.
- **Manage Matches:** Schedule, update, or delete matches.

### User Dashboard
- **View Teams:** Browse team profiles and their historical performance.
- **View Players:** View player profiles and performance statistics.
- **View Leagues:** Browse different leagues and their standings.
- **View Matches:** View upcoming and past matches with filtering options.
- **Top Scorers:** See the top scorers in various leagues.

### Search Functionality
- **Search:** Find specific players, teams, stadiums, and coaches by name.

## Database Schema
The database schema is designed to minimize redundancy and ensure data integrity by using foreign keys and transactions. The main entities include users, stadiums, leagues, seasons, teams, coaches, players, matches, scores, scorers, standings, referees, and match referees.

## ER Diagram
The ER diagram illustrates the relationships between different entities in the Sports League Management System. Each table represents an entity, and the lines between them represent relationships. Primary keys are indicated by the underlined attributes, and foreign keys are shown as arrows pointing to the related primary keys.

![ER Diagram](img/dbms-diagram.png)

## Screenshots
### Main Starting Screen
![Main Starting Screen](img/landing_screen.png)

### Login Screen
![Login Screen](img/login_screen.png)

### User Dashboard
![User Dashboard](img/user_dashboard_screen.png)

### Top Scorers Screen
![Top Scorers Screen](img/scorers_screen.png)

### Matches Screen
![Matches Screen](img/match_screen.png)

### Teams Screen
![Teams Screen](img/teams_screen.png)

### Player Profiles Screen
![Player Profiles Screen](img/player_screen.png)

### League Profiles Screen
![League Profiles Screen](img/league_screen.png)

### Manage Teams Screen
![Manage Teams Screen](img/manage_teams_screen.png)

### Match Profile Screen
![Match Profile Screen](img/match_profile_screen.png)

### League Profile Screen
![League Profile Screen](img/league_profile_screen.png)

### Standings
![Standings](img/standings.png)

### Team Profile Screen
![Team Profile Screen](img/team_profile_screen.png)

### Player Profile Screen
![Player Profile Screen](img/player_profile_screen.png)

---
