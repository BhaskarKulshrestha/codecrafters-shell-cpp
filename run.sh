#!/bin/bash
# Quick launcher for custom shell

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$SCRIPT_DIR/src"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# Check if shell is compiled
if [ ! -f "$SRC_DIR/main" ]; then
    echo -e "${BLUE}Compiling shell...${NC}"
    cd "$SRC_DIR"
    g++ -std=c++17 main.cpp -o main -lreadline
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Compilation successful${NC}"
    else
        echo -e "${RED}✗ Compilation failed${NC}"
        exit 1
    fi
fi

# Launch the shell
echo -e "${GREEN}Launching Custom Shell...${NC}"
echo -e "${BLUE}Type 'exit' to quit${NC}"
echo ""

exec "$SRC_DIR/main"
