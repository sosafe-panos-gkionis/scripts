# Script: start-fe-projects.sh
# Description: Script to start development servers and open code editor for multiple projects concurrently (FE).
# Author: Panagiotis Gkionis
# Date: July 6, 2024
# Version: 1.1

# Requirements:
#   chmod +x start-fe-projects.sh

# Get the current username
CURRENT_USER=$(whoami)

# Base directory where all the projects are located
BASE_DIR="/Users/$CURRENT_USER/source/fe"

# Array of project directories
# Add more repos if required
PROJECTS=("fe-app-manager" "fe-mf-manager-root" "fe-mf-partner-platform" "fe-mf-partner-hub")

# Function to open a new terminal window or tab, execute npm start, and open VS Code
function open_terminal_and_run_npm_start {
    local project_dir="$1"
    osascript -e "tell application \"Terminal\" to do script \"cd '$project_dir' && npm start\""
    # osascript -e "tell application \"Visual Studio Code\" to open \"$project_dir\""
}

# Loop through each project and open a new terminal window/tab for npm start and VS Code
for PROJECT in "${PROJECTS[@]}"; do
    project_path="$BASE_DIR/$PROJECT"
    open_terminal_and_run_npm_start "$project_path"
done