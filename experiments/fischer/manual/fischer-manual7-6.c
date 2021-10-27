#include <stdio.h>
#include <stdlib.h>

#define N 7
#define PP 4
#define LIMIT 6
#define DELAY 1
#define MAXTABLE 999999999

#define min(a, b) ((a) < (b) ? (a) : (b))
#define max(a, b) ((a) > (b) ? (a) : (b))

struct systemstate {  int pc[N], lock, tick, savetick[N], limit; } ss;
struct pathintp { int pc[N], limit, lock, diff[N]; } intp_table[MAXTABLE];
int limit = LIMIT;
int searchspace = 0, intpcount = 0, subcount = 0, nosubcount = 0;
int exponents[N];

void exit(int);
void init();
struct pathintp search();
void mutex(int);
int subsumed();
void store_interpolant(struct pathintp);
void print_pc();
void print_savetick();
void print_intp(int);
int table_index();

int main() { 
    init(); search(0, -1); 
    printf("FINAL: Searchspace %d Table %d Subcount %d Nosub %d\n", searchspace, intpcount, subcount, nosubcount); 
    return 0; 
}

void init() {
    for (int id = 0; id < N; id++) { ss.pc[id] = 0; ss.savetick[id] = 0; }
    ss.lock = -1;
    ss.tick = 0;
	ss.limit = LIMIT;
    exponents[N - 1] = 1;
    for (int id = N - 2; id >= 0; id--) exponents[id] = PP * exponents[id + 1];
    for (int k = 0; k < MAXTABLE; k++) intp_table[k].limit = -1;
    // for (int id = 0; id < N; id++) printf("exponents[%d] = %d\n", id, exponents[id]);
    // ss.pc[0] = 2; ss.pc[1] = 1; ss.pc[2] = 1;
    // printf("Index <%d %d %d>  = %d\n", ss.pc[0], ss.pc[1], ss.pc[2], table_index()); 
    // exit(0);
}

struct pathintp search(int level, int parentid) {
  int id, min, k;
    struct systemstate ss0; 
    struct pathintp pi[N], ti;
    searchspace++;
    if (searchspace % 100000 == 0) printf("> Searchspace %d Subcount %d Nosub %d\n", searchspace, subcount, nosubcount);

    printf("Search(%d, %d, %d, from %d): lock %2d tick %d : ", level, ss.limit, searchspace, parentid, ss.lock, ss.tick); 
    printf("< "); print_pc(); printf("> --- "); print_savetick(); printf("\n");

    if (ss.limit == 0) { 
        for (int id = 0; id < N; id++) ti.pc[id] = ss.pc[id];
        ti.limit = 0; 
        ti.lock = ss.lock; 
        return ti; 
    }  
    k = subsumed();
    if (k != -1) return intp_table[k];
    ss0 = ss;
    for (id = 0; id < N; id++) {
	    ss.tick++;
        switch (ss.pc[id]) {
        case 0: if (ss.lock == -1) {
			        ss.pc[id] = 1; ss.lock = id; ss.savetick[id] = ss.tick; pi[id] = search(level+1, 0); } break; 
        case 1: if (ss.tick > ss.savetick[id] + DELAY) { ss.pc[id] = 2; } pi[id] = search(level+1, 1); break; 
		case 2: if (ss.lock == id) {
			        ss.pc[id] = 3; pi[id] = search(level+1, 2); } break;
        case 3: mutex(id); ss.lock = -1; ss.pc[id] = 0; pi[id] = search(level+1, 3); break;
        }
        NEXT_ID: ss = ss0;
    }
    // now combine path interpolants

    for (id = 0; id < N; id++) { ti.pc[id] = ss0.pc[id]; ti.diff[id] = ss0.tick - ss0.savetick[id]; }
    ti.limit = ss0.limit;
    ti.lock = ss0.lock;
    store_interpolant(ti);
    // printf("Return level %d\n", level);
    return ti;
}

void store_interpolant(struct pathintp ti) { 
    int k, id, tmp, tmp2;
    k = table_index();
    if (intp_table[k].limit == -1) {
        intpcount++;
        // printf("Storing first intp[%d]: ", k);
        intp_table[k] = ti;
    } else {
        // printf("Updating intp[%d]: ", k);
        intp_table[k].limit = max(intp_table[k].limit, ti.limit);
        for (int id = 0; id < N; id++) intp_table[k].diff[id] = min(intp_table[k].diff[id], ti.diff[id]);
    }
    // print_intp(k);
}

int subsumed() {
    int dummy = 0, k, id;
    k = table_index();

    // printf("Subsumed? "); print_pc(); printf(" limit %d lock %d\n", ss.limit, ss.lock);
    // printf("Checking table[%d] = limit %d lock %d\n", k, intp_table[k].limit, intp_table[k].lock);

    if (ss.limit > intp_table[k].limit) goto FAIL;
    if (ss.lock != intp_table[k].lock) goto FAIL;
    for (int id = 0; id < N; id++) if (ss.tick - ss.savetick[id] < intp_table[k].diff[id]) goto FAIL;
    goto SUCCEED;
    FAIL: /* printf("No Subs\n"); */ nosubcount++; return -1;
    SUCCEED: /* printf("Subsumed\n"); */ subcount++; return k;
}

void mutex(int id) {
    printf("CRITICAL id %d lock %d tick %d limit %d\n", id, ss.lock, ss.tick, ss.limit);
    for (int i = 0; i < N; i++) if (i != id && ss.pc[i] == 3) {printf("EXIT!\n");  exit(0); }
    ss.limit--;
}

void print_pc() { for (int id = 0; id < N; id++) printf("%d ", ss.pc[id]); }
void print_savetick() { for (int id = 0; id < N; id++) printf("%d ", ss.savetick[id]); }
void print_intp(int k) { 
    printf("< ");
    for (int id = 0; id < N; id++) printf("%d ", intp_table[k].pc[id]); 
    printf("> : lock %d, limit %d, diff ", intp_table[k].lock, intp_table[k].limit);
    for (int id = 0; id < N; id++) printf("%d ", intp_table[k].diff[id]);  
    printf("\n");
}

int table_index() {
    int k = 0;
    for (int id = 0; id < N; id++) k += ss.pc[id] * exponents[id];
    return k;
}
        

/***
Process i: one step
    repeat
        await(lock = 0); // no blocking: this is while (lock != 0) skip;
        lock := i
        delay 
    until(lock = i);
    critical section; 
    lock := 0;


for (int k = 0, int id = N-1; id > 0; id--) {
    k += pc[id] * (10 ^ (id - (N - 1)));
}

struct pathintp { limit, lock, diff[N]; } intp_table[N][N][N];





***/
