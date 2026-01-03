[![progress-banner](https://backend.codecrafters.io/progress/shell/5900e925-82aa-4e9e-ac70-4ca52a9503c1)](https://app.codecrafters.io/users/codecrafters-bot?r=2qF)

# Advanced Unix Shell in C++

A feature-rich, POSIX-compliant Unix shell built in C++ for the [CodeCrafters Shell Challenge](https://app.codecrafters.io/courses/shell/overview). This shell goes beyond basic requirements with modern features like git integration, directory bookmarks, and a built-in calculator.

## ✨ Features

### Core Shell Features
- ✅ Interactive REPL with readline
- ✅ Tab completion (builtins + PATH executables)
- ✅ Persistent command history (HISTFILE support)
- ✅ Built-in commands: `echo`, `exit`, `type`, `pwd`, `cd`, `history`
- ✅ External program execution with PATH searching
- ✅ Environment variables (`$VAR`, `${VAR}`, `$?`, `$$`)
- ✅ `export`, `unset`, `env` builtins

### Advanced Features 🚀
- ✅ **Git Integration**: `git-status`, `git-branch` for quick repo management
- ✅ **Directory Bookmarks**: `bookmark`, `jump` for fast navigation
- ✅ **Built-in Calculator**: `calc` for mathematical expressions
- ✅ **Colorized Output**: ANSI colors for better UX
- ✅ Quote handling (`'`, `"`, `\`)
- ✅ Redirections: `>`, `>>`, `2>`
- ✅ Pipelines: `|` (supports builtins!)
- ✅ Command chaining: `&&`, `||`, `;`
- ✅ Wildcard expansion: `*`, `?`

## 🚀 Quick Start

### Running the Shell
```bash
cd src
g++ -std=c++17 main.cpp -o main -lreadline
./main
```

Or use the convenience script:
```bash
./run.sh
```

### System-Wide Installation
```bash
./install.sh
```
Installs to `~/bin/myshell` and adds to PATH.

## 📖 Usage Examples

### Calculator
```bash
$ calc 2 + 2
4
$ calc sqrt(16)
4
$ calc (3 + 5) * 2
16
```

### Directory Bookmarks
```bash
$ bookmark myproject          # Save current directory
$ cd /tmp
$ jump myproject              # Jump back instantly
$ bookmark                    # List all bookmarks
$ bookmark rm myproject       # Remove bookmark
```

### Git Integration
```bash
$ git-status                  # Show branch and status
Branch: main [clean]

$ git-branch                  # List branches
* main
  develop

$ git-branch develop          # Switch branch
```

### Command Chaining
```bash
$ calc 10 + 5 && echo "Success!"
15
Success!

$ cd /nonexistent || echo "Failed to cd"
cd: /nonexistent: No such file or directory
Failed to cd
```

### Pipelines
```bash
$ echo "Hello World" | grep World
Hello World

$ ls | grep .cpp
main.cpp
```

## 📚 Documentation

- **[USAGE.md](USAGE.md)**: Complete usage guide with examples
- **[TEST_FEATURES.md](TEST_FEATURES.md)**: Feature testing guide
- **[CHANGELOG.md](CHANGELOG.md)**: Version history and updates

## 🔧 Technical Details

- **Language**: C++17
- **Dependencies**: readline library, git, bc
- **Lines of Code**: ~1770 lines (single file)
- **Architecture**: STL-based, beginner-friendly code

### Data Persistence
- History: `$HISTFILE` (default: `~/.bash_history`)
- Bookmarks: `~/.myshell_bookmarks`

## 🎯 CodeCrafters Stages

All stages completed:
1. ✅ Print prompt
2. ✅ Handle missing commands
3. ✅ REPL loop
4. ✅ `exit` builtin
5. ✅ `echo` builtin
6. ✅ `type` builtin
7. ✅ Execute programs (PATH search)
8. ✅ `pwd` builtin
9. ✅ `cd` builtin
10. ✅ `cd` to home directory
11. ✅ Output redirection
12. ✅ Redirection append mode
13. ✅ Pipelines
14. ✅ Error redirection
15. ✅ Multiple redirections
16. ✅ Builtin commands in pipelines
17. ✅ Command history

Plus many additional features!

## 🎨 What Makes This Shell Special

### Compared to bash/zsh:
- **Built-in calculator** - No need for external `bc` or `expr` commands
- **Directory bookmarks** - Faster than creating aliases
- **Git integration** - Quick status checks without typing full commands
- **Colorized output** - Enhanced readability
- **Beginner-friendly code** - Clean C++17 with STL, easy to understand

## 🐛 Known Limitations

- Syntax highlighting: Not yet implemented (as-you-type)
- Job control: Background processes (`&`) not supported yet
- Configuration file: No `~/.myshellrc` support yet

## 📝 CodeCrafters Original Info

This is a starting point for C++ solutions to the
["Build Your Own Shell" Challenge](https://app.codecrafters.io/courses/shell/overview).

In this challenge, you'll build your own POSIX compliant shell that's capable of
interpreting shell commands, running external programs and builtin commands like
cd, pwd, echo and more.

**Note**: If you're viewing this repo on GitHub, head over to
[codecrafters.io](https://codecrafters.io) to try the challenge.

## 📦 Repository

- **Personal GitHub**: https://github.com/BhaskarKulshrestha/codecrafters-shell-cpp.git
- **CodeCrafters**: https://git.codecrafters.io/114ce7b8708b4a39

## 👤 Author

- Email: bhaskarkulshrestha03@gmail.com
- GitHub: [@BhaskarKulshrestha](https://github.com/BhaskarKulshrestha)

## 📄 License

Built for educational purposes as part of the CodeCrafters challenge.