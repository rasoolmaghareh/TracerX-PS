export N=$1
export B=$2
cat ./Original/procon.pre > procon.c
echo "#define N $N" >> procon.c
echo "#define B $B" >> procon.c
cat ./Original/procon.post >> procon.c
echo "Running N:$N, B:$B" >> result.txt
clang -emit-llvm -g -I/usr/local/lib/tracerx/include -I/usr/local/lib/tracerx/../include -Wno-int-conversion -c procon.c
{ time timeout 3600 klee -wp-interpolant -use-query-log=all:pc,all:smt2 -only-output-states-covering-new -search=dfs -allocate-determ -solver-backend=z3 -output-dir=procon-$N-$B.tx procon.bc  ; } &>> result.txt

