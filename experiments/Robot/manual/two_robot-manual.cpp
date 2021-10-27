#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define N 5

#define INF 9999999
#define MAXRAND 1001
//#define int long

struct systemstate {  int posx1,posy1,posx2,posy2; long q; } ss;
struct pathintp { long q; };
int intp_table[N+1][N+1][N+1][N+1];
int searchspace = 0, intpcount = 0, subcount = 0, nosubcount = 0;
int grid[N][N];
int QUALITY_BOUND = 0;

void init();
struct pathintp search(int,int);
struct pathintp subsumed();
struct pathintp backprop(int, struct pathintp);
struct pathintp combine_half_interpolant(struct pathintp pi[4]);
void store_interpolant(struct systemstate ,struct pathintp);
void print_pc();
void print_savetick();
void print_intp(int);
void print_one_intp(int);

 main() {
    init(); search(0,0);
    printf("FINAL: Searchspace %d Table %d Subcount %d Nosub %d\n", searchspace, intpcount, subcount, nosubcount);
    return 0;
}

void init() {
	  srand(12345);
	  for (int i = 1; i <= N; i++) {
	    for (int j = i + 1; j <= N; j++) {
	      // if ((i + j) % 3)
	    	grid[i][j] = 1 + (rand() % (MAXRAND + 1));
	    	QUALITY_BOUND += grid[i][j];
	    }
	  }
	  grid[1][N] = 8888;

    for (int i = 0; i <= N; i++)
        for (int j = 0; j <= N; j++)
            for (int k = 0; k <= N; k++)
    			for (int l = 0; l <= N; l++) intp_table[i][j][k][l] = -1;

    ss.posx1 = 0; ss.posy1 = 0;
	ss.posx2 = 0; ss.posy2 = 0;
	ss.q = 0;

}

struct pathintp search(int level, int parentid) {
    int k = 0;
    struct systemstate ss0;
    struct pathintp pi[4], ti;
    if (ss.posx1 > N || ss.posy1 > N || ss.posx2 > N || ss.posy2 > N) {
    	ti.q = INF; return ti;
    }
    searchspace++;
    //printf("[%d] Search(%d, parent %d): posx1 = %d posy1 = %d posx2 = %d posy2 = %d\n",level,  searchspace, parentid, ss.posx1, ss.posy1, ss.posx2, ss.posy2);

    if (ss.posx1 == N && ss.posy1 == N && ss.posx2 == N && ss.posy2 == N) {
    	ti.q = QUALITY_BOUND-ss.q; return ti;
    }

    ti = subsumed();
    if (ti.q != -1) return ti;

    ss0 = ss;
    for (int choice = 0; choice < 4; choice++) {
        switch (choice) {
        case 0: {
        	ss.posx1++;
        	int q = grid[ss.posx1][ss.posy1];
			if (q % 2 != 0) q = 0;
			ss.q += q;
        	pi[0] = backprop(q, search(level+1, 0));
        	goto NEXT_CHOICE;;
        }
        case 1: {
        	ss.posy1++;
        	int q = grid[ss.posx1][ss.posy1];
			if (q % 2 != 0) q = 0;
			ss.q += q;
        	pi[0] = backprop(q, search(level+1, 0));
        	goto NEXT_CHOICE;;

        }
        case 2: {
        	ss.posx2++;
        	int q = grid[ss.posx2][ss.posy2];
			if (q % 2 != 1) q = 0;
			ss.q += q;
        	pi[0] = backprop(q, search(level+1, 0));
        	goto NEXT_CHOICE;;
        }
        case 3: {
        	ss.posy2++;
        	int q = grid[ss.posx2][ss.posy2];
			if (q % 2 != 1) q = 0;
			ss.q += q;
        	pi[0] = backprop(q, search(level+1, 0));
        	break;
        }
        NEXT_CHOICE: ss = ss0;
        }
    }
    // now combine path interpolants
    ti = combine_half_interpolant(pi);
    store_interpolant(ss0,ti);
    //printf("Return from level %d\n", level);
    return ti;
}

struct pathintp backprop(int q, struct pathintp pi) {
	pi.q -= q;
	return pi;
}

struct pathintp combine_half_interpolant(struct pathintp pi[4])
{
	struct pathintp ti;
	ti.q = INF;
	if (pi[0].q <= ti.q) ti.q = pi[0].q;
	if (pi[1].q <= ti.q) ti.q = pi[1].q;
	if (pi[2].q <= ti.q) ti.q = pi[2].q;
	if (pi[3].q <= ti.q) ti.q = pi[3].q;
	return ti;
}

void store_interpolant(struct systemstate ss, struct pathintp ti)
{
	intp_table[ss.posx1][ss.posy1][ss.posx2][ss.posy2] = ti.q;
	intpcount++;
}

struct pathintp subsumed() {
    struct pathintp ti;
    ti.q = intp_table[ss.posx1][ss.posy1][ss.posx2][ss.posy2];
    if (ti.q >= ss.q) { /*printf("Subsumed q = %d, ss.q %d \n", ti.q,ss.q);*/ subcount++; }
    else { 
	printf("Not Subsumed q = %d, %d \n",ti.q, ss.q); 
	ti.q = -1; nosubcount++; 
    }
    return ti;
}

void print_intp(int k) {
    // for (int k = 0; k < next_intp; k++) printf("Intp_Table[%d] = (%d, %d)\n", k, intp_table[k].p, intp_table[k].b);
}

void print_one_intp(int k) {
    // printf("Intp_Table[%d] = (%d, %d)\n", k, intp_table[k].p, intp_table[k].b);
}

