//
// Created by workshop on 8/27/2019.
//

#include "parking.h"
#include <algorithm>
#include <climits>
#include <iostream>
#include <vector>

using namespace std;

bool Graph::addVertex(const vector<int> &car) {
  for (int i = 0; i < car.size(); i++)
    state.push_back(car[i]);

  vector<int> v;
  for (int i = 0; i < car.size(); i++)
    v.push_back(car[i]);
  nodes.push_back(v);
  /*    auto itr = nodes.find(car);
      if (itr == nodes.end()) {
          vertex *v;
          v = new vertex(car);
          nodes[car] = v;
          return true;
      }

      return false;*/
}

bool Graph::addEdge(const vector<int> &from, const vector<int> &to,
                    double cost) {
  auto itr = find(nodes.begin(), nodes.end(), to);
  if (itr == nodes.end()) {
    vector<int> v;
    for (int i = 0; i < to.size(); i++)
      v.push_back(to[i]);
    nodes.push_back(v);
    return true;
  }
  return false;

  /*    addVertex(to);
      vertex *f = (nodes.find(from)->second);
      vertex *t = (nodes.find(to)->second);
      pair<int, vertex *> edgeFrom = make_pair(cost, t);
      pair<int, vertex *> edgeTo = make_pair(cost, f);
      if (!count(f->vertices.begin(), f->vertices.end(), edgeFrom)) {
          f->vertices.push_back(edgeFrom);
          t->vertices.push_back(edgeTo);
          return true;
      }

      return false;*/
}

bool Graph::removeEdge(const vector<int> &from, const vector<int> &to,
                       double cost) {

  std::vector<vector<int>>::iterator position =
      std::find(nodes.begin(), nodes.end(), to);
  if (position != nodes.end())
    nodes.erase(position);
  /*    addVertex(to);
      vertex *f = (nodes.find(from)->second);
      vertex *t = (nodes.find(to)->second);
      pair<int, vertex *> edgeFrom = make_pair(cost, t);
      pair<int, vertex *> edgeTo = make_pair(cost, f);
      if (count(f->vertices.begin(), f->vertices.end(), edgeFrom)) {
          f->vertices.erase(remove(f->vertices.begin(), f->vertices.end(),
     edgeFrom), f->vertices.end());
          t->vertices.erase(remove(t->vertices.begin(), t->vertices.end(),
     edgeTo), t->vertices.end());
          return true;
      }

      return false;*/
}

void Graph::print() {
  for (int i = 0; i < paths; ++i)
    cout << "  ";
  cout << "Print Length:" << paths << " Paths:";
  for (auto &it : state) {
    /*for (int i = 0; i < it.second->state.size(); i++) {
        cout << it.second->state.at(i) << " ";
    }
    cout << ": ";
    for (auto &state : it.second->vertices) {
        for (int i : state.second->state) {
            cout << i << " ";
        }
        cout << "- ";
    }*/
    cout << it << " ";
  }
  cout << ", Goal:";
  for (auto &it : goal) {
    /*for (int i = 0; i < it.second->state.size(); i++) {
        cout << it.second->state.at(i) << " ";
    }
    cout << ": ";
    for (auto &state : it.second->vertices) {
        for (int i : state.second->state) {
            cout << i << " ";
        }
        cout << "- ";
    }*/
    cout << it << " ";
  }
  cout << endl;
}

void Graph::explore(vector<int> &src) {
  state = src;
  // print();
  if (src == goal) {
    solutions++;
    goalReached = 1;
    return;
  }

  if (checkMemo(src)) {
    // cout << "Memo: Already traversed" << endl;
    //        cout << "Solution: " << solutions << ", path: " << paths << endl;
    return;
  }

  if (paths >= BOUND) {
    return;
  }

  for (int i = 0; i < src.size(); ++i) {
    if (src.at(i) == 0) { // empty slot
      for (int j = 0; j < src.size(); ++j) {
        if (src.at(j) == 0) { // don't swap empty slots
          continue;
        }

        vector<int> dest = src;
        iter_swap(dest.begin() + i, dest.begin() + j);
        if (addEdge(src, dest, 1)) {
          paths++;
          explore(dest);
          if (goalReached == 1)
            return;
          removeEdge(src, dest, 1);
          paths--;
        }
      }
    }
  }
  memo(src);
}

Graph::Graph(vector<int> &goal) {
  this->goal = goal;
  paths = 0;
  solutions = 0;
  BOUND = INT_MAX;
}

bool Graph::checkMemo(vector<int> &car) {
  if (useMemo) {
    auto state = memoMap.find(car);
    if (state != memoMap.end() && memoMap[car] <= paths) {
      /*for (auto p : state->second) {
          if (p <= paths) {
              return true;
          }
      }*/
      return true;
    }
  }

  return false;
}

bool Graph::memo(vector<int> &car) {
  memoMap[car] = paths; //.push_back(paths);
  return true;
}
