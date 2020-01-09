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

  vector<int> X = x0;
  vector<int> Y = y0;
