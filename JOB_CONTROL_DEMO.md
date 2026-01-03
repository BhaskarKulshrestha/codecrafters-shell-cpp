# Job Control and Syntax Highlighting Demo

## New Features Implemented ✨

### 1. Job Control
Complete background job management with signals and process groups.

### 2. Syntax Highlighting
Real-time color-coded command display for better readability.

---

## Job Control Examples

### Background Execution
```bash
# Run a long process in background
$ sleep 10 &
[1] 12345

# Run multiple background jobs
$ sleep 20 &
[2] 12346

$ sleep 30 &
[3] 12347
```

### List Jobs
```bash
$ jobs
[1]  Running		sleep 10 &
[2]  Running		sleep 20 &
[3]  Running		sleep 30 &
```

### Suspend Foreground Job (Ctrl+Z)
```bash
$ sleep 60
^Z
[4]+ Stopped	sleep 60

$ jobs
[1]  Running		sleep 10 &
[2]  Running		sleep 20 &
[3]  Running		sleep 30 &
[4]+ Stopped		sleep 60
```

### Continue Job in Background
```bash
$ bg 4
[4]+ sleep 60 &

$ jobs
[1]  Running		sleep 10 &
[2]  Running		sleep 20 &
[3]  Running		sleep 30 &
[4]  Running		sleep 60 &
```

### Bring Job to Foreground
```bash
$ fg 2
sleep 20
# Shell waits for job 2 to complete

$ jobs
[1]  Running		sleep 10 &
[3]  Running		sleep 30 &
[4]  Running		sleep 60 &
# Job 2 completed
```

### Without Job ID (uses most recent)
```bash
$ sleep 5 &
[5] 12350

$ fg
sleep 5
# Brings most recent job (5) to foreground

$ sleep 10 &
[6] 12351

$ sleep 15 &
[7] 12352

# Stop most recent with Ctrl+Z
$ fg
sleep 15
^Z
[7]+ Stopped	sleep 15

$ bg
[7]+ sleep 15 &
# Continues most recent stopped job in background
```

### Complex Commands in Background
```bash
# Pipeline in background
$ cat large_file.txt | grep "pattern" | sort &
[8] 12353

# Command with redirection in background
$ find / -name "*.log" 2>/dev/null > all_logs.txt &
[9] 12354

# Multiple commands in background
$ echo "start" && sleep 5 && echo "done" &
[10] 12355
```

### Job Completion Notifications
```bash
$ sleep 3 &
[1] 12345
# ... do other work ...
[1]+ Done		sleep 3
# Notification appears when job completes
```

---

## Syntax Highlighting

### Color Scheme
Commands are automatically color-coded as you type:

**Builtin Commands** (Green):
- echo, exit, type, pwd, cd, history
- export, unset, env
- calc, bookmark, jump
- git-status, git-branch
- jobs, fg, bg

**External Commands** (Cyan):
- ls, cat, grep, find, etc.

**Variables** (Yellow):
- $HOME, $PATH, $USER
- $VAR, ${VAR}
- $?, $$

**Flags** (Magenta):
- -la, --help, -r, etc.

**Operators** (Bold):
- |, &&, ||, ;

**Redirection** (Magenta):
- >, >>, 2>, 2>>

**Comments** (Gray):
- # This is a comment

### Examples
```bash
# Builtin command (green) with variable (yellow)
echo $HOME

# External command (cyan) with flags (magenta)
ls -la

# Pipeline with operators (bold)
cat file.txt | grep pattern | sort

# Complex command with multiple colors
export MY_VAR="value" && echo $MY_VAR > output.txt

# Command with redirection (magenta)
ls 2> errors.txt

# Background job with all features
find / -name "*.log" 2>/dev/null | grep important &
```

---

## Signal Handling

### Ctrl+C (SIGINT)
- Terminates foreground process
- Shell continues running

```bash
$ sleep 100
^C
$ # Shell ready for next command
```

### Ctrl+Z (SIGTSTP)
- Suspends foreground process
- Adds job to stopped jobs list
- Can be resumed with `fg` or `bg`

```bash
$ cat large_file.txt
^Z
[1]+ Stopped	cat large_file.txt

$ bg 1
[1]+ cat large_file.txt &
```

### SIGCHLD
- Automatically reaps zombie processes
- Updates job status
- Notifies when background jobs complete

---

## Testing Job Control

### Test 1: Basic Background Execution
```bash
$ sleep 5 &
$ jobs
$ # Wait 5 seconds
$ jobs  # Job should be gone
```

### Test 2: Foreground/Background Toggle
```bash
$ sleep 30 &
$ fg
# Press Ctrl+Z
$ bg
$ jobs
```

### Test 3: Multiple Jobs
```bash
$ sleep 10 &
$ sleep 20 &
$ sleep 30 &
$ jobs
$ fg 2
# Wait or Ctrl+C to terminate
$ jobs
```

### Test 4: Pipeline in Background
```bash
$ yes | head -1000 > /dev/null &
$ jobs
$ fg
# Ctrl+C to terminate
```

### Test 5: Job ID Management
```bash
$ for i in {1..5}; do sleep $((i*10)) & done
$ jobs
$ fg 3
# Ctrl+Z
$ bg 3
$ jobs
```

---

## Technical Details

### Process Groups
Each job runs in its own process group for proper isolation:
```c++
setpgid(0, 0);  // Create new process group
tcsetpgrp(STDIN_FILENO, pid);  // Give terminal control
```

### Signal Handlers
```c++
// SIGCHLD handler reaps zombie processes
void sigchld_handler(int sig) {
    while ((pid = waitpid(-1, &status, WNOHANG | WUNTRACED | WCONTINUED)) > 0) {
        // Update job status
    }
}

// Shell ignores SIGINT/SIGTSTP (children get them)
signal(SIGINT, SIG_IGN);
signal(SIGTSTP, SIG_IGN);
```

### Job Tracking
```c++
struct Job {
    int job_id;
    pid_t pid;
    string command;
    JobStatus status;  // RUNNING, STOPPED, DONE
    bool is_background;
};
```

---

## Feature Comparison

| Feature | This Shell | bash | zsh | fish |
|---------|------------|------|-----|------|
| Background Jobs (&) | ✅ | ✅ | ✅ | ✅ |
| jobs Command | ✅ | ✅ | ✅ | ✅ |
| fg/bg Commands | ✅ | ✅ | ✅ | ✅ |
| Signal Handling | ✅ | ✅ | ✅ | ✅ |
| Syntax Highlighting | ✅ | ❌ | ❌ | ✅ |
| Job Notifications | ✅ | ✅ | ✅ | ✅ |

---

## Troubleshooting

### Job not responding to fg
- Make sure the process hasn't terminated
- Check with `jobs` to see current status
- Try `kill -CONT <pid>` manually

### Background job output interfering
- Redirect stdout/stderr to files:
  ```bash
  long_command > output.txt 2> errors.txt &
  ```

### Too many jobs
- Clean up completed jobs (automatic on next `jobs` call)
- Kill unwanted jobs: `kill %1` or `kill <pid>`

---

## Implementation Stats

- **New Code**: ~500 lines
- **New Structs**: Job, JobStatus enum
- **New Functions**: 
  - sigchld_handler()
  - setup_signals()
  - cleanup_jobs()
  - add_job()
  - find_job_by_id()
  - highlight_syntax()
- **Modified Functions**: 
  - execute_program() (added background parameter)
  - main() (signal setup, terminal control)
- **New Builtins**: jobs, fg, bg
- **Total Lines**: ~2280 (was ~1770)

---

## Future Enhancements

- [ ] Job names in addition to IDs
- [ ] %% notation (current job, previous job)
- [ ] disown command
- [ ] notify option for immediate job completion alerts
- [ ] Job control in pipelines (each pipeline stage as separate job)

---

**Enjoy your enhanced shell with full job control!** 🎉
