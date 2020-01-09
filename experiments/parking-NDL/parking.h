//
// Created by workshop on 8/27/2019.
//

#ifndef PARKING_CPP_PARKING_H
#define PARKING_CPP_PARKING_H

#include <map>
#include <string>
#include <utility>
#include <vector>

using namespace std;

struct vertex {
  typedef pair<int, vertex *> Vertex;
  vector<Vertex> vertices; // cost of edge, destination vertex
  vector<int> state;

  explicit vertex(vector<int> s) : state(std::move(s)) {}
};

class Graph {
public:
  // typedef map<vector<int>, vertex *> VectorMap;
  typedef map<vector<int>, int> MemoMap;
  vector<int> state;
  vector<vector<int>> nodes;
  MemoMap memoMap;
  vector<int> goal;
  unsigned long paths;
  unsigned long BOUND;
  int solutions;
  bool useMemo = true;
  int goalReached = 0;

  Graph(vector<int> &goal);

  bool addVertex(const vector<int> &car);

  bool addEdge(const vector<int> &from, const vector<int> &to, double cost);

  bool removeEdge(const vector<int> &from, const vector<int> &to, double cost);

  void print();

  void explore(vector<int> &src);

  bool checkMemo(vector<int> &car);

  bool memo(vector<int> &car);
};

#endif // PARKING_CPP_PARKING_H
