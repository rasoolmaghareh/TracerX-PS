/*
 * Copyright 2020 National University of Singapore
 *
 */

#include <klee/klee.h>
#include <stdlib.h>

#define N 10
#define INF 9999999
#define QUALITY_BOUND 100000

int grid[N][N] = {
	{   0, 571, 127, 746,  82, 819, 360, 424, 404,8888},
	{   0,   0, 773, 404, 691, 517,  49, 925, 197,  24},
	{   0,   0,   0, 310,  97, 255, 633, 466, 360, 583},
	{   0,   0,   0,   0, 227, 109, 958, 709, 493, 573},
	{   0,   0,   0,   0,   0, 573, 319,  45, 864, 366},
	{   0,   0,   0,   0,   0,   0, 952, 503, 524, 915},
	{   0,   0,   0,   0,   0,   0,   0, 205, 658, 467},
	{   0,   0,   0,   0,   0,   0,   0,   0, 582, 379},
	{   0,   0,   0,   0,   0,   0,   0,   0,   0,  59},
	{   0,   0,   0,   0,   0,   0,   0,   0,   0,   0}
};


main() {
int posx1 = 0, posx2 = 0;
int posy1 = 0, posy2 = 0;
int posx = 0, posy = 0;
int q = 0,current_q = 0;

	while(1){
		if (posx == N-1 && posy == N-1)  goto FEASIBLE;
		char b; klee_make_symbolic(&b, sizeof(char), "b");
		char c; klee_make_symbolic(&c, sizeof(char), "c");
				
		if(b){ 
		    if (c) posx1++;
		    else posy1++;
		    posx = posx1; posy = posy1;
		}else{ if (c) posx2++;
		    else posy2++;
		    posx = posx2; posy = posy2;
		}
		//printf("posx1, posy1, posx2, posy2:%d,%d,%d,%d\n ",posx1, posy1, posx2, posy2);
		if (posx < 0 || posx >= N) goto INFEASIBLE;
		if (posy < 0 || posy >= N) goto INFEASIBLE;
		if (b){
		    q = grid[posx][posy];
		    if (q % 2 != 0) q = 0;
		}else{
		    q = grid[posx][posy];
		    if (q % 2 != 1) q = 0;
		}
		current_q += q;
	}

FEASIBLE: 
	  //printf("quality:%d\n",current_q);
	  klee_assert(current_q <= QUALITY_BOUND);
INFEASIBLE:
	  return 0;
}