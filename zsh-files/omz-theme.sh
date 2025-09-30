#!/bin/bash

# Script to modify the zsh agnoster theme
# This script is idempotent - safe to run multiple times

set -e  # Exit on any error

THEME_FILE="$HOME/.oh-my-zsh/themes/agnoster.zsh-theme"
BACKUP_FILE="$HOME/.oh-my-zsh/themes/agnoster.zsh-theme.backup"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting agnoster theme modification...${NC}"

# Check if oh-my-zsh is installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${RED}Error: oh-my-zsh not found at $HOME/.oh-my-zsh${NC}"
    exit 1
fi

# Check if agnoster theme file exists
if [ ! -f "$THEME_FILE" ]; then
    echo -e "${RED}Error: agnoster theme file not found at $THEME_FILE${NC}"
    exit 1
fi

echo -e "${YELLOW}Found agnoster theme file${NC}"

# Create backup if it doesn't exist
if [ ! -f "$BACKUP_FILE" ]; then
    echo -e "${YELLOW}Creating backup of original theme...${NC}"
    cp "$THEME_FILE" "$BACKUP_FILE"
    echo -e "${GREEN}Backup created at $BACKUP_FILE${NC}"
else
    echo -e "${YELLOW}Backup already exists, skipping backup creation${NC}"
fi

# Function to check if modification is already applied
check_dir_modification() {
    grep -q 'Show current directory only, but still show ~ for home' "$THEME_FILE"
}

check_context_modification() {
    grep -q '%n"$' "$THEME_FILE" && ! grep -q '%n@%m"$' "$THEME_FILE"
}

# Modification 1: Change directory display to show only current directory name
if check_dir_modification; then
    echo -e "${YELLOW}Directory modification already applied, skipping...${NC}"
else
    echo -e "${YELLOW}Applying directory modification...${NC}"
    
    # Use sed to replace the prompt_dir function
    sed -i.tmp '/^# Dir: current working directory$/,/^}$/{
        /prompt_segment.*%~/{
            c\
     # Show current directory only, but still show ~ for home\
    if [[ $PWD == $HOME ]]; then\
      prompt_segment "$AGNOSTER_DIR_BG" "$AGNOSTER_DIR_FG" "~"\
    else\
      prompt_segment "$AGNOSTER_DIR_BG" "$AGNOSTER_DIR_FG" "$(basename $PWD)"\
    fi
        }
    }' "$THEME_FILE"
    
    # Remove the temporary file
    rm -f "${THEME_FILE}.tmp"
    
    if check_dir_modification; then
        echo -e "${GREEN}Directory modification applied successfully${NC}"
    else
        echo -e "${RED}Directory modification failed${NC}"
        exit 1
    fi
fi

# Modification 2: Remove hostname from context
if check_context_modification; then
    echo -e "${YELLOW}Context modification already applied, skipping...${NC}"
else
    echo -e "${YELLOW}Applying context modification...${NC}"
    
    # Use sed to replace the hostname part
    sed -i.tmp 's/%n@%m"$/%n"/' "$THEME_FILE"
    
    # Remove the temporary file
    rm -f "${THEME_FILE}.tmp"
    
    if check_context_modification; then
        echo -e "${GREEN}Context modification applied successfully${NC}"
    else
        echo -e "${RED}Context modification failed${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}All modifications completed successfully!${NC}"
echo -e "${YELLOW}Note: You may need to restart your terminal or run 'source ~/.zshrc' to see the changes${NC}"
echo -e "${YELLOW}To restore the original theme, run: cp $BACKUP_FILE $THEME_FILE${NC}"