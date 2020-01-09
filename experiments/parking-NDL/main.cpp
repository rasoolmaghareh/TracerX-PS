#include "parking.h"
#include <chrono>
#include <iostream>

using namespace std::chrono;

int main() {
  vector<int> x0 = {0, 0, 0, 3, 2, 0, 4, 5, 6, 1, 0};
  vector<int> y0 = {6, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5};

  vector<int> x1 = {0, 6, 5, 1, 0, 0, 3, 4, 2, 0, 0};
  vector<int> y1 = {6, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5};

  vector<int> x2 = {0, 5, 0, 1, 0, 0, 4, 2, 6, 3, 0};
  vector<int> y2 = {6, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5};

  vector<int> x3 = {0, 0, 1, 0, 0, 5, 6, 3, 4, 2, 0};
  vector<int> y3 = {6, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5};

  vector<int> x4 = {0, 0, 0, 3, 0, 7, 0, 0, 4, 6, 2, 8, 1, 5};
  vector<int> y4 = {7, 8, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6};

  vector<int> x5 = {0, 0, 2, 0, 0, 4, 1, 5, 3, 8, 7, 6, 0, 0};
  vector<int> y5 = {7, 8, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 6};

  vector<int> X = x1;
  vector<int> Y = y1;

  int LENGTH = 10;
  int OPTIMAL = LENGTH;
  int LB = LENGTH;
  int UB = 0;

  // vector<int> factorial = {1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880,
  // 3628800};
  auto start = high_resolution_clock::now();
  cout << "Now CHECKING: " << LB << " " << UB << " " << (LB - UB) * 1.0 / LB
       << endl;
  while ((LB - UB) * 1.0 / LB >= 0.05 && (LB - UB) > 2) {
    Graph g(Y);
    g.addVertex(X);
    g.BOUND = ((LB + UB) / 2); // factorial.at(9) / factorial.at(3);
    cout << "Checking length: " << g.BOUND << endl;
    g.explore(X);
    g.memoMap.clear();
    g.goalReached = 0;
    cout << "Solutions: " << g.solutions << endl;
    if (g.solutions == 0) {
      UB = g.BOUND;
      cout << "No solution found at: " << g.BOUND << endl;
    } else {
      LB = g.BOUND;
      OPTIMAL = g.BOUND;
      cout << "Solution found at: " << g.BOUND << endl;
    }
    cout << "Now CHECKING: " << LB << " " << UB << " " << (LB - UB) * 1.0 / LB
         << endl;
  }
  auto stop = high_resolution_clock::now();
  //    g.print();
  // cout << "Total solutions: " << g.solutions << endl << "Optimized path: " <<
  // g.BOUND-1 << endl
  cout << "Optimal Solution: " << OPTIMAL << endl;
  cout << "Total execution time: "
       << (double)duration_cast<microseconds>(stop - start).count() / 1000000.0
       << endl;
  return 0;
}

/*
    vector<int> x0 = {0, 1, 2};
    vector<int> x1 = {1, 0, 2, 3};
    vector<int> x2 = {1, 0, 2, 3, 4};
    vector<int> x3 = {1, 0, 2, 3, 0};
    vector<int> x4 = {1, 0, 2, 3, 4, 5};
    vector<int> x5 = {5, 1, 0, 3, 4, 2, 0, 0};
    vector<int> x6 = {6, 5, 1, 0, 3, 4, 2, 0, 0};

    vector<int> y0 = {1, 0, 2};
    vector<int> y1 = {3, 1, 0, 2};
    vector<int> y2 = {3, 1, 0, 4, 2};
    vector<int> y3 = {3, 1, 0, 0, 2};
    vector<int> y4 = {3, 1, 5, 0, 4, 2};
    vector<int> y5 = {0, 0, 0, 1, 2, 3, 4, 5};
    vector<int> y6 = {6, 0, 0, 0, 1, 2, 3, 4, 5};
*/
