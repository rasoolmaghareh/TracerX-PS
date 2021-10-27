#include <klee/klee.h>
#include <stdio.h>

#define LIMIT 3
#define TRAIN 0
#define GATE 1
#define CONTROLLER 2

#define FAR 10
#define NEAR 11
#define PAST 12
#define UP 13
#define COMING_DOWN 14
#define DOWN 15
#define GOING_UP 16

int limit = LIMIT;
int clock_t = 0, clock_g = 0, clock_c = 0;
int pc_TRAIN = FAR,pc_GATE = UP,pc_CONTROLLER = 0;
int RAISE,APPROACH,LOWER,RAISE,EXIT;

int search(int level);
void print_state(int id);

main() { search(0); }

int main() {
    int level = 0;
    
    while (limit > 0)
    {
        tick();
        int id = klee_range(TRAIN, CONTROLLER+1, "id");
        switch (id) {
            case TRAIN: train(); search(level + 1); break;
            case GATE: gate(); search(level + 1); break;
            case CONTROLLER: controller(); search(level + 1);
        }
        klee_assert(!(pc_TRAIN == PAST && pc_GATE == UP));
    }
    return 1;
}

tick() { clock_g++; clock_t++; clock_c++; }
reset_g() { clock_g = 0; }
reset_t() { clock_t = 0; }
reset_c() { clock_c = 0; }

train() {
    //printf("Moving to train\n");
    switch (pc_TRAIN) {
        case FAR: APPROACH = 1; reset_t(); pc_TRAIN = NEAR; break;
        case NEAR: if (clock_t <= 5 && clock_t > 2) { pc_TRAIN = PAST;}else {exit(0);}  break;
        case PAST: if (clock_t <= 5) {EXIT = 1; limit--; pc_TRAIN = FAR;}else {exit(0);}  break;
    }
}
         
gate() {
    //printf("Moving to gate\n");
    switch (pc_GATE) {
        case UP: if (LOWER) { LOWER = 0; reset_g(); pc_GATE = COMING_DOWN; } else {exit(0);} break;
        case COMING_DOWN: if (clock_g <= 1) {pc_GATE = DOWN;}else {exit(0);}  break;
        case DOWN: if (RAISE) { RAISE = 0; reset_g(); pc_GATE = GOING_UP; }else {exit(0);}  break;
        case GOING_UP: if (clock_g <= 2 && clock_g >=1) {pc_GATE = UP ;}else {exit(0);}  break;
    }
}

controller() {
    //printf("Moving to controller\n");
    switch (pc_CONTROLLER) {
        case 0: if (APPROACH) { APPROACH = 0; reset_c(); pc_CONTROLLER = 1; }else {exit(0);}  break;
        case 1: if (clock_c <= 1 && clock_c == 1) { LOWER = 1; pc_CONTROLLER = 2; }else {exit(0);}  break;
        case 2: if (EXIT) { EXIT = 0; reset_c(); pc_CONTROLLER = 3; }else {exit(0);}  break;
        case 3: if (clock_c <= 1) { RAISE = 1; pc_CONTROLLER = 0; }else {exit(0);}  break;
    }
}


void print_state(int id)
{
    printf("State:");
    if (id == TRAIN) printf("Id:Train;\n");
    else if (id == GATE) printf("Id:Gate;\n");
    else if (id == CONTROLLER) printf("Id:Controller;\n");


}
