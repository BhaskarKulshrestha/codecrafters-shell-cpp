#!/bin/bash
# Installation script for custom shell

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Custom Shell Installation ===${NC}"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$SCRIPT_DIR/src"

# Compile the shell
echo -e "\n${BLUE}[1/4] Compiling shell...${NC}"
cd "$SRC_DIR"
g++ -std=c++17 main.cpp -o myshell -lreadline
echo -e "${GREEN}✓ Compilation successful${NC}"

# Create bin directory in home if it doesn't exist
echo -e "\n${BLUE}[2/4] Setting up installation directory...${NC}"
mkdir -p "$HOME/bin"

# Copy the compiled shell to ~/bin
echo -e "\n${BLUE}[3/4] Installing shell to ~/bin/myshell...${NC}"
cp myshell "$HOME/bin/myshell"
chmod +x "$HOME/bin/myshell"
echo -e "${GREEN}✓ Shell installed to $HOME/bin/myshell${NC}"

# Add ~/bin to PATH if not already there
echo -e "\n${BLUE}[4/4] Checking PATH configuration...${NC}"
SHELL_RC=""

# Detect which shell config file to use
if [ -f "$HOME/.zshrc" ]; then
    SHELL_RC="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_RC="$HOME/.bashrc"
elif [ -f "$HOME/.bash_profile" ]; then
    SHELL_RC="$HOME/.bash_profile"
fi

if [ -n "$SHELL_RC" ]; then
    # Check if ~/bin is already in PATH
    if ! grep -q 'export PATH="$HOME/bin:$PATH"' "$SHELL_RC"; then
        echo '' >> "$SHELL_RC"
        echo '# Custom shell PATH' >> "$SHELL_RC"
        echo 'export PATH="$HOME/bin:$PATH"' >> "$SHELL_RC"
        echo -e "${GREEN}✓ Added ~/bin to PATH in $SHELL_RC${NC}"
        echo -e "${BLUE}  Please run: source $SHELL_RC${NC}"
    else
        echo -e "${GREEN}✓ ~/bin already in PATH${NC}"
    fi
fi

# Create a launcher script
echo -e "\n${BLUE}Creating launcher script...${NC}"
cat > "$HOME/bin/mysh" << 'EOF'
#!/bin/bash
# Launcher for custom shell with better prompt

# Set shell name in environment
export CUSTOM_SHELL=1

# Launch the shell
exec "$HOME/bin/myshell"
EOF

chmod +x "$HOME/bin/mysh"
echo -e "${GREEN}✓ Launcher script created: mysh${NC}"

# Installation complete
echo -e "\n${GREEN}=== Installation Complete! ===${NC}"
echo -e "\n${BLUE}To use your custom shell:${NC}"
echo -e "  1. Run: ${GREEN}source $SHELL_RC${NC} (to update PATH)"
echo -e "  2. Launch shell: ${GREEN}myshell${NC} or ${GREEN}mysh${NC}"
echo -e "  3. Or directly: ${GREEN}$HOME/bin/myshell${NC}"
echo -e "\n${BLUE}To make it your default shell:${NC}"
echo -e "  1. Add it to /etc/shells: ${GREEN}echo '$HOME/bin/myshell' | sudo tee -a /etc/shells${NC}"
echo -e "  2. Change default shell: ${GREEN}chsh -s $HOME/bin/myshell${NC}"
echo -e "\n${BLUE}Features available:${NC}"
echo -e "  • Variables: VAR=value, \$VAR, \${VAR}"
echo -e "  • Special vars: \$?, \$\$"
echo -e "  • Command chaining: &&, ||, ;"
echo -e "  • Wildcards: *, ?"
echo -e "  • Pipelines: cmd1 | cmd2 | cmd3"
echo -e "  • Redirections: >, >>, 2>, 2>>"
echo -e "  • Tab completion"
echo -e "  • History: ↑/↓ arrows, history commands"
echo -e "  • Builtins: echo, cd, pwd, type, export, unset, env, history"
