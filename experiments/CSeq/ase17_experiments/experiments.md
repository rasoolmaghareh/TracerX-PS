# Experiments Reproduce #
To reproduce the results, please launch with these below command lines
(from VeriSMART directory, assuming 4 cores machine and cbmc version 5.3 is already installed in PATH).
Each of the task will use 4 CPUs at the same time to generating all the instances than verifying them in parallel.

## Elimination Stack ##
- For 8000 instances: 2 tiles of size 10, timeout 1.5hrs
    ./verismart.py benchmarks/EliminationStack/elimination-backoff-stack.c -u1 -r2 -A -p2 -l10 --parallel-generator --generators 4 --suffix .2w_10l_dwindows --chain swarm --instances-limit 8000 --shifted-window --initial-timeout 5400 -E parallel --cores 4 --soft-limit 30000

- For 8000 instances: 2 tiles of size 14, timeout 2hrs
    ./verismart.py benchmarks/EliminationStack/elimination-backoff-stack.c -u1 -r2 -A -p2 -l14 --parallel-generator --generators 4 --suffix .2w_14l_dwindows --chain swarm --instances-limit 8000 --shifted-window --initial-timeout 7200 -E parallel --cores 4 --soft-limit 30000

- For 8000 instances: 2 tiles of size 18, timeout 2hrs
    ./verismart.py benchmarks/EliminationStack/elimination-backoff-stack.c -u1 -r2 -A -p2 -l18 --parallel-generator --generators 4 --suffix .2w_18l_dwindows --chain swarm --instances-limit 8000 --shifted-window --initial-timeout 10800 -E parallel --cores 4 --soft-limit 30000

## SafeStackSC ##
- For 8000 instances: 4 tiles of size 11, timeout 1hr
    ./verismart.py benchmarks/SafeStackSC/SafeStack_seqcst_forCSEQ_static.c -u3 -r4 -A -p4 -l11 --parallel-generator --generators 4 --suffix .4w_11l_dwindows --chain swarm --instances-limit 8000 --shifted-window --initial-timeout 3600 -E parallel --cores 4 --soft-limit 30000

- For 8000 instances: 4 tiles of size 14, timeout 1hr
    ./verismart.py benchmarks/SafeStackSC/SafeStack_seqcst_forCSEQ_static.c -u3 -r4 -A -p4 -l14 --parallel-generator --generators 4 --suffix .4w_14l_dwindows --chain swarm --instances-limit 8000 --shifted-window --initial-timeout 3600 -E parallel --cores 4 --soft-limit 30000

- For 8000 instances: 4 tiles of size 20, timeout 4hrs
    ./verismart.py benchmarks/SafeStackSC/SafeStack_seqcst_forCSEQ_static.c -u3 -r4 -A -p4 -l20 --parallel-generator --generators 4 --suffix .4w_20l_dwindows --chain swarm --instances-limit 8000 --shifted-window --initial-timeout 14400 -E parallel --cores 4 --soft-limit 30000

## SafeStack WMM ##
VeriSMART provides a special translator to generate instances for these WMM benchmarks (inplacer/inplace_swarmtranslator.py), please always use the file with _template.c suffix for swarm execution.

For example, to generate 8000 instances: 3 tiles of size 12, timeout 1.5hrs, please launch the below command (other tiling options are similar to this):
    ./verismart.py benchmarks/SafeStackPSO/SafeStackPSO-3ticket-3queue_template.c -u3 -r3 -A -p3 -l12 --parallel-generator --generator 4 --suffix .3w_12l_dwindows --swarm-translator inplacer/inplace_swarmtranslator.py --instances-limit 8000 --soft-limit 30000 --shifted-window --initial-timeout 5400 -E parallel --cores 4

(here    --swarm-translator inplacer/inplace_swarmtranslator.py   option needs to be specified)
