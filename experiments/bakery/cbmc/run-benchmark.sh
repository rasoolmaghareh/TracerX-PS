export N=$1
export LIMIT=$2
cat ./Original/bakery.pre > bakery.c
echo "#define N $N" >> bakery.c
#echo "#define LIMIT $LIMIT" >> bakery.c
cat ./Original/bakery.post >> bakery.c
echo "Running N:$N, Limit:$LIMIT" >> result.txt
echo "Running N:$N, Limit:$LIMIT"
{ time timeout 3600 ./cbmc bakery.c > bakery$1-$2.out ; } &>> result.txt
