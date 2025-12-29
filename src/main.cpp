#include <iostream>
#include <string>
#include <sstream>
using namespace std;

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
    else{
      cout <<line<<": command not found"<< endl;
    }

  }
}
