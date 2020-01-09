
program="rcsp"
sed s/"#define N [0-9]*"/"#define N $1"/ < $program.c > $program.c2
rm $program.c
mv $program.c2  $program.c
gcc -o $program $program.c -lm
./$program > $1.out
export NDLFile=($(sed -n 's/Output NDL://p' $1.out))
export NDLBound=($(sed -n 's/Bound for NDL://p' $1.out))
echo 
echo "Running NDL!"
echo
for ((i=0;i<${#NDLFile[@]};++i)); 
do
	./celebes ${NDLFile[i]} #> ${NDLFile[i]}.out
	echo "NDL, $1, $((i+1)), ${NDLBound[i]}, 0"  >> "rcsp.csv"
done
echo "Running NDL Finished."

