export N=$1
export B=$2
cat ./Original/fischer.pre > fischer.c
echo "#define N $N" >> fischer.c
echo "#define BOUND $B" >> fischer.c
cat ./Original/fischer.post >> fischer.c
echo "Running N:$N, Bound:$B" >> result.txt
clang -emit-llvm -g -I/usr/local/lib/tracerx/include -I/usr/local/lib/tracerx/../include -Wno-int-conversion -c fischer.c
{ time timeout 3600 klee -wp-interpolant -use-query-log=all:pc,all:smt2 -only-output-states-covering-new -search=dfs -allocate-determ -solver-backend=z3 -output-dir=procon-$N-$B.tx fischer.bc  ; } &>> result.txt

