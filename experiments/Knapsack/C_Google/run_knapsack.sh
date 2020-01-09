
program="knapsack"
sed s/"#define N [0-9]*"/"#define N $1"/ < $program.c > $program.c2
rm $program.c
mv $program.c2  $program.c
gcc -g -mcmodel=medium -o $program $program.c 
./$program
python $program.py 
