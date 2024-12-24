#!/bin/bash

# Script: update-projects.sh
# Description: Concurrently update all BE and FE projects in separate terminal windows by checking out main branch, pulling latest changes, and running npm ci.
# Author: Panagiotis Gkionis
# Date: December 24, 2024
# Version: 1.4

# Get the current username
CURRENT_USER=$(whoami)

# Base directories for BE and FE projects
BE_BASE_DIR="/Users/$CURRENT_USER/source/be"
FE_BASE_DIR="/Users/$CURRENT_USER/source/fe"

# Array of BE and FE project directories
BE_PROJECTS=("be-app-api" "be-ms-partner-management" "be-ms-entitlement")
FE_PROJECTS=("fe-app-manager" "fe-mf-manager-root" "fe-mf-partner-platform" "fe-mf-partner-hub")

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to check for changes and optionally stash them
function check_and_stash_changes {
    local project_dir="$1"
    cd "$project_dir" || { echo -e "${RED}Directory not found: $project_dir${NC}"; return 1; }

    if [[ $(git status --porcelain) ]]; then
        echo -e "${YELLOW}Uncommitted changes found in $project_dir.${NC}"
        read -p "Do you want to stash changes and continue? [Y/n]: " confirm
        confirm=${confirm:-y} # Default to 'y' if no input
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            git stash || { echo -e "${RED}Failed to stash changes in $project_dir${NC}"; return 1; }
        else
            echo -e "${CYAN}Skipping updates for $project_dir.${NC}"
            return 1
        fi
    else
        echo -e "${GREEN}No uncommitted changes in $project_dir.${NC}"
    fi

    return 0
}

# Function to update a single project in a new terminal
function update_project {
    local project_dir="$1"
    osascript -e "tell application \"Terminal\" to do script \"cd '$project_dir' && \
        echo 'Updating project: $project_dir' && \
        git checkout main && git pull origin main && npm ci && \
        echo 'Project updated: $project_dir'\""
}

# Process BE projects
echo -e "${CYAN}Updating Backend (BE) projects...${NC}"
for BE_PROJECT in "${BE_PROJECTS[@]}"; do
    project_path="$BE_BASE_DIR/$BE_PROJECT"
    if check_and_stash_changes "$project_path"; then
        update_project "$project_path"
    fi
done

# Process FE projects
echo -e "${CYAN}Updating Frontend (FE) projects...${NC}"
for FE_PROJECT in "${FE_PROJECTS[@]}"; do
    project_path="$FE_BASE_DIR/$FE_PROJECT"
    if check_and_stash_changes "$project_path"; then
        update_project "$project_path"
    fi
done

echo -e "${GREEN}All eligible projects are being updated in separate terminals.${NC}"
