# Changelog

All notable changes to this project will be documented in this file.

## [2.0.0] - 2024 - Advanced Features Release

### Added
- **Git Integration**
  - `git-status` command: Display current branch and repository status (clean/dirty)
  - `git-branch` command: List all branches or switch to a specified branch
  - Helper functions: `get_git_branch()`, `get_git_status()`, `is_git_repo()`

- **Directory Bookmarks**
  - `bookmark` command: Save, list, and remove directory bookmarks
  - `jump` command: Quickly navigate to saved bookmarks
  - Persistent storage in `~/.myshell_bookmarks`
  - Auto-loads on shell startup

- **Built-in Calculator**
  - `calc` command: Evaluate mathematical expressions
  - Uses `bc` for accurate calculations
  - Supports: +, -, *, /, sqrt, ^, parentheses, and more
  - Result display in cyan color

- **Colorized Output**
  - ANSI color codes for all new commands
  - Color scheme:
    - Green: Success messages
    - Red: Error messages
    - Yellow: Warnings and hints
    - Cyan: Information and results
  - Consistent color usage across all features

- **Enhanced Builtins**
  - All new builtins work in both direct execution and pipelines
  - Proper exit status codes for all commands
  - Improved error messages with colors

### Changed
- Updated `is_builtin()` to include new commands: bookmark, jump, git-status, git-branch, calc, timer
- Enhanced `execute_builtin_in_pipeline()` with new builtin implementations
- Improved main command loop with new builtin handling

### Technical
- Added headers: `<chrono>`, `<ctime>`, `<iomanip>`, `<sys/stat.h>`
- Added global structures:
  - `unordered_map<string, string> bookmarks` for directory bookmarks
  - `chrono::steady_clock::time_point cmd_start_time` for timing
- New helper functions:
  - `calculate_str()`: String-returning calculator
  - `load_bookmarks()`: Load bookmarks from file
  - `save_bookmarks()`: Save bookmarks to file
- Code size: ~1770 lines (from ~1600)

## [1.0.0] - 2024 - Full Shell Implementation

### Added
- **Core Shell Features**
  - Interactive REPL with readline library
  - Tab completion for builtins and PATH executables
  - Command history with persistent storage
  - HISTFILE environment variable support

- **Built-in Commands**
  - `echo`: Print text with quote handling
  - `exit`: Exit shell with status code
  - `type`: Check command type (builtin/external)
  - `pwd`: Print working directory
  - `cd`: Change directory (with home directory support)
  - `history`: View and manage command history
    - `history -r <file>`: Read history from file
    - `history -w <file>`: Write history to file
    - `history -a <file>`: Append new commands to file
  - `export`: Set environment variables
  - `unset`: Remove environment variables
  - `env`: Display all environment variables

- **Advanced Features**
  - External program execution with PATH searching
  - Environment variable expansion: `$VAR`, `${VAR}`, `$?`, `$$`
  - Quote handling: single quotes (`'`), double quotes (`"`), backslash (`\`)
  - Output redirection: `>`, `>>` (stdout), `2>` (stderr)
  - Pipelines: `|` (with builtin support!)
  - Command chaining: `&&` (AND), `||` (OR), `;` (sequential)
  - Wildcard expansion: `*` (any chars), `?` (single char)

- **Error Handling**
  - Proper exit status tracking
  - `$?` for last command exit status
  - `$$` for current shell PID
  - Comprehensive error messages

### Fixed
- Exit command not working (nested loop issue)
  - Solution: Added `should_exit` flag to break from both loops
- History functions compatibility on macOS
  - Custom implementations: `custom_read_history()`, `custom_append_history()`
- Pipe file descriptor management
  - Changed from `vector<int[2]>` to `vector<pair<int,int>>`

### Deployment
- `install.sh`: System-wide installation script
- `run.sh`: Quick test launcher with auto-compile
- `uninstall.sh`: Clean removal script
- Documentation: USAGE.md, TEST_FEATURES.md

### Repository
- Migrated from CodeCrafters to personal GitHub
- Repository: https://github.com/BhaskarKulshrestha/codecrafters-shell-cpp.git
- Configured git credentials (bhaskarkulshrestha03@gmail.com)

## [0.1.0] - 2024 - Initial CodeCrafters Implementation

### Added
- Basic REPL loop
- Simple command parsing
- Initial builtin commands: echo, exit, type
- PATH searching for external programs

---

## Version Comparison

### v2.0.0 vs v1.0.0
- **+6 new commands**: git-status, git-branch, bookmark, jump, calc, timer
- **+5 helper functions**: git integration, bookmark management, calculator
- **+170 lines of code**: New features and implementations
- **Colorized output**: ANSI color support throughout
- **Better UX**: Colored messages, clearer feedback

### v1.0.0 vs v0.1.0
- **+11 builtin commands**: cd, pwd, history, export, unset, env, etc.
- **All CodeCrafters stages**: Complete implementation
- **Advanced features**: Redirections, pipelines, wildcards, command chaining
- **Production ready**: Installation scripts, documentation

---

## Future Roadmap

### v2.1.0 (Planned)
- [ ] Enhanced prompt with git info
- [ ] History with timestamps
- [ ] Better error messages with suggestions
- [ ] Command caching

### v3.0.0 (Future)
- [ ] Syntax highlighting (as-you-type)
- [ ] Inline command suggestions
- [ ] Fuzzy search with Ctrl+R
- [ ] Multi-line editing
- [ ] Configuration file support
- [ ] Job control (background processes)

### v3.1.0 (Future)
- [ ] json builtin (parse/format JSON)
- [ ] http builtin (make HTTP requests)
- [ ] watch builtin (repeat command)
- [ ] Parallel command execution
- [ ] Progress bars for long operations

---

## Notes

- All versions maintain backward compatibility
- Features tested on macOS with Command Line Tools
- Requires: C++17, readline library, git (for git commands), bc (for calculator)
