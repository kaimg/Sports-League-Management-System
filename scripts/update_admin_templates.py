import os
import re

template_dir = r"c:\Users\ordon\OneDrive\Escritorio\Proyecto ACA-SIG\Sports-League-Management-System\templates"

files = [
    "manage_leagues.html", "manage_matches.html", "manage_players.html",
    "manage_referees.html", "manage_scorers.html", "manage_scores.html",
    "manage_seasons.html", "manage_stadiums.html", "manage_standings.html",
    "manage_teams.html", "manage_users.html", "manage_coaches.html", "manage_countries.html"
]

icon_map = {
    "manage_leagues.html": "fa-trophy",
    "manage_matches.html": "fa-futbol",
    "manage_players.html": "fa-running",
    "manage_referees.html": "fa-whistle",
    "manage_scorers.html": "fa-fire",
    "manage_scores.html": "fa-clipboard-list",
    "manage_seasons.html": "fa-calendar-alt",
    "manage_stadiums.html": "fa-building",
    "manage_standings.html": "fa-list-ol",
    "manage_teams.html": "fa-shield-alt",
    "manage_users.html": "fa-users-cog",
    "manage_coaches.html": "fa-user-tie",
    "manage_countries.html": "fa-globe"
}

for filename in files:
    filepath = os.path.join(template_dir, filename)
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()

    # 1. Update extends
    content = content.replace('{% extends "layout.html" %}', '{% extends "admin_dashboard.html" %}')

    # 2. Extract title
    title_match = re.search(r'{% block title %}(.*?)\s*-', content)
    title = title_match.group(1).strip() if title_match else "Manage"

    # 3. Add page_title and page_icon blocks, and rename block content
    if '{% block page_icon %}' not in content:
        content = re.sub(
            r'{% block content %}',
            f'{{% block page_icon %}}<i class="fas {icon_map.get(filename, "fa-cog")}"></i>{{% endblock %}}\n{{% block page_title %}}{title}{{% endblock %}}\n{{% block admin_content %}}',
            content
        )
    else:
        content = content.replace('{% block content %}', '{% block admin_content %}')

    # 4. Remove <div class="container mt-4">
    # And remove the first <h1> if it's standalone, or the wrapper if it has one.
    if '<div class="container mt-4">' in content:
        # replace the first occurrence
        content = content.replace('<div class="container mt-4">', '', 1)
        # for leagues, there's a second one
        if filename == "manage_leagues.html":
            content = content.replace('<div class="container mt-4">', '', 1)
        
        # Now remove the matching </div> which is typically right after the main row closes
        # We can find `            </div>\n        </div>\n    </div>\n</div>`
        # and replace with `            </div>\n        </div>\n    </div>`
        content = content.replace('            </div>\n        </div>\n    </div>\n</div>', '            </div>\n        </div>\n    </div>', 1)

    # 5. Remove the <h1> header since admin_dashboard provides it
    content = re.sub(r'<h1[^>]*>.*?</h1>', '', content, count=1)
    
    # 6. For matches, scorers, teams which had a d-flex container around h1
    if '<div class="d-flex justify-content-between align-items-center mb-4">' in content:
        # We need to preserve the sync button but remove the wrapper and h1
        # It's easier to just strip the specific div and h1
        content = content.replace('<div class="d-flex justify-content-between align-items-center mb-4">\n        \n        ', '<div class="mb-4">\n        ')

    with open(filepath, "w", encoding="utf-8") as f:
        f.write(content)

print("Updated all admin templates successfully.")
