#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 10
#define int long

#define RESOURCEBOUND N * 2
#define MAXRAND 1001
#define MAXCHOICE 11000
#define MAXINTERPOLANT 99999
#define MAX1 9001
#define MAX2 9001
#define MAX_SEARCH (long)N *(long)N *(long)MAXINTERPOLANT

//#define  DEBUG 1
#ifdef DEBUG
#define DEBUG_PRINT printf
#else
#define DEBUG_PRINT
#endif

#define min(a, b) ((a < b) ? (a) : (b))
#define dist(a, b) ((a < b) ? graph[a][b] : graph[b][a])

int decision[N + 1] = {0};
int choice[N + 1][N + 1] = {0};
int solve_count = 0;
int interpolant_table_count = 0;
int best_so_far = 99999;
int bound_gap = 99999;
int LOWER_BOUND = 240000;
int root_interpolant = 0;
int known_bound = 0;
int bHistory[100];
int bCounter = 0;

struct half_interpolant {
  int success;
  int node, slack, conflict;
} interpolant_table[MAXINTERPOLANT];

struct system_state {
  int node, resource, distance, conflict;
  int type;
} ss;

void solve();
struct half_interpolant solve1(int, int);
void init();
void print();
void print_choice(int);
void print_solution(int);
void heuristic_choice(int, int);
void update_system_state(int);
struct half_interpolant full_interpolant(int, int, struct half_interpolant[]);
void add_choice(int, int);
void remove_choice(int);
void reset_choice(int);
void update_all_interpolants();
void sort_choice(int, int *, int);
void printNDL();

// ==============================================================================
clock_t start, end;
double cpu_time_used;
int iter = 0;
int totalSub = 0;
// ==============================================================================

int graph[N + 1][N + 1] = {0};
int type[N + 1] = {0};
int resource[N + 1] = {0};

void init() {
  srand(12345);
  for (int i = 1; i <= N; i++) {
    for (int j = i + 1; j <= N; j++) {
      // if ((i + j) % 3)
      graph[i][j] = 1 + (rand() % (MAXRAND + 1));
    }
    resource[i] = 1 + (rand() % 10);
    type[i] = (rand() % (2));
  }
  ss.node = 1;
  // ss.resource = 0;
  ss.distance = 0;
  ss.type = 0;

  type[1] = 0;
  type[2] = 1;
  //	type[3] = 0;
  type[N] = 0;

  graph[1][N] = 8888;
}

void print() {

  for (int i = 1; i <= N; i++) {
    printf("Node %2d: Res = %2d: Type = %2d: edges: ", i, resource[i], type[i]);
    for (int j = 1; j <= N; j++)
      printf("%4d", graph[i][j]);
    printf("\n");
  }
  printf("====================================================================="
         "====\n");
}

void print_choice(int i) {
  DEBUG_PRINT("\tChoice for Decision %ld: ", i);
  for (int j = 1; j <= choice[i][0]; j++)
    DEBUG_PRINT("%5d", choice[i][j]);
  DEBUG_PRINT("\n");
}

void print_solution(int i) {
  int prev_node = 1, node2, distance = 0, r = 0;
  DEBUG_PRINT("\t^^^ SOLUTION 1 ");
  prev_node = 1;
  for (int k = 1; k < i; k++) {
    node2 = decision[k];
    DEBUG_PRINT("> %ld ", node2);
    distance += dist(prev_node, node2);
    r += resource[node2];
    prev_node = node2;
    if (node2 == N)
      break;
  }
  DEBUG_PRINT("(distance %ld resource %ld, type %ld) ", distance, r, ss.type);
}

// ==============================================================================

int main() {
  // to store execution time of code
  cpu_time_used = 0.0;
  init();
  print();
  start = clock();
  solve(1);
  end = clock();
  cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
  fprintf(stderr, "\n TX cpu_time_used:  %f, iter: %ld\n", cpu_time_used, iter);
  FILE *fp = fopen("robot.csv", "a");
  fprintf(fp, "C, %ld, No, %ld, %ld, %ld, %ld,%f\n", N, iter, best_so_far,
          best_so_far, solve_count, cpu_time_used);
  fclose(fp);
  // print NDL model
  printNDL();
}

void solve() {
  int bound = LOWER_BOUND;
  int k = 0, k2 = 0;
  int previous;
  struct half_interpolant h;
  for (;;) {
    if (solve_count > MAX_SEARCH) {
      fprintf(stderr, "\nppp Search Space LIMIT [%ld] Exceeded\n", solve_count);
      exit(0);
    }
    iter++;
    bound_gap = bound;
    bHistory[bCounter++] = bound;
    h = solve1(1, bound);
    k = (best_so_far - bound) / 2;
    if (h.success) {
      if (!k) {
        fprintf(stderr,
                "ppp OPTIMAL SOLUTION at %ld, total subsumption:  %ld:\n",
                best_so_far, totalSub);
        end = clock();
        cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
        fprintf(stderr, "\n TX cpu_time_used:  %f, iter: %ld\n", cpu_time_used,
                iter);

        FILE *fp = fopen("robot.csv", "a");
        fprintf(fp, "C, %ld, Yes, %ld, %ld, %ld, %ld,%f\n", N, iter,
                best_so_far, best_so_far, solve_count, cpu_time_used);
        fclose(fp);
        // print NDL model
        printNDL();
        exit(0);
      }
      end = clock();
      cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
      FILE *fp = fopen("robot.csv", "a");
      fprintf(fp, "C, %ld, Yes, %ld, %ld, %ld,%f\n", N, iter,
              bHistory[bCounter - 1], solve_count, cpu_time_used);
      fclose(fp);
      known_bound = bound;
      bound += k;
      DEBUG_PRINT("\tBEST SO FAR(succeed) = %ld (known %ld new %ld)\n",
                  best_so_far, known_bound, bound);
      previous = 1;
    } else {
      end = clock();
      cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
      FILE *fp = fopen("robot.csv", "a");
      fprintf(fp, "C, %ld, No, %ld, %ld, %ld,%f\n", N, iter,
              bHistory[bCounter - 1], solve_count, cpu_time_used);
      fclose(fp);
      bound = (best_so_far - known_bound) / 2 + known_bound;
      DEBUG_PRINT("\tBEST SO FAR(failed) = %ld (known %ld new %ld)\n",
                  best_so_far, known_bound, bound);
      previous = 0;
    }
    ss.node = 1;
    ss.resource = 0;
    ss.distance = 0;
    ss.type = 0;
    update_all_interpolants();

    DEBUG_PRINT("\n\nppp NEW PHASE previous %ld bound %ld (known %ld, bsf %ld, "
                "search space %ld) --------------------\n",
                previous, bound, known_bound, best_so_far, solve_count);
    DEBUG_PRINT("ppp ");
    print_solution(9999);
    DEBUG_PRINT("Check root intp node 1 = %ld\n", root_interpolant);
    if (root_interpolant < 0)
      bound = known_bound - root_interpolant;
    DEBUG_PRINT("READJUST bound by adding root interpolant - new bound = %ld\n",
                bound);
  }
  DEBUG_PRINT("FINAL BEST %ld bound_gap %ld bound %ld (search space %ld)\n",
              best_so_far, bound_gap, bound, solve_count);
}

struct half_interpolant solve1(int i, int bound) {
  struct half_interpolant half[MAXCHOICE], full, h;
  int gap, node, node2, prev_node, count_h = 0, distance = 0;

  DEBUG_PRINT("Solve(i:%ld, bound: %ld, incoming node: %ld)\n", i, bound,
              ss.node);
  solve_count++;
  h.success = 1;
  node = ss.node;

  // Conflict
  if ((ss.type & (int)(pow(2, type[ss.node]))) > 1) {
    h.conflict = (int)(pow(2, type[ss.node]));
    DEBUG_PRINT("\tppp ~~~~~-> Type Violation %ld \n",
                ss.type & (int)(pow(2, type[ss.node])));
    return h;
  } else {
    ss.type = ss.type | (int)(pow(2, type[i]));
  }

  // Subsumed
  for (int k = 1; k <= interpolant_table_count; k++) {
    h = interpolant_table[k];
    if (h.node != ss.node)
      continue;
    // if (h.slack <= ss.distance && h.conflict < ss.resource) {
    if (h.slack <= ss.distance && h.conflict <= ss.type) {
      if (h.conflict < ss.resource)
        DEBUG_PRINT("9999999999999999\n");
      totalSub++;
      h.success = 1;
      DEBUG_PRINT(
          "\t*** Subsumed1: current %ld dist %ld intp %ld (new gap %ld)\n",
          h.node, ss.distance, h.slack, bound_gap);
      return h;
    }
  }

  // Feasible
  if (node == N) {
    print_solution(i);
    h.node = N;
    if (bound > ss.distance) {
      h.success = 0;
      best_so_far = ss.distance;
      DEBUG_PRINT("~~~~~-> CounterEXample (bsf %ld)\n", best_so_far);
      return h;
    }
    DEBUG_PRINT("~~~~~-> Feasible (bsf %ld)\n", best_so_far);
    if (best_so_far > ss.distance)
      best_so_far = ss.distance;
    h.slack = bound;
    h.conflict = 0;
    DEBUG_PRINT(" (Distance %ld, Best_so_far %ld)\n", ss.distance, best_so_far);
    return h;
  }

  reset_choice(i);
  heuristic_choice(i, node);
  print_choice(i);

  struct system_state ss0 = ss;

  for (int j = 1; j <= choice[i][0]; j++) {
    ss = ss0;
    decision[i] = choice[i][j];
    update_system_state(i);
    DEBUG_PRINT("\tDecision[%ld] = %ld, new SS = (node:%ld: resource:%ld, "
                "distance:%ld, type:%ld)\n",
                i, decision[i], ss.node, ss.resource, ss.distance, ss.type);

    /*
     for (int k = 1; k <= interpolant_table_count; k++) {
     h = interpolant_table[k];
     if (h.node != decision[i]) continue;
     gap = ss.distance - h.slack;
     if (gap >= 0) {
     half[j] = interpolant_table[k];
     bound_gap = min(bound_gap, gap);
     printf("\t*** Subsumed2: current %ld dist %ld intp %ld (new gap %ld)\n",
     h.node, ss.distance, h.slack, bound_gap);
     // return half[j];
     break;
     } else {
     printf("\tFailed Subsumption (%ld): intp %ld known %ld bound %ld: ",
     h.node, h.slack, known_bound, bound);
     print_solution(i);
     printf("\n");
     // exit(0);
     }
     }
     */

    h = solve1(i + 1, bound);
    if (!h.success) {
      DEBUG_PRINT("XXXXXXXX\n");
      return h;
    }

    h.slack = h.slack - dist(node, decision[i]);
    // h.conflict = h.conflict - resource[i];

    half[j] = h;

    DEBUG_PRINT("\tBACK to solve %ld node %ld\n", i, node);
    DEBUG_PRINT("\tStoring HI choice %ld of dec %ld (node %ld) from son (node "
                "%ld): new slack %ld, new type %ld\n",
                j, i, node, decision[i], half[j].slack, half[j].conflict);

    count_h++;
  }

  full = full_interpolant(node, count_h, half);
  DEBUG_PRINT("\t### Full interpolant for decision %ld --> (%ld: %ld, %ld), "
              "bound %ld\n",
              i, full.node, full.slack, full.conflict, bound);
  interpolant_table[++interpolant_table_count] = full;
  if (node == 1)
    root_interpolant = full.slack;
  return full;
}

void heuristic_choice(int i, int node) {
  int k;
  for (int j = node + 1; j <= N; j++) {
    if (graph[node][j]) {
      add_choice(i, j);
    }
  }

  sort_choice(node, choice[i], choice[i][0]);
  /*
   printf("ppp BEFORE:\n ");
   for (int j = 1; j <= choice[i][0]; j++) printf("%ld ", choice[i][j]);
   printf("\n");
   sort_choice(node, choice[i], choice[i][0]);
   printf("ppp AFTER: ");
   for (int j = 1; j <= choice[i][0]; j++) printf("%ld ", choice[i][j]);
   printf("\n");
   */
}

void add_choice(int i, int j) {
  int k = choice[i][0];
  k++;
  choice[i][k] = j;
  choice[i][0] = k;
}

/*
 for (i = 0; i < n-1; i++)
 for (j = 0; j < n-i-1; j++)
 if (arr[j] > arr[j+1]) swap(&arr[j], &arr[j+1]); */

void sort_choice(int node, int *a, int k) {
  int tmp;
  // printf("ppp CHECKING SORT BEFORE: ");
  for (int j = 1; j <= k; j++)
    DEBUG_PRINT("%ld ", a[j]);
  DEBUG_PRINT("\n");
  for (int i = 1; i < k; i++) {
    for (int j = 1; j < k - i; j++) {
      if (dist(node, a[j]) > dist(node, a[j + 1])) {
        tmp = a[j];
        a[j] = a[j + 1];
        a[j + 1] = tmp;
      }
    }
  }
}

void update_system_state(int i) {
  int n, n2;
  n = decision[i];
  n2 = ss.node;
  ss.node = n;
  ss.resource += resource[n];
  ss.distance += dist(n2, n);
}

void update_half_interpolant(struct half_interpolant old,
                             struct half_interpolant new) {
  old.slack = min(old.slack, new.slack);
}

struct half_interpolant full_interpolant(int node, int count,
                                         struct half_interpolant half[]) {
  struct half_interpolant h;
  int max = 0, n, n2, distance;
  int conflict = 0;
  for (int j = 1; j <= count; j++) {
    if (j == 1 || half[j].slack > max)
      max = half[j].slack;
    conflict = conflict | half[j].conflict;
  }
  h.success = 1;
  h.node = node;
  h.slack = max;
  h.conflict = conflict;
  return h;
}

void update_all_interpolants() { interpolant_table_count = 0; }

void remove_choice(int i) { choice[i][0]--; }

void reset_choice(int i) { choice[i][0] = 0; }

void printNDL() {
  for (int k = 0; k < bCounter; k++) {
    FILE *fp;
    /* open the file for writing*/
    char filename[50];
    sprintf(filename, "robot%d.ndl", k + 1);
    fp = fopen(filename, "w");
    printf("Output NDL: %s\n", filename);
    printf("Bound for NDL:%d\n", bHistory[k]);

    // printing object and subset
    fprintf(fp, "type object = { ");
    for (int i = 1; i <= N; i++)
      fprintf(fp, "n%d, ", i);
    fprintf(fp, "dummy};\n\ntype subset = { ");
    for (int i = 1; i <= N; i++)
      fprintf(fp, "n%d, ", i);
    fprintf(fp, "dummy};\n\n");

    // printing declarations
    fprintf(fp,
            "decl at[subset] : bool;\ndecl connected[subset,subset] : real;\n"
            "decl total_type : real;\ndecl total_distance : real;\n"
            "decl get_type[subset] : real;\n\n");

    // printing initial
    fprintf(
        fp,
        "initial\ntotal_distance := 0;\ntotal_type := 0;\nat(n1) := 1;\n\n");
    for (int i = 1; i <= N; i++)
      for (int j = i + 1; j <= N; j++)
        fprintf(fp, "connected(n%d,n%d) := %d;\n", i, j, graph[i][j]);
    for (int j = 1; j <= N; j++)
      fprintf(fp, "get_type(n%d) := %d;\n", j, type[j]);

    // printing goal
    fprintf(fp, "\ngoal (total_distance <= %d & at(n%d) );\n\n",
            bHistory[k] - 1, N);

    // print actions
    fprintf(fp, "action move(f : subset, g : subset)\n"
                "(total_type < 2 & at(f) & connected(f,g) > 0)\n"
                "=>\n"
                "total_type := total_type + get_type(f);\n"
                "total_distance := total_distance + connected(f,g);\n"
                "at(f) := 0;\n"
                "at(g) := 1;\n"
                "get_type(f) := 0;\n");

    /* close the file*/
    fclose(fp);
  }
}
