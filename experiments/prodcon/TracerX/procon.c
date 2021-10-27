#include <klee/klee.h>
#include <stdio.h>

#define N 24
#define B 12
int search(int level, int p , int b);
void check_buffer(int b);

main() { search(0, N, 0); }

int search(int level, int p , int b) { 
    printf("Search(%d)\n", level);
    if (p == 0 && b == 0) { return 0; }  
    int choice; 
    choice = klee_range(0, 2, "id");
    switch (choice) {
        case 0: if (b < B && p > 0) { p--; b++; search(level+1, p,b);} break; 
        case 1: if (b > 0) { b--; search(level+1, p,b); }break; 
    }
    check_buffer(b);
    printf("Return level %d\n", level);
    return 0;
}

void check_buffer(int b) {
    klee_assert(b >= 0 && b <= B);
}

