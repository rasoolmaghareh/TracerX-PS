export N=$1
export LIMIT=$2
cat ./Original/bakery-manual.pre > bakery-manual.c
echo "#define N $N" >> bakery-manual.c
echo "#define LIMIT $LIMIT" >> bakery-manual.c
cat ./Original/bakery-manual.post >> bakery-manual.c
echo "Running N:$N, Limit:$LIMIT" >> result.txt
echo "Running N:$N, Limit:$LIMIT"
gcc bakery-manual.c
{ time   ./a.out > bakery-manual-$1-$2.out ; } &> result$1-$2.txt
