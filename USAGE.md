# Shell Usage Guide

Complete guide for using this advanced Unix shell with modern features.

## Quick Start

### Run Without Installation
```bash
./run.sh          # Quick launch
./run.sh demo     # Launch with feature overview
```

### Install System-Wide
```bash
./install.sh
```
Installs to `~/bin/myshell` and adds to PATH.

After installation:
```bash
myshell  # or mysh
```

### Uninstall
```bash
./uninstall.sh
```

---

## Core Features

### Built-in Commands

#### Navigation
- **pwd** - Print current directory
- **cd [dir]** - Change directory (supports `~` and `..`)

#### File Operations
- **echo [text]** - Print text (supports quotes and variables)
- **type <cmd>** - Check if command is builtin or external

#### Process Control
- **exit [code]** - Exit shell with optional status code

#### History Management
- **history** - Show command history
- **history N** - Show last N commands
- **history -r <file>** - Read history from file
- **history -w <file>** - Write history to file
- **history -a <file>** - Append new commands to file

#### Environment
- **export VAR=value** - Set environment variable
- **unset VAR** - Remove environment variable
- **env** - Display all environment variables

### Advanced Commands ✨

#### Calculator
```bash
calc 2 + 2              # Basic math
calc sqrt(16)           # Functions
calc (3 + 5) * 2       # Parentheses
calc 2^10               # Exponents
```

#### Directory Bookmarks
```bash
bookmark mydir          # Save current directory
bookmark                # List all bookmarks
jump mydir              # Navigate to bookmark
bookmark rm mydir       # Remove bookmark
```

#### Git Integration
```bash
git-status              # Show branch and status
git-branch              # List branches
git-branch develop      # Switch to branch
```

---

## Advanced Features

### Variables
```bash
# Shell variables
export MY_VAR="hello"
echo $MY_VAR

# Special variables
echo $?                 # Last exit status
echo $$                 # Shell PID
echo $HOME              # Home directory
echo $PATH              # Search path
```

### Redirection
```bash
# Output to file
echo "text" > file.txt          # Overwrite
echo "more" >> file.txt         # Append

# Error output
ls /bad 2> errors.txt           # Stderr only
cmd > out.txt 2> err.txt        # Separate files
```

### Pipelines
```bash
ls | grep .cpp
echo "Hello World" | grep World
cat file.txt | sort | uniq
history | tail -10
pwd | cat                       # Builtins work too!
```

### Command Chaining
```bash
# AND - run if previous succeeds
mkdir test && cd test && pwd

# OR - run if previous fails
cd /bad || echo "Failed"

# Sequential - run regardless
echo "First" ; echo "Second" ; echo "Third"
```

### Wildcards
```bash
ls *.cpp                # All .cpp files
echo test*              # Files starting with test
ls file?.txt            # Single character match
rm temp*.log            # Multiple files
```

### Quotes and Escaping
```bash
# Single quotes - literal
echo '$HOME'            # Prints: $HOME

# Double quotes - expand variables
echo "$HOME"            # Prints: /Users/username

# Backslash - escape
echo \"Hello\"          # Prints: "Hello"
```

---

## Usage Examples

### Calculator Examples
```bash
$ calc 15 + 27
42

$ calc sqrt(144)
12

$ calc 2^8
256

$ calc "scale=2; 22/7"
3.14
```

### Bookmark Workflow
```bash
# Save important locations
$ cd ~/projects/myapp
$ bookmark app

$ cd ~/.config
$ bookmark config

$ cd /var/log
$ bookmark logs

# List all
$ bookmark
Bookmarks:
  app -> /Users/username/projects/myapp
  config -> /Users/username/.config
  logs -> /var/log

# Quick navigation
$ jump app
Jumped to: /Users/username/projects/myapp

$ jump logs
Jumped to: /var/log

# Remove
$ bookmark rm logs
```

### Git Workflow
```bash
# Check status
$ git-status
Branch: main [clean]

# Make changes
$ echo "test" > file.txt

$ git-status
Branch: main [dirty]

# List branches
$ git-branch
* main
  develop
  feature/new

# Switch branch
$ git-branch develop
Switched to branch 'develop'
```

### Complex Commands
```bash
# Chained operations
$ bookmark start && cd /tmp && calc 10 + 5 && jump start
15
Jumped to: /Users/username/projects

# Pipeline with builtin
$ pwd | cat > location.txt

# Multiple redirections
$ ls -la > files.txt 2> errors.txt

# Variable expansion
$ export NAME="World"
$ echo "Hello $NAME"
Hello World

# Wildcards with pipeline
$ ls *.cpp | grep main
main.cpp
```

---

## Keyboard Shortcuts

- **↑/↓** - Navigate history
- **Tab** - Auto-complete commands and files
- **Ctrl+C** - Cancel current line
- **Ctrl+D** - Exit shell (EOF)
- **Ctrl+L** - Clear screen
- **Ctrl+A** - Move to line start
- **Ctrl+E** - Move to line end
- **Ctrl+U** - Delete line before cursor
- **Ctrl+K** - Delete line after cursor

---

## Configuration

### History File
Set HISTFILE environment variable:
```bash
export HISTFILE=~/.myshell_history
```

### Bookmarks
Stored in `~/.myshell_bookmarks` (auto-loaded on startup)

### Custom Variables
Add to your shell's startup script:
```bash
export MY_VAR="value"
export PATH="$PATH:/new/path"
```

---

## Tips & Tricks

### 1. Quick Directory Navigation
```bash
# Save common locations
bookmark projects
bookmark downloads
bookmark tmp

# Jump instantly
jump projects
```

### 2. Math Without External Tools
```bash
# Direct calculation
calc 15 * 24

# In scripts
RESULT=$(calc 100 / 3)
```

### 3. Git Status at a Glance
```bash
# Quick check before commit
git-status

# Branch info
git-branch | grep "* "
```

### 4. Command Chaining for Safety
```bash
# Only continue if successful
mkdir newdir && cd newdir && touch file.txt

# Provide fallback
cd /path || echo "Path doesn't exist"
```

### 5. Efficient Pipelines
```bash
# Process large outputs
ls -la | grep "^d" | wc -l    # Count directories
history | grep "git" | tail -5 # Recent git commands
```

### 6. Variable Tricks
```bash
# Save command results
export LAST_STATUS=$?

# Use in conditions
test $? -eq 0 && echo "Success"
```

---

## Testing Features

### Test Calculator
```bash
calc 2 + 2
calc sqrt(16)
calc (3 + 5) * 2
```

### Test Bookmarks
```bash
bookmark test
cd /tmp
jump test
bookmark rm test
```

### Test Pipelines
```bash
echo "Hello World" | grep World
ls | head -3
pwd | cat
```

### Test Redirections
```bash
echo "test" > output.txt
cat output.txt
echo "more" >> output.txt
cat output.txt
```

### Test Command Chaining
```bash
true && echo "Success"
false || echo "Caught failure"
echo "A" ; echo "B" ; echo "C"
```

### Test Wildcards
```bash
echo *.md
ls *.sh
```

### Test Variables
```bash
export TEST_VAR="hello"
echo $TEST_VAR
echo $?
echo $$
unset TEST_VAR
```

---

## Troubleshooting

### Compilation Issues
```bash
# Install readline if missing
# macOS:
brew install readline

# Update compiler flags
g++ -std=c++17 main.cpp -o main -lreadline -I/opt/homebrew/include -L/opt/homebrew/lib
```

### Command Not Found
- Check if command is in PATH: `echo $PATH`
- Use `type` to check command location: `type ls`
- For external programs, provide full path: `/bin/ls`

### Bookmark Not Working
- Check file exists: `cat ~/.myshell_bookmarks`
- Verify permissions: `ls -la ~/.myshell_bookmarks`
- Manually edit if needed

### Git Commands Failing
- Ensure you're in a git repository: `ls -la .git`
- Check git is installed: `which git`
- Use regular git commands if needed: `/usr/bin/git status`

### History Not Persisting
- Set HISTFILE: `export HISTFILE=~/.myshell_history`
- Check file permissions: `ls -la $HISTFILE`
- Manually save: `history -w ~/.myshell_history`

---

## Command Reference

| Command | Description | Example |
|---------|-------------|---------|
| **echo** | Print text | `echo "Hello"` |
| **exit** | Exit shell | `exit 0` |
| **type** | Check command type | `type echo` |
| **pwd** | Print directory | `pwd` |
| **cd** | Change directory | `cd /tmp` |
| **history** | Command history | `history 10` |
| **export** | Set variable | `export VAR=val` |
| **unset** | Remove variable | `unset VAR` |
| **env** | Show variables | `env` |
| **calc** | Calculator | `calc 2 + 2` |
| **bookmark** | Save directory | `bookmark name` |
| **jump** | Go to bookmark | `jump name` |
| **git-status** | Git status | `git-status` |
| **git-branch** | Git branches | `git-branch` |

---

## Development

### Recompile After Changes
```bash
cd src
g++ -std=c++17 main.cpp -o main -lreadline
./main
```

### Set as Default Shell
```bash
# Add to allowed shells
echo "$HOME/bin/myshell" | sudo tee -a /etc/shells

# Change default
chsh -s $HOME/bin/myshell
```

---

## More Information

- **README.md** - Project overview and features
- **CHANGELOG.md** - Version history and updates
- **TEST_FEATURES.md** - Comprehensive feature tests

---

*For issues or contributions, visit: https://github.com/BhaskarKulshrestha/codecrafters-shell-cpp*

Or just run:
```bash
./run.sh  # Automatically recompiles if needed
```

## Shell Features

### Variables
```bash
NAME=World
echo Hello $NAME
echo My PID is $$
echo Last exit status: $?
```

### Environment
```bash
export PATH=/new/path:$PATH
export DEBUG=1
unset DEBUG
env | grep PATH
```

### Command Chaining
```bash
mkdir test && cd test && pwd        # AND: stop on first failure
cd /invalid || echo "failed"        # OR: run on failure
echo one ; echo two ; echo three    # Sequential: always run
```

### Wildcards
```bash
echo *.txt                # All txt files
ls src/*.cpp              # All cpp in src
rm temp_?.log             # temp_1.log, temp_2.log, etc
```

### Pipelines
```bash
ls -l | grep cpp | wc -l
cat file.txt | sort | uniq | head -10
```

### Redirections
```bash
echo "hello" > file.txt         # Overwrite
echo "world" >> file.txt        # Append
command 2> errors.log           # Stderr only
command > out.log 2> err.log    # Separate stdout/stderr
```

### History
```bash
history                  # Show all history
history 10              # Show last 10 commands
history -w file.txt     # Write history to file
history -r file.txt     # Read history from file
history -a file.txt     # Append new history
```

### Tab Completion
- Press `Tab` to autocomplete commands
- Works for both built-ins and PATH executables

### Built-in Commands
- `echo` - Print text
- `cd` - Change directory (supports ~, relative, absolute paths)
- `pwd` - Print working directory
- `type` - Show command type
- `export` - Set environment variables
- `unset` - Remove variables
- `env` - List all environment variables
- `history` - Manage command history
- `exit` - Exit shell

## Tips

### Using with HISTFILE
```bash
HISTFILE=~/.myshell_history myshell
```

### Running scripts
```bash
myshell -c "echo Hello && pwd"  # (if you implement -c flag)
myshell < script.sh             # (if you implement input redirection)
```

### Customizing Prompt
Edit `src/main.cpp` and change the readline prompt string:
```cpp
char* line_ptr = readline("myshell> ");  // Custom prompt
```
