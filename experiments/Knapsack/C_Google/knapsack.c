#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Knapsack no subsumption

// #define N 10 // seems to be the limit ...
#define N 48

//#define  DEBUG 1
#ifdef DEBUG
#define DEBUG_PRINT printf
#else
#define DEBUG_PRINT
#endif

#define MAXRAND1 65536
#define MAXRAND2 65536
#define MAXCHOICE 2
#define MAXINTERPOLANT 99999999
#define MAX_SEARCH 9999999

#define LOWER_BOUND 0

#define INFINITY 99999999

#define min(a, b) ((a < b) ? (a) : (b))
#define max(a, b) ((a > b) ? (a) : (b))

// ==============================================================================
long iter;
clock_t start, end;
double cpu_time_used;
// ==============================================================================

// int item_weight[N+1] = {0,1,2,1,3}, item_profit[N+1] = {0, 12, 21, 10, 29};
// long item_weight[N+1];
int item_weight[50] = {90,  75,  75,  70,  115, 35, 85,  55,  65,  125,
                       125, 95,  90,  105, 135, 45, 110, 95,  115, 145,
                       60,  105, 80,  75,  155, 45, 65,  110, 95,  145,
                       90,  75,  75,  70,  135, 60, 105, 80,  75,  125,
                       45,  65,  110, 95,  115, 45, 65,  110, 95,  45};

int WEIGHT_BOUND = 0;

long solve_count = 0;
long interpolant_table_count = 0;
long bound_gap = 99999;
long root_interpolant = 0;
long best_profit_so_far = 0;

struct half_interpolant {
  long safety;
  long *slack_weight;
  int slack_len;
  int node;
} interpolant_table[MAXINTERPOLANT];

typedef struct { long count, weight; } system_state;
system_state ss;

long lower_bound, upper_bound, deduced_upper_bound;

void optimize();
struct half_interpolant decide(int);
struct half_interpolant merge(struct half_interpolant, struct half_interpolant);

void init();
void update_all_interpolants();

// ==============================================================================

void init() {
  //	srand(12345);
  //	for (int i = 1; i <= N; i++) {
  //		item_weight[i] = 1 + (rand() % (MAXRAND1 + 1));
  //		item_profit[i] = 1 + (rand() % (MAXRAND2 + 1));
  //		//item_weight[i] = 10 * i;
  //		//item_profit[i] = 100 * (N - i + 1);
  //	}
  for (int i = 1; i <= N; i++) {
    printf("Item %2d: Weight = %d\n", i, item_weight[i]);
  }

  //    FILE * fp;
  //    /* open the file for writing*/
  //    fp = fopen ("data.txt","w");
  //    for (int i = 1; i <= N; i++) {
  //        fprintf(fp,"Weight %ld Profit %ld \n",
  //        item_weight[i],item_profit[i]);
  //    }
  //    /* close the file*/
  //    fclose (fp);

  for (int i = 1; i <= N; i++) {
    WEIGHT_BOUND = WEIGHT_BOUND + item_weight[i];
  }
  printf("Sum = %d\n", WEIGHT_BOUND);
  WEIGHT_BOUND = WEIGHT_BOUND / 2;
  if (WEIGHT_BOUND % 2 == 0)
    WEIGHT_BOUND = WEIGHT_BOUND + 1;
  printf("WEIGHT_BOUND = %d\n", WEIGHT_BOUND);
  printf("Size = %d\n", N);

  printf("WEIGHT BOUND: %d\n\n", WEIGHT_BOUND);
  long lower_bound = LOWER_BOUND, upper_bound = WEIGHT_BOUND,
       deduced_upper_bound = WEIGHT_BOUND;
}

// ==============================================================================

int main() {
  cpu_time_used = 0.0;
  init();
  start = clock();
  optimize();
  end = clock();
  cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
  fprintf(stderr, "\ncpu_time_used:  %f\n", cpu_time_used);
  FILE *fp = fopen("knap.csv", "a");
  fprintf(fp, "C, %d, No, %ld, %ld, %ld, %ld,%f\n", N, iter, best_profit_so_far,
          best_profit_so_far, solve_count, cpu_time_used);
  fclose(fp);
}

void optimize() {
  int k = 0;
  struct half_interpolant h;

  iter = 1;
  h = decide(1);
  printf("OPTIMAL SOLUTION at %ld (search space %ld):\n", best_profit_so_far,
         solve_count);
  end = clock();
  cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
  fprintf(stderr, "\n TX cpu_time_used:  %f, Iterations: %ld\n", cpu_time_used,
          iter);
  FILE *fp = fopen("knapsack.csv", "a");
  fprintf(fp, "C, %d ,Yes, %ld, %ld, %ld, %ld, %f\n", N, iter,
          best_profit_so_far, best_profit_so_far, solve_count, cpu_time_used);
  fclose(fp);
  printf("====================================================================="
         "===============\n");
  exit(0);

  /*for (;;) {
          if (solve_count > MAX_SEARCH) {
                  printf("\nppp Search Space LIMIT [%ld] Exceeded\n",
  solve_count);
                  FILE * fp = fopen("knap.csv", "a");
                  fprintf(fp, "C, %d, No, %ld, %ld, %ld, %ld,%f\n", N, iter,
                                  best_profit_so_far, best_profit_so_far,
  solve_count,
                                  cpu_time_used);
                  fclose(fp);
                  exit(0);
          }
          iter++;
          //

          if (h.safety) {
                  deduced_upper_bound = upper_bound - h.slack_profit;
                  lower_bound = best_profit_so_far;
                  k = (deduced_upper_bound - lower_bound) / 2;
                  if (!k) {

                  } else
                          upper_bound = ((deduced_upper_bound - lower_bound) /
  2)
                                          + lower_bound;
          } else {
                  printf(
                                  "\tBound check failed (ss profit %ld):
  previous upper bound %ld\n",
                                  ss.profit, upper_bound);
                  lower_bound = best_profit_so_far + 1;
                  upper_bound = (deduced_upper_bound - best_profit_so_far) / 2;
          }

          ss.weight = ss.profit = 0;
          update_all_interpolants();

          printf("\n\nppp NEW PHASE: %ld %ld (dup %ld bsf %ld)\n", lower_bound,
                          upper_bound, deduced_upper_bound, best_profit_so_far);
          printf("Check root intp node 1 = %ld\n", root_interpolant);
  }
  printf("FINAL %ld %ld (search space %ld)\n", lower_bound, upper_bound,
                  solve_count);*/
}

struct half_interpolant decide(int level) {
  struct half_interpolant half[MAXCHOICE], full, h;
  DEBUG_PRINT("Solve(%d, current weight %ld)\n", level, ss.weight);
  solve_count++;
  h.safety = 1;
  h.slack_weight = (long *)malloc(WEIGHT_BOUND * sizeof(long));
  h.slack_len = 0;

  // Infeasible
  if (level == N + 1 && ss.weight != WEIGHT_BOUND) {
    h.slack_weight[0] = WEIGHT_BOUND;
    h.node = level;
    h.slack_len++;
    DEBUG_PRINT(
        "\t~~~~~-> Infeaible  path weight: %ld, slack: %ld, slack_len: %d\n",
        ss.weight, h.slack_weight[0], h.slack_len);
    return h;
  }
  // Subsumed
  for (int k = 1; k <= interpolant_table_count; k++) {
    if (interpolant_table[k].node == level) {

      for (int s = 1; s <= interpolant_table[k].slack_len; s++)
        DEBUG_PRINT("weight  %ld, ", interpolant_table[k].slack_weight[s]);
      DEBUG_PRINT("; \n ");

      int flag = 0;
      for (int s = 1; s <= interpolant_table[k].slack_len; s++) {
        if (ss.weight == interpolant_table[k].slack_weight[s]) {
          flag = 1;
        }
      }
      if (flag == 0) {
        h.slack_weight = (long *)malloc(WEIGHT_BOUND * sizeof(long));
        h.slack_len = interpolant_table[k].slack_len;
        h.safety = interpolant_table[k].safety;
        for (int s = 0; s < h.slack_len; s++)
          h.slack_weight[s] = interpolant_table[k].slack_weight[s];
        DEBUG_PRINT("\t*** Subsumed1: level %d weight  %ld, int:", level,
                    ss.weight);
        for (int s = 1; s <= h.slack_len; s++)
          DEBUG_PRINT("weight  %ld, ", h.slack_weight[s]);
        DEBUG_PRINT("; \n ");
        return h;
      }
    }
  }

  // Feasible (terminal)
  if (level == N + 1 && ss.weight == WEIGHT_BOUND) {
    // Feasible, but Counterexample
    h.safety = 0;
    DEBUG_PRINT("~~~~~-> CounterEXample (bsf %ld)\n", best_profit_so_far);
    return h;
  }

  // Feasible (continue)
  system_state ss0 = ss;
  for (int j = 1; j >= 0; j--) {
    ss = ss0;
    if (j) {
      ss.weight += item_weight[level];
    }
    DEBUG_PRINT("\tDecision[%d] = %d, new weight %ld \n", level, j, ss.weight);

    h = decide(level + 1);

    if (!h.safety) {
      DEBUG_PRINT("XXXXXXXX level %d \n", level);
      return h;
    }

    int count = 0;
    for (int s = 0; s < h.slack_len; s++) {
      if (j)
        if (h.slack_weight[s] - item_weight[level] > 0)
          h.slack_weight[count++] = h.slack_weight[s] - item_weight[level];
        else
          h.slack_weight[count++] = 0;
      else
        h.slack_weight[count++] = h.slack_weight[s];
    }
    h.slack_len = count;
    half[j].node = level;
    half[j].slack_weight = (long *)malloc(WEIGHT_BOUND * sizeof(long));
    half[j].safety = h.safety;
    for (int s = 0; s < h.slack_len; s++)
      half[j].slack_weight[s] = h.slack_weight[s];
    half[j].slack_len = h.slack_len;

    DEBUG_PRINT("\tStoring HI choice %d of level %d: slack_len  %d, half int: ",
                j, level, half[j].slack_len);
    for (int s = 0; s < half[j].slack_len; s++)
      DEBUG_PRINT(" %ld, ", half[j].slack_weight[s]);
    DEBUG_PRINT(" \n ");
  }

  // Combine halfs to full
  full = merge(half[0], half[1]);
  DEBUG_PRINT("\t### Full interpolant for decision %d --> (slack_len:%d)",
              level, full.slack_len);
  for (int s = 0; s < full.slack_len; s++)
    DEBUG_PRINT(" %ld, ", full.slack_weight[s]);
  DEBUG_PRINT(" \n ");

  interpolant_table[++interpolant_table_count] = full;
  interpolant_table[interpolant_table_count].slack_weight =
      (long *)malloc(WEIGHT_BOUND * sizeof(long));
  for (int s = 0; s < interpolant_table[interpolant_table_count].slack_len; s++)
    interpolant_table[interpolant_table_count].slack_weight[s] =
        full.slack_weight[s];

  return full;
}

void update_all_interpolants() { interpolant_table_count = 0; }

struct half_interpolant merge(struct half_interpolant a,
                              struct half_interpolant b) {
  struct half_interpolant full;
  full.safety = 1;
  full.node = a.node;

  full.slack_weight = (long *)malloc(WEIGHT_BOUND * sizeof(long));

  int count = 0;
  for (int i = 0; i < a.slack_len; i++) {
    int flag = 0;
    for (int j = 0; j < count; j++) {
      if (a.slack_weight[i] == full.slack_weight[j])
        flag = 1;
    }
    if (flag == 0)
      full.slack_weight[count++] = a.slack_weight[i];
  }

  for (int i = 0; i < b.slack_len; i++) {
    int flag = 0;
    for (int j = 0; j < count; j++) {
      if (b.slack_weight[i] == full.slack_weight[j])
        flag = 1;
    }
    if (flag == 0)
      full.slack_weight[count++] = b.slack_weight[i];
  }
  full.slack_len = count;
  return full;
}
