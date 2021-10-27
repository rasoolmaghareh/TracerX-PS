#export N=$1
export LIMIT=$1
cat ./Original/railroad.pre > railroad.c
#echo "#define N $N" >> railroad.c
echo "#define LIMIT $LIMIT" >> railroad.c
cat ./Original/railroad.post >> railroad.c
echo "Running Limit:$LIMIT" >> result.txt
echo "Running Limit:$LIMIT"
clang -emit-llvm -g -I/usr/local/lib/tracerx/include -I/usr/local/lib/tracerx/../include -Wno-int-conversion -c railroad.c
{ time timeout 3600 /usr/local/lib/tracerx/bin/klee -output-tree -write-pcs -no-output -use-query-log=all:pc,all:smt2 -only-output-states-covering-new -search=dfs -solver-backend=z3 -output-dir=railroad-$LIMIT.tx railroad.bc ; } &>> result.txt

