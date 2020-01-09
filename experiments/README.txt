===============================================================================
1. Summary:
===============================================================================

The experiments reported in the paper were performed on a machine with Core
i7-6700 at 3.40 GHz Linux box (Ubuntu 16.1) with 32GB RAM and 32 GB swap memory.

We have added one folder for each of the example benchmarks reported in the 
table. We are submitting the following folders:

|--Knapsack
|--Robot
|--RCSP
|--Parking

-------------------------------------------------------------------------------

We have been comparing our approach with the following baseline approaches:

1- NDL:
We experimented on the NDL to SMT translator from this link:
https://users.aalto.fi/~rintanj1/PlanningBySMT.html

The author was contacted for receiving the NDL software.

-------------------------------------------------------------------------------

2- Z3 (Only used for experiments on Knapsack):

We experimented on a binary version of Z3

-------------------------------------------------------------------------------

3- Google OR Tools (Only used for experiments on Knapsack):

We use the Google OR-tools CP-SAT solver for our experiments. It is accessible 
from this link:

https://developers.google.com/optimization/cp/cp_solver

-------------------------------------------------------------------------------

Our approach:

The code of the benchmarks for our approach were implemented with c or c++ and 
were compiled using gcc and g++. 
 
===============================================================================
2. Knapsack Benchmark:
===============================================================================
The Knapsack folder contains the following subfolders:

|--NDL
|--Z3
|--C_Google

The NDL folder contains knapsack30.ndl which is the NDL model we used for the
Knapsack problem with NDL. We also pasted a sample SMT output of NDL in the
subfolder "sample SMT Output". Note that NDL generates SMT formulas for 10 
bounds.
 
The Z3 folder contains the knapsack20 to knapsack50 which are the sample SMT
formulas we ran for the knapsack problem with size up to 50.

The C_Google folder contains the code that we ran for our approach and CP 
Solver. The files knapsack.c and knapsack.py are the implementation of 
the knapsack problem using our approach and CP Solver. The files contain the
dataset which was used to compare these two methods for up to size 50.

We compared with NDL and Z3 on another dataset. Knapsack2.c contains the dataset
that we used to compare with Z3 and NDL. Note that the second data set seems to
be more difficult to solve since the distribution range is more. While the 
three baseline approaches scalability varies on different data sets our approach
remains scalable on both data sets.

Finally, knapsack3.c contains the random data generator and the code that we 
used to test our file on sizes greater than 50.  

The scripts run_knapsack.sh and run_knapsack3.sh can be used to rerun our 
experiments. The input to these scripts should be the size parameter. 
For example:

run_knapsack.sh 40
run_knapsack3.sh 500

The outputs are written to knapsack.csv

===============================================================================
3. Robot Benchmark:
===============================================================================
The Robot folder contains the following files:

robot.c:
The C code is the implementation of the robot problem using our approach. This
file randomly generates a dataset with size N and runs our approach for multiple 
iterations to find an optimal solution.

In the end, it writes the output to the robot.csv file and also it generates
one NDL model for each bound that was tested: robot1.ndl, robot2.ndl and etc.

For example, we have added the output NDL models for size 50. There are 11 files
robot1.ndl to robot11.ndl since 11 bounds were tested before the optimal bound
was reached. 

The randomly generated grid and tested bound for each size can be seen in the 
files 10.out to 50.out. The Res value can be ignored for these benchmarks.

The scripts run_robot.sh can be used to run our approach for each size. The 
script, generates the required NDL models and runs them (if the NDL to SMT
software is added to this folder): 

run_robot.sh 40

The outputs of our approach and NDL are written to robot.csv. Since, NDL runs 
till timeout in case of unsatisfiability, the script does not record the time of
NDL. We recorded the time of NDL manually. 

In order to be fair, we did not report timout when running NDL on an 
unsatisfiable bound. We  only ran NDL while it was reporting the bound
was UNSAT and reported that time (which is shorter than timeout).

Note: We should add that for sizes more than 2000, you might require to run 
these instructions for compiling and running our code on your Linux machine:

gcc -fstack-protector -g -O0 -std=c99 main.c
ulimit -c unlimited && rm -f core
./a.out

===============================================================================
4. RCSP Benchmark:
===============================================================================
The RCSP folder contains the following files:

rcsp.c:
The C code is the implementation of the RCSP problem using our approach. This
file randomly generates a dataset with size N and runs our approach for multiple 
iterations to find an optimal solution.

In the end, it writes the output to the rcsp.csv file and also it generates
one NDL model for each bound that was tested: rcsp1.ndl, rcsp2.ndl and etc.

For example, we have added the output NDL models for size 50. There are 10 files
rcsp1.ndl to rcsp6.ndl since 6 bounds were tested before the optimal bound
was reached. The and tested bound for size 50 can be seen in the file 50.out. 
The Res value here indicates the resource value.

A sample of the randomly generated grid for size 10 can be seen in the file 
graph.txt. 

The scripts run_rcsp.sh can be used to run our approach for each size. The 
script, generates the required NDL models and runs them (if the NDL to SMT
software is added to this folder): 

run_rcsp.sh 40

The outputs of our approach and NDL are written to rcsp.csv. The file currently
contains the results for bound 50 (our approach and NDL) and bound 1000 (for 
our approach). Since, NDL runs till timout in case of unsatisfiability, the 
script does not record the time of NDL. We recorded the time of NDL manually. 

In order to be fair, we did not report timout when running NDL on an 
unsatisfiable bound. We  only ran NDL while it was reporting the bound
was UNSAT and reported that time (which is shorter than timeout).

===============================================================================
4. Parking Benchmark:
===============================================================================
The Parking folder contains our experiments on 8 instances of the "parking" 
benchmark from the PDDL 2.1 benchmarks. We have experimented on the NDL version
of the parking benchmarks available here:

https://users.aalto.fi/~rintanj1/PlanningBySMT.html

We converted these benchmarks to a classic planning problem. 

The files in the folder are as follows:

1- interpreter.py: This python script reads an NDL instance of the parking 
benchmarks and extracts the initial and goal states of it. These information is
later used by our approach.

2- The C_input folder contains 8 files main00.cpp to main07.cpp which contain the 
initial and goal states of the 8 parking instances (arrays x0 to x7 indicate
initial state and arrays y0 to y7 indicate the goal states). The remaining file
main.c contains the remainder of the code used in our approach. The 
run-benchmark.sh script receives the name of one instance and a to-be-tested 
bound:

run-benchmark.sh main01 10

It first combines the files from the C_input folder and the to-be-tested bound
and generates a main.c file in the parking folder. It then compiles this file
and the files parking.cpp and parking.c. and generates the executable file 
a.out. This file is then ran to generate the lower and upper bound reported by 
our approach. 

In the end, the outputs are written to the rcsp.csv file. The outputs from our
approach are added to the folder C_Output folder. 

3- The LB_NDL folder contains the original benchmarks. By running the 
run-benchmark-LB-ndl.sh script and providing the name of each of the instances,
NDL will run and generate a solution for the parking planning problem. This
run will generate a lower bound generated by NDL:

run-benchmark-LB-ndl.sh parking00

4- The UB_NDL folder contains an updated version of the original benchmarks. We
have added an step counter which is increased each time an action is fired. In 
the goal we add a condition on step. This way we force NDL to compute a specific 
bound. The bounds added to the instances in the UB_NDL folder is equal to the
UB bound that our approach was able to compute within timeout. By running the 
run-benchmark-UB-ndl.sh script and providing the name of each of the instances,
NDL will run and test the provided upper bound (proving its unsatisfiability):

run-benchmark-UB-ndl.sh parking00

In order to be fair, we did not report timout when running NDL on an 
unsatisfiable bound. We  only ran NDL while it was reporting the bound
was UNSAT and reported that time (which is shorter than timeout).

The reported time for NDL is table 6 in the paper is the sum of the time for 
the Lower Bound and Upper Bound runs for NDL.
