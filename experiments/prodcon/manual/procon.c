#include <klee/klee.h>
#include <stdio.h>

#define N 14
#define B 7

int pc[N] = {0}, lock = -1, tick = 0, savetick[N] = {0};

int search(int level, int p , int b);
void check_buffer(int b);

main() { search(0, N, 0); }

int search(int level, int p , int b) { 
    printf("Search(%d): tick = %d\n", level, tick);
    if (p == 0 && b == 0) { return 0; }  
    int choice; // = nondet_int();
    __CPROVER_assume(choice >= 0 && choice <= 1);
    //klee_range(0, 1, "id");
    switch (choice) {
        case 0: if (b < B && p > 0) { p--; b++; search(level+1, p,b);} break; 
        case 1: if (b > 0) { b--; search(level+1, p,b); }break; 
    }
    check_buffer(b);
    printf("Return level %d\n", level);
    return 0;
}

void check_buffer(int b) {
    __CPROVER_assume(b >= 0 && b <= B);
}
