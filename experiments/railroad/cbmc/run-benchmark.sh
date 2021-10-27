#export N=$1
export LIMIT=$1
cat ./Original/railroad.pre > railroad.c
#echo "#define N $N" >> railroad.c
echo "#define LIMIT $LIMIT" >> railroad.c
cat ./Original/railroad.post >> railroad.c
echo "Running Limit:$LIMIT" >> result.txt
echo "Running Limit:$LIMIT"
{ time timeout 3600 ./cbmc railroad.c > railroad$1.out ; } &>> result.txt
