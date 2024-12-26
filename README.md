# Development Helper Scripts

This repository contains a collection of Bash scripts designed to simplify development workflows for starting local servers, managing multiple projects, and keeping codebases up-to-date.

---

## Scripts Overview

### 1. **start-be-projects.sh**
- **Description**: Starts backend development servers and opens the respective projects in the terminal or code editor.
- **Usage**:
  - Starts `docker-compose` with simulation profile for the `be-app-api` project.
  - Starts `npm run start:dev` for the `be-ms-partner-management` project.

---

### 2. **start-fe-projects.sh**
- **Description**: Starts frontend development servers and opens the respective projects in the terminal or code editor.
- **Usage**:
  - Runs `npm start` for all frontend projects defined in the array.

---

### 3. **update-projects.sh**
- **Description**: Updates all backend and frontend projects by:
  - Switching to the `main` branch.
  - Pulling the latest changes.
  - Running `npm ci` to install clean dependencies.
  - Prompts the user to stash uncommitted changes if detected.

---

## Setup

1. **Make the scripts executable**:
   ```bash
   chmod +x start-be-projects.sh
   chmod +x start-fe-projects.sh
   chmod +x update-projects.sh
   ```

2. **Add aliases for quick access**:
   Add the following lines to your shell configuration file (e.g., `~/.bashrc`, `~/.zshrc`):
   ```bash
   alias -g start-fe="~/source/scripts/start-fe-projects.sh"
   alias -g start-be="~/source/scripts/start-be-projects.sh"
   alias -g start-both="~/source/scripts/start-fe-projects.sh && ~/source/scripts/start-be-projects.sh"
   alias -g update-all="~/source/scripts/update-projects.sh"
   ```

3. **Reload your shell configuration**:
   ```bash
   source ~/.bashrc  # or `~/.zshrc` depending on your shell
   ```

---

## Customization

### Project Directories
- Update the `PROJECTS` arrays in the scripts to include your specific backend and frontend project directories.

### Base Directories
- Modify the `BASE_DIR` variables in each script to match your directory structure:
  ```bash
  BASE_DIR="/Users/your-username/source/{be|fe}"
  ```

---

## Features

- **Concurrent Execution**: Opens separate terminal windows for each project.
- **Customization**: Easily extendable to add more projects or modify commands.
- **Prompt for Stashing Changes**: Ensures you don't lose uncommitted changes while updating projects.

---

## Example Usage

### Start Frontend Projects
```bash
start-fe
```

### Start Backend Projects
```bash
start-be
```

### Start Both
```bash
start-both
```

### Update All Projects
```bash
update-all
```

---

## Requirements

- macOS (uses `osascript` for opening terminal windows).
- Installed `npm`, `docker`, and a compatible terminal application.
- Ensure the project repositories are cloned in the specified `BASE_DIR`.

---

## Notes

- For backend projects, you can modify the start commands (e.g., `docker-compose`, `npm run`) as required for your setup.
- The `update-projects.sh` script includes checks for uncommitted changes and prompts the user to stash them, ensuring a clean update process.
- When starting the development servers, you can click on the terminal menu, then select "Window" and "Merge All Windows" to have a clean terminal interface with all tabs merged.

---

Happy coding! 🚀

