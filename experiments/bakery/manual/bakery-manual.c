#include<stdio.h>
#include <stdlib.h>

#define loop for(;;)
#define INF 999999
#define N 40
#define LIMIT 1

#define PP 3
#define MAXDB 99999999
#define MAXTABLE (999 * N)
#define MAXBREAD (N)
int searchspace = 1, intpcount = 0, subscount = 0;
int count1 = 0, count2 = 0;

struct systemstate { int pc[N], ticket[N], bread[MAXBREAD], limit, n_bread; } ss;
struct pathintp {int pc[N]; struct ticket_order *to_ptr; int limit; } intp_table[MAXTABLE];
struct ticket_order {int to[N+1]; struct ticket_order *next; };

int limit = LIMIT;
int interpolants_ticket[MAXDB][N] = {-1};
int interpolants_pc[MAXDB][N] = {-1};
int interpolants_limit[MAXDB] = {-1};
// int bread[MAXBREAD] = {-1};
int n_bread = 0;
int exponents[N];
int n_intp;

void init();
void search ();
void mutex(int id);
int minticket(int id);
int maxticket();
void get_ticket_order(int []);
void store_interpolant();
int subsumed();
int check_ticket_order(int [], int []);
void print_ticket_order(int []);

void print_pc();
void print_tickets();
void print_intp(int);
int table_index();
int perm_pc(int a[], int b[]);
int perm_ticket(int a[], int b[]);
int symm();

int main() { init(); search(); 
       printf("FINAL: searchspace %d intp table %d subscount %d\n: ", searchspace, intpcount, subscount);
}

void init() { 
    for (int id = 0; id < N; id++) { ss.pc[id] = 0; ss.ticket[id] = 0; }
    for (int b = 0; b < MAXBREAD; b++) ss.bread[b] = -1;
    ss.limit = LIMIT; 
    ss.n_bread = 0;
    exponents[N - 1] = 1;
    for (int id = N - 2; id >= 0; id--) exponents[id] = PP * exponents[id + 1];
    for (int k = 0; k < MAXTABLE; k++) intp_table[k].to_ptr = NULL;
}

void search (int level) {
    // for (int i = 0; i < level; i++) printf("  ");
    // printf("[%d, %d] ", level, searchspace); print_pc(); print_tickets(); printf("\n");
    int k;
    struct systemstate ss0;
    
    if (ss.limit == 0) {
       // printf("Bread: ");
       // for (int b = 0; b < MAXBREAD && ss.bread[b] != -1; b++) printf("%d ", ss.bread[b]);
       // printf("\n");
       return;
    }
    // if (searchspace > 199) exit(0);
    k = subsumed();
    if (k) { /* printf("SUBSUMED by Table[%d] ", k);  print_pc(); print_tickets(); printf("\n"); */ subscount++; return; }
    // if (symm()) { printf("SYMM "); print_pc(); return; }

    if (searchspace % 100000 == 0) printf("%d\n", searchspace);
    searchspace++;   
    ss0 = ss;
    for (int id = 0; id < N; id++) {
        switch (ss.pc[id]) {
            case 0: ss.ticket[id] = maxticket() + 1; ss.pc[id] = 1; search(level + 1); break;
            case 1: if (/* ss.ticket[id] == 3 || */ minticket(id)) { mutex(id); ss.pc[id] = 2; search(level + 1); } break;
            case 2: ss.ticket[id] = 0; ss.pc[id] = 0; search(level + 1);
        }
        NEXT_ID: 
            ss = ss0;
    }
    store_interpolant();
}      

void mutex(int id) {
     // printf("MUTEX "); print_pc(); printf("\n");
     for (int i = 0; i < N; i++) if (i != id && ss.pc[i] == 2) { printf("ERROR!\n"); exit(0); }
     ss.limit--;
     ss.bread[ss.n_bread++] = id;
}

int minticket(int id) {
    for (int i = 0; i < N; i++) if (ss.ticket[i] != 0 && ss.ticket[id] > ss.ticket[i]) return 0;
    return 1;
}

int maxticket() {
    int max = -1;
    for (int id = 0; id < N; id++) if (ss.ticket[id] > max) max = ss.ticket[id];
    return max;
}

//-----------------------------------------------------------------

void get_ticket_order(int to[]) {
    int tmp[N], ticket_order[N + 1], count = 0, min;
    for (int id = 0; id < N; id++) tmp[id] = ss.ticket[id];
    for (int i = 0; i < N; i++) {
        min = -1;
        for (int j = 0; j < N; j++) if (tmp[j] > 0) { if ((min == -1) || (tmp[j] < tmp[min])) min = j; }
        if (min == -1) break;
        if (tmp[min] > 0) to[count++] = min;
        tmp[min] = 0;
    }
    to[count] = -1;
    // printf("Check order: "); for (int i = 0; to[i] != -1; i++) printf("%d:", to[i]); printf("\n");
}

void store_interpolant() {
    int i, k, tmp_to[N + 1], n_ticket_order = 0, min = 0;
    struct ticket_order *new_to_ptr;
    count1 = 0;

    k = table_index();
    // printf("Storing Intp %d ", k);  /* print_pc(); print_tickets(); printf("\n"); */
    new_to_ptr = intp_table[k].to_ptr;
    if (new_to_ptr == NULL) {
        // printf("New intp: ");
        for (int id = 0; id < N; id++) intp_table[k].pc[id] = ss.pc[id];
    }
    get_ticket_order(tmp_to);
    while (new_to_ptr) {
        if (check_ticket_order(new_to_ptr->to, tmp_to)) { /* printf("(Duplicate)\n"); */ return; }
         // if (count1++ > N) return;
        new_to_ptr = new_to_ptr->next;
    } 
    intpcount++;
    // printf("Storing Intp %d ", k);  /* print_pc(); print_tickets(); printf("\n"); */
    new_to_ptr = malloc(sizeof(struct ticket_order));
    for (i = 0; tmp_to[i] != -1; i++) new_to_ptr->to[i] = tmp_to[i];
    new_to_ptr->to[i] = -1;
    new_to_ptr->next = intp_table[k].to_ptr;
    intp_table[k].to_ptr = new_to_ptr;
    intp_table[k].limit = ss.limit;
    // print_intp(k);
    // printf("\n");
}

int subsumed() {
    int k, to[N + 1], found = 1;
    struct ticket_order *intp_to_ptr;

    count2 = 0;
    // printf("Checking subs: "); print_pc(); print_tickets();
    k = table_index();
    // printf("Looking at intp_table[%d]\n", k);
    intp_to_ptr = intp_table[k].to_ptr;
    if (intp_to_ptr == NULL) { /* printf("No subs (NULL)\n"); */ return 0; }
    get_ticket_order(to);
    do {
        found = 1;
        for (int i = 0; i < N; i++) {
            if (intp_table[k].to_ptr->to[i] != to[i]) { /* printf("No subs (order)\n"); */ found = 0; break; }
        }
        if (found) goto CHECK_LIMIT;
        count2++;
        // if (count2 > N) return 0;
        intp_to_ptr = intp_to_ptr->next;
    } while (intp_to_ptr);
    // printf("Failed all ticket orders\n"); 
    return 0;
    CHECK_LIMIT: 
    if (intp_table[k].limit < ss.limit) { /* printf("No subs (limit)\n"); */ return 0; }
    return 1;
}

int check_ticket_order(int to1[], int to2[]) {
    // printf("Check TO: "); print_ticket_order(to1); print_ticket_order(to2); 
    for (int i = 0; i < N + 1; i++) {
        if (to1[i] == -1 && to2[i] == -1) break;
        if (to1[i] != to2[i]) return 0;
    }
    return 1;
}

void print_ticket_order(int to[]) {
    printf("[");
    for (int i = 0; i < N + 1; i++) { if (to[i] == -1) break; printf("%d ", to[i]); }
    printf("]");
}

void print_pc() {
    printf("pc: <");
    for (int id = 0; id < N; id++) printf("%d ", ss.pc[id]);
    printf("> ");
}

void print_limit() {
    printf("limit: ");
//    for (int id = 0; id < N; id++) printf("%d ", ss.limit[id]);
    printf("%d ", ss.limit);
//    printf("\n");
}

void print_tickets() {
    printf("tickets: [");
    for (int id = 0; id < N; id++) printf("%d ", ss.ticket[id]);
    printf("] ");
//  printf("\n");
}

void print_intp(int k) {
    struct ticket_order *tmp_to_ptr;
    printf("Table [%d]: ", k); 
    printf("<"); for (int id = 0; id < N; id++) printf("%d ", intp_table[k].pc[id]); printf("> ");
    tmp_to_ptr = intp_table[k].to_ptr;
    while (tmp_to_ptr != NULL) {
        printf("["); 
        for (int i = 0; i < N+1; i++) {
            if (tmp_to_ptr->to[i] == -1) break; 
            printf("%d; ", tmp_to_ptr->to[i]); 
        }
        printf("] ");
        tmp_to_ptr = tmp_to_ptr->next;
    }
    printf("limit %d", intp_table[k].limit);
}

int table_index() {
    int k = 0;
    for (int id = 0; id < N; id++) k += ss.pc[id] * exponents[id];
    return k;
}
        
// int symm(); // pc1 and pc2 permuted by perm[], ticket order also permuted by perm[]

int perm[N];

int perm_pc(int a[], int b[]) {
    int tmp[N], count = 0;

/*
printf("Perm PC: \n");
for (int i = 0; i < N; i++) printf(" %d ", a[i]); 
printf("\n");
for (int i = 0; i < N; i++) printf(" %d ", b[i]);
printf("\n");
*/
    for (int i = 0; i < N; i++) tmp[i] = b[i];
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            if (a[i] == tmp[j]) { count++; perm[i] = j; tmp[j] = -1; break; }
/*
for (int i = 0; i < N; i++) printf(" %d ", perm[i]);
printf("\nCOUNT %d\n", count);
*/
   return (count == N);
}

int perm_ticket(int a[], int b[]) {
    int tmp[N], min;
    for (int i = 0; i < N; i++) tmp[i] = b[i];

    for (int i = 0; a[i] != -1; i++) {
        min = perm[a[i]];
        for (int k = 0; k < N; k++) if (tmp[min] > tmp[k]) return 0;
        tmp[min] = INF;
     }
     for (int i = 0; i < N; i++) if (tmp[i] != INF) return 0;
     return 1;
}

int symm() {
    int tmp[N];
    for (int i = 0; i < N; i++) tmp[i] = ss.pc[i];
    for (int i = 0; i < n_intp; i++) {
        if (!perm_pc(interpolants_pc[i], tmp)) continue;
        if (!perm_ticket(interpolants_ticket[i], ss.ticket)) continue;
        return 1;
    }
    return 0;
}

/*

N = 8, LIMIT = 3N -> 
FINAL: searchspace 2891597 intp table 149921
real	10m5.094s
user	10m1.285s
sys	0m1.657s

N = 9, LIMIT = 3N -> 
FINAL: searchspace 29290942 intp table 4496 count1 0 count2 10
: 
real	0m29.734s
user	0m28.964s
sys	0m0.385s

*/
