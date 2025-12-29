#include <iostream>
#include <string>
#include <sstream>
#include <unordered_set>
using namespace std;

void check_command_validity(string command){
  unordered_set<string> commands = {"echo", "exit", "type"};
  cout <<command<<": command not found"<< endl;

  if(commands.find(command) == commands.end()){
    cout <<command<<": command not found"<< endl;
    exit(0);
  }
  else{
    cout<<command<<" is a shell builtin"<< endl;
  }
}

int main() {
  // Flush after every std::cout / std:cerr
  cout << unitbuf;
  cerr << unitbuf;

  // TODO: Uncomment the code below to pass the first stage
  while(1){
    cout << "$ ";
    string line;
    if (!getline(cin, line)) {
      break;
    }
    if(line == "exit"){
      break;
    }

    else if(line.substr(0, 4) == "type"){
      string command = line.substr(5);
      stringstream ss(line);
      string seprated_words_with_spaces;

      while(ss >> seprated_words_with_spaces){
          check_command_validity(seprated_words_with_spaces);
      }
    }
    
    else if(line.substr(0, 4) == "echo"){
      stringstream ss(line);
      string seprated_words_with_spaces;
      while(ss >> seprated_words_with_spaces){
        if(seprated_words_with_spaces != "echo"){
          cout << seprated_words_with_spaces << " ";
        }
      }
      cout << endl;
      continue;
    }
  }
}
