#include <stdio.h>

#define INF 999999
#define N 3
#define BOUND 

#define PP 3
#define MAXDB 9999999
#define LIMIT (N)
#define MAXBREAD (N * PP * LIMIT)


int pc[N], ticket[N], bread[MAXBREAD], limit, n_bread; 

int limit = LIMIT;
int n_bread = 0;

int search (int);
void mutex(int id);
int minticket(int id);
int maxticket();

main() { search(0); }

int search(int level) { 
            
    if (limit == 0) {
       printf("Bread: ");
       for (int b = 0; b < MAXBREAD && bread[b] != -1; b++) printf("%d ", bread[b]);
       printf("\n");
       return 0;
    }
    int id; // = nondet_int();
    //__CPROVER_assume(id >= 0 && id <= N);
    id = klee_range(0, N, "id");

    switch (pc[id]) {
        case 0: ticket[id] = maxticket() + 1; pc[id] = 1; search(level + 1); break;
        case 1: if (minticket(id)) { mutex(id); pc[id] = 2; search(level + 1); } break;
        case 2: ticket[id] = 0; pc[id] = 0; search(level + 1);
    }
    printf("Return level %d\n", level);
    return 0;
}


void mutex(int id) {
     printf("MUTEX "); print_pc(); printf("\n");
     for (int i = 0; i < N; i++) if (i != id && pc[i] == 2) { printf("ERROR!\n"); exit(0); }
     limit--;
     bread[n_bread++] = id;
}

int minticket(int id) {
    for (int i = 0; i < N; i++) if (ticket[id] > ticket[i]) return 0;
    return 1;
}

int maxticket() {
    int max = -1;
    for (int id = 0; id < N; id++) if (ticket[id] > max) max = ticket[id];
    return max;
}
