export N=$1
cat ./Original/two_robot-manual.pre > two_robot-manual.cpp
echo "#define N $N" >> two_robot-manual.cpp
cat ./Original/two_robot-manual.post >> two_robot-manual.cpp
echo "Running N:$N" >> result.txt
echo "Running N:$N"
g++  -g -mcmodel=medium two_robot-manual.cpp
{ time   ./a.out > two_robot-manual-$1.out ; } &> result$1.txt
