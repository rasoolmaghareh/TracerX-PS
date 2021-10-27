export N=$1
export B=$2
cat ./Original/procon.pre > procon.c
echo "#define N $N" >> procon.c
echo "#define B $B" >> procon.c
cat ./Original/procon.post >> procon.c
echo "Running N:$N, B:$B" >> result.txt
{ time timeout 3600 ./cbmc procon.c > procon-$N-$B.out ; } &>> result.txt
