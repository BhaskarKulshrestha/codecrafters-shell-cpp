# Custom Shell Scripts

This directory contains scripts to easily use your custom shell.

## Quick Start

### Option 1: Quick Run (No Installation)
```bash
./run.sh
```
This compiles (if needed) and launches the shell immediately.

### Option 2: Install System-Wide
```bash
./install.sh
```
This will:
- Compile the shell
- Install to `~/bin/myshell`
- Add `~/bin` to your PATH
- Create a launcher script `mysh`

After installation, you can run your shell from anywhere:
```bash
myshell  # or
mysh
```

### Option 3: Make it Your Default Shell
After installation, you can set it as your default shell:
```bash
# Add to allowed shells
echo "$HOME/bin/myshell" | sudo tee -a /etc/shells

# Change your default shell
chsh -s $HOME/bin/myshell
```

## Uninstallation
```bash
./uninstall.sh
```

## Development

To recompile after making changes:
```bash
cd src
g++ -std=c++17 main.cpp -o main -lreadline
./main  # Test locally
```

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
