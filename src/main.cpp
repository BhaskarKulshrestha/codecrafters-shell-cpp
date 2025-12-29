#include <iostream>
#include <string>
#include <sstream>
#include <unordered_set>
#include <cstdlib>      // getenv
#include <unistd.h>     // access
using namespace std;

/* ---------- Builtin check ---------- */
bool is_builtin(const string& command) {
    static unordered_set<string> builtins = {"echo", "exit", "type"};
    return builtins.count(command);
}

/* ---------- PATH search ---------- */
bool find_executable_in_path(const string& command, string& full_path) {
    char* path_env = getenv("PATH");
    if (!path_env) return false;

    string path(path_env);
    stringstream ss(path);
    string dir;

    while (getline(ss, dir, ':')) {
        if (dir.empty()) continue;

        string candidate = dir + "/" + command;

        // Check: exists + executable
        if (access(candidate.c_str(), X_OK) == 0) {
            full_path = candidate;
            return true;
        }
    }
    return false;
}

/* ---------- type command logic ---------- */
void check_command_validity(const string& command) {
    if (is_builtin(command)) {
        cout << command << " is a shell builtin" << endl;
        return;
    }

    string full_path;
    if (find_executable_in_path(command, full_path)) {
        cout << command << " is " << full_path << endl;
    } else {
        cout << command << ": not found" << endl;
    }
}

int main() {
    // Flush after every output
    cout << unitbuf;
    cerr << unitbuf;

    while (true) {
        cout << "$ ";

        string line;
        if (!getline(cin, line)) break;

        stringstream ss(line);
        string command;
        ss >> command;

        /* ---------- exit ---------- */
        if (command == "exit") {
            break;
        }

        /* ---------- type ---------- */
        else if (command == "type") {
            string arg;
            while (ss >> arg) {
                check_command_validity(arg);
            }
        }

        /* ---------- echo ---------- */
        else if (command == "echo") {
            string word;
            while (ss >> word) {
                cout << word << " ";
            }
            cout << endl;
        }

        /* ---------- unknown ---------- */
        else {
            check_command_validity(command);
        }
    }

    return 0;
}
