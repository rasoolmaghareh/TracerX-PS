export BENCHMARK=$1
./celebes LB_NDL/${BENCHMARK}.ndl &> ${BENCHMARK}ndl1.out
cat ${BENCHMARK}ndl1.out
export RTNDL=$(cat ${BENCHMARK}ndl1.out | grep RUNTIME: |   grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
export UB=$(cat ${BENCHMARK}ndl1.out | grep 'PLAN ACTIONS:' |   grep -Eo '[+-]?[0-9]+([.][0-9]+)?')
echo "$NDL,{BENCHMARK}, $UB, $RTNDL" >> result.csv

