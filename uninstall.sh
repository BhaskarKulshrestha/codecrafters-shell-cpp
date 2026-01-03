#!/bin/bash
# Uninstall script for custom shell

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== Custom Shell Uninstallation ===${NC}"

# Remove installed binaries
echo -e "\n${BLUE}[1/2] Removing installed files...${NC}"
if [ -f "$HOME/bin/myshell" ]; then
    rm "$HOME/bin/myshell"
    echo -e "${GREEN}✓ Removed $HOME/bin/myshell${NC}"
fi

if [ -f "$HOME/bin/mysh" ]; then
    rm "$HOME/bin/mysh"
    echo -e "${GREEN}✓ Removed $HOME/bin/mysh${NC}"
fi

# Note about PATH
echo -e "\n${BLUE}[2/2] PATH Configuration${NC}"
echo -e "${BLUE}Note: The PATH modification in your shell config was NOT removed.${NC}"
echo -e "${BLUE}If you want to remove it, edit your shell config file and remove the line:${NC}"
echo -e "${BLUE}  export PATH=\"\$HOME/bin:\$PATH\"${NC}"

echo -e "\n${GREEN}=== Uninstallation Complete! ===${NC}"
