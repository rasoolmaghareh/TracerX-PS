export N=$1
export LIMIT=$2
cat ./Original/bakery.pre > bakery.c
echo "#define N $N" >> bakery.c
echo "#define LIMIT $LIMIT" >> bakery.c
cat ./Original/bakery.post >> bakery.c
echo "Running N:$N, Limit:$LIMIT" >> result.txt
clang -emit-llvm -g -I/usr/local/lib/tracerx/include -I/usr/local/lib/tracerx/../include -Wno-int-conversion -c bakery.c
{ time timeout 3600 klee -wp-interpolant  -use-query-log=all:pc,all:smt2 -no-output -only-output-states-covering-new -search=dfs -allocate-determ -solver-backend=z3 -output-dir=bakery-$N-$LIMIT.tx bakery.bc  ; } &>> result.txt

