[![progress-banner](https://backend.codecrafters.io/progress/shell/5900e925-82aa-4e9e-ac70-4ca52a9503c1)](https://app.codecrafters.io/users/codecrafters-bot?r=2qF)

# Build Your Own Shell - C++ Implementation

A feature-rich, POSIX-compliant Unix shell built in C++ for the [CodeCrafters Shell Challenge](https://app.codecrafters.io/courses/shell/overview).

An advanced interactive shell that supports command execution, builtin commands, I/O redirection, pipelines, command history, tab completion, git integration, directory bookmarks, and a built-in calculator.

> 🐍 **Also Available**: [Python Implementation](https://github.com/BhaskarKulshrestha/codecrafters-shell-python) with all core features!

## Features

### 🚀 Core Functionality
- **REPL (Read-Eval-Print Loop)** - Interactive command-line interface with readline
- **Command Execution** - Run external programs from PATH
- **Builtin Commands** - Native shell commands (exit, echo, type, pwd, cd, history, export, unset, env)
- **Quote Handling** - Proper parsing of single and double quotes with backslash escaping
- **Environment Variables** - Full support for `$VAR`, `${VAR}`, `$?`, `$$`
- **Error Handling** - Graceful handling of invalid commands with proper exit codes

### 📂 I/O Redirection
- **Stdout Redirection** - `>` and `1>` (overwrite), `>>` and `1>>` (append)
- **Stderr Redirection** - `2>` (overwrite), `2>>` (append)
- **Combined Redirection** - Redirect stdout and stderr simultaneously
- **Works with both builtins and external commands**

### 🔗 Pipeline Support
- **Multi-command Pipelines** - Chain unlimited commands with `|`
- **Mixed Command Types** - Seamlessly pipe between builtins and external programs
- **Example**: `cat file.txt | grep pattern | sort | uniq | wc -l`
- **Builtin-aware** - Even builtins like `pwd` work in pipelines!

### 📜 Command History
- **Persistent History** - Commands saved to file (respects `$HISTFILE`)
- **History Navigation** - Up/Down arrow keys to browse command history
- **History Builtin** - View and manage command history
  - `history` - Display all history
  - `history N` - Display last N entries
  - `history -r <file>` - Read history from file
  - `history -w <file>` - Write history to file
  - `history -a <file>` - Append new commands to file
- **Cross-platform** - Custom implementation for macOS compatibility

### ⌨️ Tab Completion
- **Command Completion** - Auto-complete builtin and external commands
- **Smart Suggestions** - Shows multiple matches when ambiguous
- **Path-aware** - Completes from all directories in `$PATH`

### 🎨 Advanced Features
- **Git Integration** - `git-status` and `git-branch` commands for quick repo management
- **Directory Bookmarks** - Save and jump to frequently used directories with `bookmark` and `jump`
- **Built-in Calculator** - `calc` command for mathematical expressions (uses `bc`)
- **Colorized Output** - ANSI color codes for better UX (green, red, yellow, cyan)
- **Command Chaining** - `&&` (AND), `||` (OR), `;` (sequential execution)
- **Wildcard Expansion** - `*` (any chars), `?` (single char) using `glob()`

## Builtin Commands

| Command | Description | Examples |
|---------|-------------|----------|
| `exit [code]` | Exit the shell with optional exit code | `exit`, `exit 0`, `exit $?` |
| `echo <args>` | Print arguments to stdout | `echo hello world`, `echo $HOME` |
| `type <cmd>` | Show if command is builtin or external | `type echo`, `type ls` |
| `pwd` | Print current working directory | `pwd` |
| `cd [dir]` | Change directory | `cd /tmp`, `cd ~`, `cd ..` |
| `history [N]` | Display command history | `history`, `history 10` |
| `history -r <file>` | Read history from file | `history -r ~/.bash_history` |
| `history -w <file>` | Write history to file | `history -w /tmp/hist` |
| `history -a <file>` | Append new history to file | `history -a /tmp/hist` |
| `export VAR=val` | Set environment variable | `export PATH=$PATH:/new` |
| `unset VAR` | Remove environment variable | `unset MY_VAR` |
| `env` | Display all environment variables | `env` |
| `calc <expr>` | Evaluate mathematical expression | `calc 2 + 2`, `calc sqrt(16)` |
| `bookmark [name]` | Save/list/remove directory bookmarks | `bookmark mydir`, `bookmark rm mydir` |
| `jump <name>` | Navigate to bookmarked directory | `jump mydir` |
| `git-status` | Show current git branch and status | `git-status` |
| `git-branch [name]` | List or switch git branches | `git-branch`, `git-branch develop` |

## Usage Examples

### Basic Commands
```bash
$ echo Hello, World!
Hello, World!

$ pwd
/home/user

$ cd /tmp
$ pwd
/tmp

$ export MY_VAR="test"
$ echo $MY_VAR
test
```

### Calculator
```bash
$ calc 2 + 2
4

$ calc sqrt(16)
4

$ calc (3 + 5) * 2
16

$ calc 2^10
1024
```

### Directory Bookmarks
```bash
$ cd ~/projects/myapp
$ bookmark app
Bookmarked: app -> /home/user/projects/myapp

$ cd /tmp
$ jump app
Jumped to: /home/user/projects/myapp

$ bookmark
Bookmarks:
  app -> /home/user/projects/myapp

$ bookmark rm app
Removed bookmark: app
```

### Git Integration
```bash
$ git-status
Branch: main [clean]

$ git-branch
* main
  develop
  feature/new

$ git-branch develop
Switched to branch 'develop'
```

### I/O Redirection
```bash
# Redirect stdout
$ echo hello > output.txt
$ cat output.txt
hello

# Redirect stderr
$ ls nonexistent 2> errors.txt

# Append output
$ echo world >> output.txt
$ cat output.txt
hello
world

# Redirect both
$ command > stdout.txt 2> stderr.txt
```

### Pipelines
```bash
# Simple pipeline
$ echo "test data" | cat
test data

# Multi-stage pipeline
$ ls | grep .cpp | wc -l
5

# Complex data processing
$ cat data.txt | grep pattern | sort | uniq | wc -l
42

# Builtin in pipeline
$ pwd | cat
/home/user/projects
```

### Command Chaining
```bash
# AND - run if previous succeeds
$ mkdir test && cd test && pwd
/tmp/test

# OR - run if previous fails
$ cd /nonexistent || echo "Failed to cd"
cd: /nonexistent: No such file or directory
Failed to cd

# Sequential - run regardless
$ echo "First" ; echo "Second" ; echo "Third"
First
Second
Third
```

### Wildcards
```bash
$ ls *.cpp
main.cpp helper.cpp

$ echo test*
test1.txt test2.txt test_data.log

$ ls file?.txt
file1.txt file2.txt fileA.txt
```

### Tab Completion
```bash
$ ec<TAB>
$ echo   # Auto-completed

$ e<TAB><TAB>
echo  exit  env  export  # Shows all matching commands

$ ca<TAB>
$ calc   # Completes builtin
```

### Command History
```bash
$ echo first
$ echo second
$ history
    1  echo first
    2  echo second
    3  history

# Use Up/Down arrows to navigate
$ <UP>    # Recalls: history
$ <UP>    # Recalls: echo second
$ <DOWN>  # Recalls: history

# Save history
$ history -w /tmp/my_history
$ history -a /tmp/my_history  # Append only new commands
```

## Getting Started

### Prerequisites
- **C++ Compiler**: g++ with C++17 support (or clang++)
- **readline Library**: For command-line editing and history
  ```bash
  # macOS
  brew install readline
  
  # Ubuntu/Debian
  sudo apt-get install libreadline-dev
  
  # Fedora/RHEL
  sudo dnf install readline-devel
  ```
- **Optional**: git (for git-status/git-branch), bc (for calc)
- **Unix-like Environment**: Linux, macOS, or WSL

### Installation

1. **Clone the repository:**
```bash
git clone https://github.com/BhaskarKulshrestha/codecrafters-shell-cpp.git
cd codecrafters-shell-cpp
```

2. **Quick run (no installation):**
```bash
./run.sh          # Normal launch
./run.sh demo     # Launch with feature overview
```

3. **System-wide installation:**
```bash
./install.sh
```
This will:
- Compile the shell
- Install to `~/bin/myshell`
- Add `~/bin` to your PATH
- Create launcher scripts

After installation, run from anywhere:
```bash
myshell  # or mysh
```

4. **Uninstall:**
```bash
./uninstall.sh
```

### Configuration

Set the `HISTFILE` environment variable to customize history file location:
```bash
export HISTFILE=~/.myshell_history
./run.sh
```

Bookmarks are automatically saved to `~/.myshell_bookmarks`

## Implementation Details

### Architecture
- **Single-file Design** - All code in `src/main.cpp` (~1770 lines)
- **STL-based** - Uses modern C++ containers (vector, string, unordered_map, pair)
- **Modular Functions** - Separate functions for parsing, execution, and I/O
- **Readline Integration** - Native readline for history and tab completion
- **Process Management** - Proper subprocess handling with fork/exec and pipes

### Key Components
- **`parse_command_line()`** - Handles quotes, escapes, and tokenization
- **`expand_variables()`** - Expands `$VAR`, `${VAR}`, `$?`, `$$`
- **`expand_wildcards()`** - Glob-based wildcard expansion
- **`split_by_logical_operators()`** - Parses `&&`, `||`, `;`
- **`execute_pipeline()`** - Chains multiple commands with proper I/O
- **`execute_builtin_in_pipeline()`** - Handles builtins in pipe contexts
- **`command_completion()`** - Tab completion for commands
- **`custom_read_history()`/`custom_append_history()`** - macOS-compatible history

### File Structure
```
.
├── src/
│   ├── main.cpp              # Main shell implementation (~1770 lines)
│   ├── main                  # Compiled binary
│   └── TEST_FEATURES.md      # Feature testing guide
├── install.sh                # System-wide installation script
├── run.sh                    # Quick launcher with demo mode
├── uninstall.sh              # Removal script
├── USAGE.md                  # Comprehensive usage guide
├── CHANGELOG.md              # Version history
├── README.md                 # This file
├── codecrafters.yml          # CodeCrafters configuration
└── your_program.sh           # CodeCrafters entry point
```

## Development

### Compiling Manually
```bash
cd src
g++ -std=c++17 main.cpp -o main -lreadline

# If readline is in custom location (e.g., macOS Homebrew)
g++ -std=c++17 main.cpp -o main -lreadline -I/opt/homebrew/include -L/opt/homebrew/lib
```

### Running Tests
```bash
codecrafters test
```

### Submitting to CodeCrafters
```bash
git add .
git commit -m "feat: implement feature"
git push origin master
```

## Features Checklist

### CodeCrafters Stages
- [x] REPL with prompt
- [x] Handle missing commands
- [x] External program execution
- [x] Builtin commands (exit, echo, type, pwd, cd)
- [x] PATH resolution
- [x] Quote handling (single and double quotes)
- [x] I/O redirection (>, >>, 2>, 2>>)
- [x] Multiple redirections
- [x] Pipelines (multiple commands)
- [x] Builtin commands in pipelines
- [x] Command history (persistent with HISTFILE)

### Advanced Features
- [x] Environment variables ($VAR, ${VAR}, $?, $$)
- [x] Export/unset/env builtins
- [x] Tab completion (builtins + PATH)
- [x] Command chaining (&&, ||, ;)
- [x] Wildcard expansion (*, ?)
- [x] Git integration (git-status, git-branch)
- [x] Directory bookmarks (bookmark, jump)
- [x] Built-in calculator (calc)
- [x] Colorized output (ANSI colors)
- [x] History management (-r, -w, -a flags)
- [x] Backslash escaping
- [x] Exit status tracking

### Planned Features
- [ ] Background jobs (&, fg, bg)
- [ ] Signal handling (SIGINT, SIGTSTP)
- [ ] Command substitution ($(...))
- [ ] Heredocs (<<)
- [ ] Syntax highlighting
- [ ] Inline suggestions
- [ ] Configuration file (~/.myshellrc)

## Technical Highlights

### Cross-Platform Compatibility
- Custom history functions for macOS libedit compatibility
- OS-agnostic path handling with PATH parsing
- Works on Linux, macOS, and WSL

### Smart Command Execution
- Tracks exit status for all commands ($?)
- Proper pipe cleanup and error handling
- Fork/exec for external programs
- Direct execution for builtins (faster)

### Robust Pipeline Implementation
- Handles any combination of builtins and external commands
- Proper file descriptor management
- Process cleanup on errors
- String buffering for builtin output in pipes

### Color System
```cpp
#define COLOR_RESET   "\033[0m"
#define COLOR_RED     "\033[31m"
#define COLOR_GREEN   "\033[32m"
#define COLOR_YELLOW  "\033[33m"
#define COLOR_CYAN    "\033[36m"
```

## Comparison: This Shell vs Others

| Feature | This Shell | bash | zsh | fish |
|---------|-----------|------|-----|------|
| Built-in Calculator | ✅ | ❌ | ❌ | ❌ |
| Directory Bookmarks | ✅ | ❌ | ❌ | ❌ |
| Git Integration | ✅ | ❌ | ❌ | ❌ |
| Command History | ✅ | ✅ | ✅ | ✅ |
| Tab Completion | ✅ | ✅ | ✅ | ✅ |
| Pipelines | ✅ | ✅ | ✅ | ✅ |
| Colorized Output | ✅ | ❌ | ❌ | ✅ |
| Job Control | ❌ | ✅ | ✅ | ✅ |
| Syntax Highlighting | ❌ | ❌ | ❌ | ✅ |

### What Makes This Shell Special
- **Built-in calculator** - No need for external `bc` or `expr` commands
- **Directory bookmarks** - Faster navigation than creating aliases
- **Git integration** - Quick status checks without typing full commands
- **Colorized output** - Enhanced readability for commands and errors
- **Beginner-friendly code** - Clean C++17 with STL, easy to understand and extend

## Troubleshooting

### Compilation Issues
```bash
# If readline is not found
brew install readline  # macOS
sudo apt-get install libreadline-dev  # Ubuntu

# Link against homebrew readline
g++ -std=c++17 main.cpp -o main -lreadline \
    -I/opt/homebrew/include -L/opt/homebrew/lib
```

### Missing bc command
```bash
# macOS
brew install bc

# Ubuntu
sudo apt-get install bc
```

## Documentation

- **[USAGE.md](USAGE.md)** - Complete usage guide with all commands and examples
- **[TEST_FEATURES.md](src/TEST_FEATURES.md)** - Comprehensive feature testing
- **[CHANGELOG.md](CHANGELOG.md)** - Version history and updates

## Acknowledgments

This project is part of the [CodeCrafters](https://codecrafters.io) "Build Your Own Shell" challenge.

Special thanks to CodeCrafters for providing an excellent platform for learning systems programming.

## Repository

- **GitHub**: https://github.com/BhaskarKulshrestha/codecrafters-shell-cpp
- **CodeCrafters**: https://git.codecrafters.io/114ce7b8708b4a39

## Author

- **Name**: Bhaskar Kulshrestha
- **Email**: bhaskarkulshrestha03@gmail.com
- **GitHub**: [@BhaskarKulshrestha](https://github.com/BhaskarKulshrestha)

## License

MIT License - Feel free to use this code for learning purposes.

---

**Note**: If you're viewing this repo on GitHub, head over to [codecrafters.io](https://codecrafters.io) to try the challenge yourself!

Built for educational purposes as part of the CodeCrafters challenge.