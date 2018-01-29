#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <cmath>
#include "adjacency_list.hpp"

using namespace std;

// ---------------------------------------------------------------
// Input File Parser
// ---------------------------------------------------------------

string read_line(istream &in) {
  char c;
  string str;

  in.get(c); 
  while(!in.eof() && c != '\n') {
    if(c != '\r') {
      str = str + c;
    }
    in.get(c);  
  }

  return str;
}

int parse_number(unsigned int &pos, string const &str) {
  int s = pos;
  while(pos < str.length() && isdigit(str[pos])) {
    pos = pos + 1;
  }
  stringstream ss(str.substr(s,pos));
  int r;
  ss >> r;
  return r;
}

void match(char c, unsigned int &pos, string const &str) {
  if(pos >= str.length() || str[pos] != c) { 
    std::ostringstream out;
    out << "syntax error -- expected '" << c << "', got '" << str[pos] << "'";
    throw runtime_error(out.str()); 
  }
  ++pos;
}

void skip(unsigned int &pos, string const &in) {
  while(pos < in.length() && (in[pos] == ' ' || in[pos]=='\t')) {
    pos++;
  } 
}

template<class G>
G read_graph(string in) {
  vector<pair<unsigned int, unsigned int> > edgelist;
  unsigned int V = 0, pos = 0;
    
  bool firstTime=true;

  while(pos < in.length()) {
    if(!firstTime) { match(',',pos,in); }
    firstTime=false;
    // just keep on reading!
    unsigned int tail = parse_number(pos,in);
    match('-',pos,in); match('-',pos,in);
    unsigned int head = parse_number(pos,in);
    V = max(V,max(head,tail));
    edgelist.push_back(std::make_pair(tail,head));
  }  

  if(V == 0) { return G(0); }

  G r(V+1);

  for(vector<pair<unsigned int, unsigned int> >::iterator i(edgelist.begin());
      i!=edgelist.end();++i) {
    r.add_edge(i->first,i->second);
  }

  return r;
}
// ---------------------------------------------------------------
// Main Method
// ---------------------------------------------------------------

typedef adjacency_list<> graph_t;

int main(int argc, char *argv[]) {
  string graphString = read_line(cin);
  graph_t graph = read_graph<graph_t>(graphString);
  //
  // Now, print the adjacency matrix
  //
  cout << graph.num_vertices();

  for(int i=0;i!=graph.num_vertices();i=i+1) {
    for(int j=0;j!=graph.num_vertices();j=j+1) {
      if(graph.is_edge(i,j)) {
	cout << " 1";
      } else {
	cout << " 0";
      }
    }
  }
  cout << endl;
}

