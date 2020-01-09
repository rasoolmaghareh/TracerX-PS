export BENCHMARK=$1
export UB=$2
cp C_input/${BENCHMARK}.cpp main.cpp
echo "int LENGTH = $UB;" >> main.cpp 
cat C_input/main.cpp >> main.cpp
g++ -std=c++14 parking.cpp main.cpp
./a.out &> ${BENCHMARK}cpp1.out
export RTCPP=$(cat ${BENCHMARK}cpp1.out | grep 'Total execution time:' |   grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
export OPTCPP=$(cat ${BENCHMARK}cpp1.out | grep 'Optimal Solution:' |   grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
echo "C, ${BENCHMARK}, $OPTCPP ,$RTCPP" >> result.csv

