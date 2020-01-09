from __future__ import print_function
from ortools.linear_solver import pywraplp
import time
import sys

def main():
  solver = pywraplp.Solver('SolveAssignmentProblemMIP',
                           pywraplp.Solver.CBC_MIXED_INTEGER_PROGRAMMING)

  cost = [90, 75, 75, 70, 115,
          35, 85, 55, 65, 125,
          125, 95, 90, 105, 135,
          45, 110, 95, 115, 145,
          60, 105, 80, 75, 155,
          45, 65, 110, 95, 145,
          90, 75, 75, 70, 135,
          60, 105, 80, 75, 125,
          45, 65, 110, #95, 115,
          45, 65, 110, 95, 45]
          
  WEIGHT_BOUND = 0
  for i in range(len(cost)):
    WEIGHT_BOUND = WEIGHT_BOUND + cost[i]
  print('Sum = ', WEIGHT_BOUND)
  WEIGHT_BOUND = (WEIGHT_BOUND / 2)
  if (WEIGHT_BOUND % 2 == 0):
    WEIGHT_BOUND = WEIGHT_BOUND + 1
  print('WEIGHT_BOUND = ', WEIGHT_BOUND)
  print('Size = ', len(cost))

  start = time.time()

  num_workers = len(cost)
  bb = {}

  for i in range(num_workers):
      bb[i] = solver.BoolVar('bb[%i]' % (i))

  # Objective
  # solver.Minimize(solver.Sum([x[i] for i in range(num_workers)]))
  
  # Constraints

  # Each worker is assigned to at most 1 task.

  # for i in range(num_workers):
  #  solver.Add(solver.Sum([x[i, j] for j in range(num_tasks)]) <= 1)

  # Each task is assigned to exactly one worker.

  # for j in range(num_tasks):
  #  solver.Add(solver.Sum([x[i, j] for i in range(num_workers)]) == 1)

  # Each team takes on two tasks.

  # solver.Add(solver.Sum([x[i, j] for i in team1 for j in range(num_tasks)]) <= team_max)
  # solver.Add(solver.Sum([x[i, j] for i in team2 for j in range(num_tasks)]) <= team_max)

  solver.Add(solver.Sum([cost[i] * bb[i] for i in range(num_workers)]) == 2007)
  
  sol = solver.Solve()

  print('Max profit = ', solver.Objective().Value())
  print()
  #print("Time = ", solver.WallTime(), " milliseconds")
  end = time.time()
  sys.stderr.write ('\nPython time:')
  sys.stderr.write(str(end - start))
  sys.stderr.write ('\n')

  printStr = "Py, "+str(num_workers) +", Yes, - ," + str(int(solver.Objective().Value())) + "," + str(int(solver.Objective().Value())) +  ", - ," + str(end - start)+ "\n"
  f= open("knapsack.csv","a")
  f.write(printStr)
  f.close()

if __name__ == '__main__':
  main()
