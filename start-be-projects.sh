#!/bin/bash

# Script: start-be-projects.sh
# Description: Script to start backend development servers and open code editor for multiple projects concurrently (BE).
# Author: Panagiotis Gkionis
# Date: July 6, 2024
# Version: 1.1

# Requirements:
#   chmod +x start-be-projects.sh

# Get the current username
CURRENT_USER=$(whoami)

# Base directory where all the projects are located
BASE_DIR="/Users/$CURRENT_USER/source/be"

# Array of project directories
# Add more repos if required
PROJECTS=("be-app-api" "be-ms-partner-management")

# Function to open a new terminal window or tab and execute a command
function open_terminal_and_run_command {
    local project_dir="$1"
    local command="$2"
    osascript -e "tell application \"Terminal\" to do script \"cd '$project_dir' && $command\""
    # osascript -e "tell application \"Visual Studio Code\" to open \"$project_dir\""
}

# Loop through each project and open a new terminal window/tab for the respective command and VS Code
for PROJECT in "${PROJECTS[@]}"; do
    project_path="$BASE_DIR/$PROJECT"
    if [ "$PROJECT" == "be-app-api" ]; then
        open_terminal_and_run_command "$project_path" "docker-compose --profile simulation up"
    elif [ "$PROJECT" == "be-ms-partner-management" ]; then
        open_terminal_and_run_command "$project_path" "npm run start:dev"
    fi
done
