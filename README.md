# Sports League Management System

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

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
9. [License](#license)

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

### Prerequisites
- Docker and Docker Compose installed on your system
- Git for cloning the repository

### Setup Steps
1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/sports-league-management.git
   cd sports-league-management
   ```

2. Set up the environment variables:
   ```sh
   # The setup script will automatically create .env from .env.example if it doesn't exist
   cp .env.example .env
   ```
   Edit the `.env` file and set your environment variables:
   - `POSTGRES_USER`: Database username
   - `POSTGRES_PASSWORD`: Database password
   - `POSTGRES_DB`: Database name
   - `FOOTBALL_DATA_API_KEY`: Your API token from football-data.org
   - Other configuration variables as needed

3. Run the setup script:

   **Windows (PowerShell):**
   ```powershell
   .\setup.ps1
   ```

   **Linux / macOS:**
   ```sh
   chmod +x setup.sh
   ./setup.sh
   ```

   This will:
   - Check if Docker is running
   - Create necessary environment files
   - Build and start the Docker containers
   - Wait for PostgreSQL and apply `schema.sql` if tables are missing
   - Run SQL migrations (including automated data fixes like league colors and country flags)
   - Synchronize all database sequences automatically

   *Note: There is no need to run any extra python scripts manually after this process. The setup handles everything.*

   If the database was partially initialized or tables are missing, reset and run setup again:

   ```powershell
   .\setup.ps1 -Fresh
   ```

   ```sh
   ./setup.sh --fresh
   ```

The application will be available at `http://localhost:5000`

### Manual Setup (Without Docker)
Use the **same database initialization as Docker**: `schema.sql`, then `migrations/`, via one command. Do not run only `psql -f schema.sql`, or you will miss later migrations (for example `teams.is_active`, PostGIS fields).

**Prerequisites**
- PostgreSQL 16+ with **PostGIS** installed locally
- `psql` in your PATH
- Python 3.10+

1. Create and activate a virtual environment:
   ```sh
   python3 -m venv env
   source env/bin/activate   # Windows: env\Scripts\activate
   pip install -r requirements.txt
   ```

2. Configure environment (use **localhost**, not `db`):
   ```sh
   cp .env.example .env
   ```
   Edit `.env`. `DATABASE_URL` must point to your local server, for example:
   ```env
   DATABASE_URL=postgresql://sports_league_owner:sports_league_password@localhost:5432/sports_league
   ```

3. Create the database and PostGIS extension (once):
   ```sh
   psql -U postgres -c "CREATE DATABASE sports_league;"
   psql -U postgres -d sports_league -c "CREATE EXTENSION IF NOT EXISTS postgis;"
   ```

4. Initialize schema and migrations (from the project root):
   ```sh
   python scripts/ensure_db.py
   ```
   The script reads `.env`, waits for PostgreSQL, applies `schema.sql` if needed, runs all files in `migrations/`, and syncs sequences.

5. Run the application:
   ```sh
   flask run
   ```

**Keeping schema in sync**
- After `git pull`, if new files appear under `migrations/`, run `python scripts/ensure_db.py` again on your local database.
- Docker and local are usually **two separate database instances** (same structure, not necessarily the same data). Port `5432` can only be used by one PostgreSQL at a time.
- To reset a broken local database, drop and recreate it (step 3), then run step 4 again.

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

## 🎯 Kaggle Dataset
The data from this system is now available as a public dataset on Kaggle:
[European Football Leagues Database 2023-2024](https://www.kaggle.com/datasets/kamrangayibov/football-data-european-top-5-leagues)

Features of the dataset:
- Complete statistics for top 5 European leagues
- Weekly automated updates
- Available in both CSV and SQLite formats
- Comprehensive documentation and usage examples
- Clean, validated data with proper relationships

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

## Documentación del Proyecto

La documentación detallada y técnica del proyecto se encuentra en la carpeta `/docs`. A continuación, los enlaces directos a cada documento generado:

- [Caso de Negocio e Investigación](docs/business-case.md)
- [Solución Propuesta](docs/proposed-solution.md)
- [Especificación Técnica](docs/technical-specification.md)
- [Manual de Usuario y Guía de Instalación](docs/user-manual.md)
- [Documentación de API](docs/api-documentation.md)
- [Registro de Decisiones](docs/decision-log.md)
- [Evidencias de Kanban y Sprints](docs/kanban-sprints.md)
- [Gestión de Riesgos](docs/risk-management.md)
- [Preguntas Frecuentes (FAQ)](docs/faq.md)
- [La Historia del Proyecto](docs/project-story.md)

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
