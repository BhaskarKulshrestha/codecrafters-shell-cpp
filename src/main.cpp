#include <iostream>
#include <string>
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
    cout <<line<<": command not found"<< endl;
  }
}
