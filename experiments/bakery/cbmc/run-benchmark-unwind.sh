export N=$1
export LIMIT=$2
cat ./Original/bakery.pre > bakery.c
echo "#define N $N" >> bakery.c
#echo "#define LIMIT $LIMIT" >> bakery.c
cat ./Original/bakery.post >> bakery.c
echo "Running N:$N, Limit:$LIMIT" >> result-unwind.txt
echo "Running N:$N, Limit:$LIMIT"
export UNWIND=$(($LIMIT*$N*10))
echo $UNWIND
{ time timeout 3600 ./cbmc -unwind $UNWIND bakery.c > bakery$1-$2.out ; } &>> result-unwind.txt
