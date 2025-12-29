#include <iostream>
#include <string>
using namespace std;

int main() {
  // Flush after every std::cout / std:cerr
  cout << unitbuf;
  cerr << unitbuf;

  string command;
  cin>>command;

  cout<<"Command not found: "<<command<<endl; 

  // TODO: Uncomment the code below to pass the first stage
  // cout << "$ ";
}
