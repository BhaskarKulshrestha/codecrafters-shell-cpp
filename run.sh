#!/bin/bash
# Shell launcher and demo script
# Usage: ./run.sh [demo]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$SCRIPT_DIR/src"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

# Compile if needed
compile_shell() {
    if [ ! -f "$SRC_DIR/main" ] || [ "$SRC_DIR/main.cpp" -nt "$SRC_DIR/main" ]; then
        echo -e "${BLUE}Compiling shell...${NC}"
        cd "$SRC_DIR"
        g++ -std=c++17 main.cpp -o main -lreadline 2>&1
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ Compilation successful${NC}"
        else
            echo -e "${RED}✗ Compilation failed${NC}"
            exit 1
        fi
        cd "$SCRIPT_DIR"
    fi
}

# Demo mode
run_demo() {
    echo -e "${CYAN}========================================"
    echo -e "  Advanced Shell Feature Demo"
    echo -e "========================================${NC}"
    echo ""
    echo -e "${YELLOW}Available Features:${NC}"
    echo -e "  ${GREEN}calc${NC}       - Calculator (e.g., calc 2 + 2)"
    echo -e "  ${GREEN}bookmark${NC}   - Save directories (e.g., bookmark mydir)"
    echo -e "  ${GREEN}jump${NC}       - Navigate to bookmarks (e.g., jump mydir)"
    echo -e "  ${GREEN}git-status${NC} - Show git branch and status"
    echo -e "  ${GREEN}git-branch${NC} - List/switch git branches"
    echo ""
    echo -e "${YELLOW}Quick Examples:${NC}"
    echo -e "  calc 10 * 5 + 3"
    echo -e "  bookmark projects && cd /tmp && jump projects"
    echo -e "  echo 'Hello' | grep 'H'"
    echo -e "  ls *.sh && pwd"
    echo ""
    echo -e "${CYAN}Starting shell in demo mode...${NC}"
    echo ""
    sleep 1
}

# Main
compile_shell

if [ "$1" = "demo" ]; then
    run_demo
else
    echo -e "${GREEN}Launching Custom Shell${NC}"
    echo -e "${BLUE}Tip: Run './run.sh demo' for feature overview${NC}"
    echo ""
fi

exec "$SRC_DIR/main"
