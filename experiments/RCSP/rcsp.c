#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAXRAND 1001
#define MAXCHOICE 1001
#define MAXINTERPOLANT 9999999
#define MAXSEARCHLIMIT (long)N *(long)N *(long)MAXINTERPOLANT

#define N 50
#define RESOURCEBOUND N * 2
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
  int node, slack, slackr;
} interpolant_table[MAXINTERPOLANT];

struct system_state {
  int node, resource, distance;
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
int resource[N + 1] = {0};

void init() {
  srand(12345);
  for (int i = 1; i <= N; i++) {
    for (int j = i + 1; j <= N; j++)
      // if ((i + j) % 3)
      graph[i][j] = 1 + (rand() % (MAXRAND + 1));
    resource[i] = 1 + (rand() % 10);
  }
  ss.node = 1;
  ss.resource = 0;
  ss.distance = 0;

  graph[1][N] = 8888;
}

void print() {

  /*for (int i = 1; i <= N; i++) {
      printf("Node %2d: Res = %2d: edges: ", i, resource[i]);
      for (int j = 1; j <= N; j++) printf("%5d", graph[i][j]);
      printf("\n");
  }
  printf("=========================================================================\n");*/
}

void print_choice(int i) {
  /*printf("\tChoice for Decision %d: ", i);
  for (int j = 1; j <= choice[i][0]; j++) printf("%5d", choice[i][j]);
  printf("\n");*/
}

void print_solution(int i) {
  /*	int prev_node = 1, node2, distance = 0;
                  printf("SOLUTION 1 ");
                  prev_node = 1;
          for (int k = 1; k < i; k++) {
                          node2 = decision[k];
                          printf("> %d ", node2);
                          distance += dist(prev_node, node2);
                          prev_node = node2;
                          if (node2 == N) break;
                  }
                  printf("(distance %d) \n", distance);*/
  //	printf("\tSolution: 1 ");
  //	for (int j = 1; j <= i; j++) printf("%4d ", decision[j]);
  //	printf("\n");
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
  fprintf(stderr, "\ncpu_time_used:  %f\n", cpu_time_used);
  FILE *fp = fopen("rcsp.csv", "a");
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
    if (solve_count > MAXSEARCHLIMIT) {
      fprintf(stderr, "\nSearch Space LIMIT [%d] Exceeded\n", solve_count);
      exit(0);
    }
    iter++;

    bound_gap = bound;
    bHistory[bCounter++] = bound;
    h = solve1(1, bound);
    k = (best_so_far - bound) / 2;
    if (h.success) {
      if (!k) {
        printf("OPTIMAL SOLUTION at %d:\n", best_so_far);
        end = clock();
        cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
        fprintf(stderr, "\n TX cpu_time_used:  %f\n", cpu_time_used);
        FILE *fp = fopen("rcsp.csv", "a");
        fprintf(fp, "C, %ld, Yes, %ld, %ld, %ld,%f\n", N, iter,
                bHistory[bCounter - 1], solve_count, cpu_time_used);
        fclose(fp);
        // print NDL model
        printNDL();
        exit(0);
      }
      end = clock();
      cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
      FILE *fp = fopen("rcsp.csv", "a");
      fprintf(fp, "C, %ld, Yes, %ld, %ld, %ld,%f\n", N, iter,
              bHistory[bCounter - 1], solve_count, cpu_time_used);
      fclose(fp);
      known_bound = bound;
      bound += k;
      // printf("\tBEST SO FAR(succeed) = %d (known %d new %d)\n",
      //	   best_so_far, known_bound, bound);
      previous = 1;
    } else {
      // printf("\tBEST SO FAR(failed) = %d (known %d new %d)\n",
      //	   best_so_far, known_bound, bound);
      previous = 0;
      end = clock();
      cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
      FILE *fp = fopen("rcsp.csv", "a");
      fprintf(fp, "C, %ld, No, %ld, %ld, %ld,%f\n", N, iter,
              bHistory[bCounter - 1], solve_count, cpu_time_used);
      fclose(fp);
      bound = (best_so_far - known_bound) / 2 + known_bound;
    }
    ss.node = 1;
    ss.resource = 0;
    ss.distance = 0;
    update_all_interpolants();

    printf("ppp NEW PHASE previous %d bound %d (known %d, bsf %d, search space "
           "%d) --------------------\n",
           previous, bound, known_bound, best_so_far, solve_count);
    // printf("ppp "); print_solution(9999);
    // printf("Check root intp node 1 = %d\n", root_interpolant);
    if (root_interpolant < 0)
      bound = known_bound - root_interpolant;
    // printf("READJUST bound by adding root interpolant - new bound = %d\n",
    // bound);
  }
  // printf("FINAL BEST %d bound_gap %d bound %d (search space %d)\n",
  // best_so_far, bound_gap, bound, solve_count);
}

struct half_interpolant solve1(int i, int bound) {
  struct half_interpolant half[MAXCHOICE], full, h;
  int gap, node, node2, prev_node, count_h = 0, distance = 0;

  // printf("Solve(%d, bound %d, incoming node %d)\n", i, bound, ss.node);
  solve_count++;
  h.success = 1;
  node = ss.node;

  // infeasible
  if (ss.resource > RESOURCEBOUND) {
    h.slackr = RESOURCEBOUND;
    h.slack = 0;
    printf("\tppp ~~~~~-> Resource Violation %ld \n", ss.resource);
    return h;
  }

  for (int k = 1; k <= interpolant_table_count; k++) {
    h = interpolant_table[k];
    if (h.node != ss.node)
      continue;
    if (h.slack <= ss.distance) {
      h.success = 1;
      // printf("\t*** Subsumed1: current %d dist %d intp %d (new gap %d)\n",
      // h.node, ss.distance, h.slack, bound_gap);
      return h;
    }
  }

  if (node == N) {
    print_solution(i);
    h.node = N;
    if (bound > ss.distance) {
      h.success = 0;
      best_so_far = ss.distance;
      // printf("~~~~~-> CounterEXample (bsf %d)\n", best_so_far);
      return h;
    }
    // printf("~~~~~-> Feasible (bsf %d)\n", best_so_far);
    if (best_so_far > ss.distance)
      best_so_far = ss.distance;
    h.slack = bound;
    // printf(" (Distance %d, Best_so_far %d)\n", ss.distance, best_so_far);
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
    // printf("\tDecision[%d] = %d, new SS = (%d: %d, %d)\n", i, decision[i],
    // ss.node, ss.resource, ss.distance);

    for (int k = 1; k <= interpolant_table_count; k++) {
      h = interpolant_table[k];
      if (h.node != decision[i])
        continue;
      gap = ss.distance - h.slack;
      if (gap >= 0) {
        half[j] = interpolant_table[k];
        bound_gap = min(bound_gap, gap);
        totalSub++;
        // printf("\t*** Subsumed2: current %d dist %d intp %d (new gap %d)\n",
        // h.node, ss.distance, h.slack, bound_gap);
        // return half[j];
        break;
      } else {
        // printf("\tFailed Subsumption (%d): intp %d known %d bound %d: ",
        // h.node, h.slack, known_bound, bound);
        print_solution(i);
        printf("\n");
        // exit(0);
      }
    }

    h = solve1(i + 1, bound);
    if (!h.success)
      return h;

    h.slack = h.slack - dist(node, decision[i]);
    h.slackr = h.slackr - resource[decision[i]];
    half[j] = h;

    // printf("\tBACK to solve %d node %d\n", i, node);
    // printf("\tStoring HI choice %d of dec %d (node %d) from son (node %d):
    // new slack %d\n",
    //	   j, i, node, decision[i], half[j].slack);

    count_h++;
  }

  full = full_interpolant(node, count_h, half);
  // printf("\t### Full interpolant for decision %d --> (%d: %d), bound %d\n",
  // i, full.node, full.slack, bound);
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
          for (int j = 1; j <= choice[i][0]; j++) printf("%d ", choice[i][j]);
          printf("\n");
          sort_choice(node, choice[i], choice[i][0]);
          printf("ppp AFTER: ");
          for (int j = 1; j <= choice[i][0]; j++) printf("%d ", choice[i][j]);
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
  // for (int j = 1; j <= k; j++) printf("%d ", a[j]);
  // printf("\n");
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
  for (int j = 1; j <= count; j++) {
    if (j == 1 || half[j].slack > max)
      max = half[j].slack;
  }
  h.success = 1;
  h.node = node;
  h.slack = max;
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
    sprintf(filename, "rcsp%d.ndl", k + 1);
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
            "decl total_resource : real;\ndecl total_distance : real;\n"
            "decl get_resource[subset] : real;\n\n");

    // printing initial
    fprintf(fp, "initial\ntotal_distance := 0;\ntotal_resource := 0;\nat(n1) "
                ":= 1;\n\n");
    for (int i = 1; i <= N; i++)
      for (int j = i + 1; j <= N; j++)
        fprintf(fp, "connected(n%d,n%d) := %d;\n", i, j, graph[i][j]);
    for (int j = 1; j <= N; j++)
      fprintf(fp, "get_resource(n%d) := %d;\n", j, resource[j]);

    // printing goal
    fprintf(
        fp,
        "\ngoal (total_resource < %d & total_distance <= %d & at(n%d) );\n\n",
        RESOURCEBOUND, bHistory[k] - 1, N);

    // print actions
    fprintf(fp, "action move(f : subset, g : subset)\n"
                "(get_resource(f) != 0 & at(f) & connected(f,g) > 0)\n"
                "=>\n"
                "total_resource := total_resource + get_resource(f);\n"
                "total_distance := total_distance + connected(f,g);\n"
                "at(f) := 0;\n"
                "at(g) := 1;\n"
                "get_resource(f) := 0;\n");

    /* close the file*/
    fclose(fp);
  }
}
