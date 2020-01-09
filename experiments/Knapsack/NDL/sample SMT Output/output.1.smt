(set-logic QF_LRA)
(declare-fun BX00000_pick_n0_0 () Bool)
(declare-fun BX00000_pick_n0_1 () Bool)
(declare-fun BX00000_pick_n0_2 () Bool)
(declare-fun BX00000_pick_n0_3 () Bool)
(declare-fun BX00000_pick_n0_4 () Bool)
(declare-fun BX00000_pick_n0_5 () Bool)
(declare-fun BX00001_pick_n2_0 () Bool)
(declare-fun BX00001_pick_n2_1 () Bool)
(declare-fun BX00001_pick_n2_2 () Bool)
(declare-fun BX00001_pick_n2_3 () Bool)
(declare-fun BX00001_pick_n2_4 () Bool)
(declare-fun BX00001_pick_n2_5 () Bool)
(declare-fun BX00002_pick_n1_0 () Bool)
(declare-fun BX00002_pick_n1_1 () Bool)
(declare-fun BX00002_pick_n1_2 () Bool)
(declare-fun BX00002_pick_n1_3 () Bool)
(declare-fun BX00002_pick_n1_4 () Bool)
(declare-fun BX00002_pick_n1_5 () Bool)
(declare-fun Rtotal_value_0 () Real)
(declare-fun Rtotal_value_1 () Real)
(declare-fun Rtotal_value_2 () Real)
(declare-fun Rtotal_value_3 () Real)
(declare-fun Rtotal_value_4 () Real)
(declare-fun Rtotal_value_5 () Real)
(declare-fun Rvalue-n0_0 () Real)
(declare-fun Rvalue-n0_1 () Real)
(declare-fun Rvalue-n0_2 () Real)
(declare-fun Rvalue-n0_3 () Real)
(declare-fun Rvalue-n0_4 () Real)
(declare-fun Rvalue-n0_5 () Real)
(declare-fun Rvalue-n1_0 () Real)
(declare-fun Rvalue-n1_1 () Real)
(declare-fun Rvalue-n1_2 () Real)
(declare-fun Rvalue-n1_3 () Real)
(declare-fun Rvalue-n1_4 () Real)
(declare-fun Rvalue-n1_5 () Real)
(declare-fun Rvalue-n2_0 () Real)
(declare-fun Rvalue-n2_1 () Real)
(declare-fun Rvalue-n2_2 () Real)
(declare-fun Rvalue-n2_3 () Real)
(declare-fun Rvalue-n2_4 () Real)
(declare-fun Rvalue-n2_5 () Real)
  ;; GOAL
(assert (= Rtotal_value_5 15))
  ;; INITIAL STATE
(assert (= Rtotal_value_0 0))
(assert (= Rvalue-n0_0 5))
(assert (= Rvalue-n1_0 5))
(assert (= Rvalue-n2_0 5))
  ;; EFFECTS
(assert (or (not BX00002_pick_n1_0) (= Rvalue-n1_1 0)))
(assert (or (not BX00002_pick_n1_1) (= Rvalue-n1_2 0)))
(assert (or (not BX00002_pick_n1_2) (= Rvalue-n1_3 0)))
(assert (or (not BX00002_pick_n1_3) (= Rvalue-n1_4 0)))
(assert (or (not BX00002_pick_n1_4) (= Rvalue-n1_5 0)))
(assert (or (not BX00002_pick_n1_0) (= Rtotal_value_1 (+ Rtotal_value_0 Rvalue-n1_0))))
(assert (or (not BX00002_pick_n1_1) (= Rtotal_value_2 (+ Rtotal_value_1 Rvalue-n1_1))))
(assert (or (not BX00002_pick_n1_2) (= Rtotal_value_3 (+ Rtotal_value_2 Rvalue-n1_2))))
(assert (or (not BX00002_pick_n1_3) (= Rtotal_value_4 (+ Rtotal_value_3 Rvalue-n1_3))))
(assert (or (not BX00002_pick_n1_4) (= Rtotal_value_5 (+ Rtotal_value_4 Rvalue-n1_4))))
(assert (or (not BX00001_pick_n2_0) (= Rvalue-n2_1 0)))
(assert (or (not BX00001_pick_n2_1) (= Rvalue-n2_2 0)))
(assert (or (not BX00001_pick_n2_2) (= Rvalue-n2_3 0)))
(assert (or (not BX00001_pick_n2_3) (= Rvalue-n2_4 0)))
(assert (or (not BX00001_pick_n2_4) (= Rvalue-n2_5 0)))
(assert (or (not BX00001_pick_n2_0) (= Rtotal_value_1 (+ Rtotal_value_0 Rvalue-n2_0))))
(assert (or (not BX00001_pick_n2_1) (= Rtotal_value_2 (+ Rtotal_value_1 Rvalue-n2_1))))
(assert (or (not BX00001_pick_n2_2) (= Rtotal_value_3 (+ Rtotal_value_2 Rvalue-n2_2))))
(assert (or (not BX00001_pick_n2_3) (= Rtotal_value_4 (+ Rtotal_value_3 Rvalue-n2_3))))
(assert (or (not BX00001_pick_n2_4) (= Rtotal_value_5 (+ Rtotal_value_4 Rvalue-n2_4))))
(assert (or (not BX00000_pick_n0_0) (= Rvalue-n0_1 0)))
(assert (or (not BX00000_pick_n0_1) (= Rvalue-n0_2 0)))
(assert (or (not BX00000_pick_n0_2) (= Rvalue-n0_3 0)))
(assert (or (not BX00000_pick_n0_3) (= Rvalue-n0_4 0)))
(assert (or (not BX00000_pick_n0_4) (= Rvalue-n0_5 0)))
(assert (or (not BX00000_pick_n0_0) (= Rtotal_value_1 (+ Rtotal_value_0 Rvalue-n0_0))))
(assert (or (not BX00000_pick_n0_1) (= Rtotal_value_2 (+ Rtotal_value_1 Rvalue-n0_1))))
(assert (or (not BX00000_pick_n0_2) (= Rtotal_value_3 (+ Rtotal_value_2 Rvalue-n0_2))))
(assert (or (not BX00000_pick_n0_3) (= Rtotal_value_4 (+ Rtotal_value_3 Rvalue-n0_3))))
(assert (or (not BX00000_pick_n0_4) (= Rtotal_value_5 (+ Rtotal_value_4 Rvalue-n0_4))))
  ;; PRECONDITIONS
(assert (or (not BX00000_pick_n0_0) (not (= Rvalue-n0_0 0))))
(assert (or (not BX00000_pick_n0_1) (not (= Rvalue-n0_1 0))))
(assert (or (not BX00000_pick_n0_2) (not (= Rvalue-n0_2 0))))
(assert (or (not BX00000_pick_n0_3) (not (= Rvalue-n0_3 0))))
(assert (or (not BX00000_pick_n0_4) (not (= Rvalue-n0_4 0))))
(assert (or (not BX00001_pick_n2_0) (not (= Rvalue-n2_0 0))))
(assert (or (not BX00001_pick_n2_1) (not (= Rvalue-n2_1 0))))
(assert (or (not BX00001_pick_n2_2) (not (= Rvalue-n2_2 0))))
(assert (or (not BX00001_pick_n2_3) (not (= Rvalue-n2_3 0))))
(assert (or (not BX00001_pick_n2_4) (not (= Rvalue-n2_4 0))))
(assert (or (not BX00002_pick_n1_0) (not (= Rvalue-n1_0 0))))
(assert (or (not BX00002_pick_n1_1) (not (= Rvalue-n1_1 0))))
(assert (or (not BX00002_pick_n1_2) (not (= Rvalue-n1_2 0))))
(assert (or (not BX00002_pick_n1_3) (not (= Rvalue-n1_3 0))))
(assert (or (not BX00002_pick_n1_4) (not (= Rvalue-n1_4 0))))
  ;; MUTUAL EXCLUSION FOR INTERFERING ACTIONS
(assert (or (not BX00000_pick_n0_0) (not BX00001_pick_n2_0)))
(assert (or (not BX00000_pick_n0_1) (not BX00001_pick_n2_1)))
(assert (or (not BX00000_pick_n0_2) (not BX00001_pick_n2_2)))
(assert (or (not BX00000_pick_n0_3) (not BX00001_pick_n2_3)))
(assert (or (not BX00000_pick_n0_4) (not BX00001_pick_n2_4)))
(assert (or (not BX00000_pick_n0_0) (not BX00002_pick_n1_0)))
(assert (or (not BX00000_pick_n0_1) (not BX00002_pick_n1_1)))
(assert (or (not BX00000_pick_n0_2) (not BX00002_pick_n1_2)))
(assert (or (not BX00000_pick_n0_3) (not BX00002_pick_n1_3)))
(assert (or (not BX00000_pick_n0_4) (not BX00002_pick_n1_4)))
(assert (or (not BX00001_pick_n2_0) (not BX00000_pick_n0_0)))
(assert (or (not BX00001_pick_n2_1) (not BX00000_pick_n0_1)))
(assert (or (not BX00001_pick_n2_2) (not BX00000_pick_n0_2)))
(assert (or (not BX00001_pick_n2_3) (not BX00000_pick_n0_3)))
(assert (or (not BX00001_pick_n2_4) (not BX00000_pick_n0_4)))
(assert (or (not BX00001_pick_n2_0) (not BX00002_pick_n1_0)))
(assert (or (not BX00001_pick_n2_1) (not BX00002_pick_n1_1)))
(assert (or (not BX00001_pick_n2_2) (not BX00002_pick_n1_2)))
(assert (or (not BX00001_pick_n2_3) (not BX00002_pick_n1_3)))
(assert (or (not BX00001_pick_n2_4) (not BX00002_pick_n1_4)))
(assert (or (not BX00002_pick_n1_0) (not BX00000_pick_n0_0)))
(assert (or (not BX00002_pick_n1_1) (not BX00000_pick_n0_1)))
(assert (or (not BX00002_pick_n1_2) (not BX00000_pick_n0_2)))
(assert (or (not BX00002_pick_n1_3) (not BX00000_pick_n0_3)))
(assert (or (not BX00002_pick_n1_4) (not BX00000_pick_n0_4)))
(assert (or (not BX00002_pick_n1_0) (not BX00001_pick_n2_0)))
(assert (or (not BX00002_pick_n1_1) (not BX00001_pick_n2_1)))
(assert (or (not BX00002_pick_n1_2) (not BX00001_pick_n2_2)))
(assert (or (not BX00002_pick_n1_3) (not BX00001_pick_n2_3)))
(assert (or (not BX00002_pick_n1_4) (not BX00001_pick_n2_4)))
  ;; FRAME AXIOMS
(assert (or BX00000_pick_n0_0 BX00002_pick_n1_0 BX00001_pick_n2_0 (= Rtotal_value_1 Rtotal_value_0)))
(assert (or BX00000_pick_n0_1 BX00002_pick_n1_1 BX00001_pick_n2_1 (= Rtotal_value_2 Rtotal_value_1)))
(assert (or BX00000_pick_n0_2 BX00002_pick_n1_2 BX00001_pick_n2_2 (= Rtotal_value_3 Rtotal_value_2)))
(assert (or BX00000_pick_n0_3 BX00002_pick_n1_3 BX00001_pick_n2_3 (= Rtotal_value_4 Rtotal_value_3)))
(assert (or BX00000_pick_n0_4 BX00002_pick_n1_4 BX00001_pick_n2_4 (= Rtotal_value_5 Rtotal_value_4)))
(assert (or BX00000_pick_n0_0 (= Rvalue-n0_1 Rvalue-n0_0)))
(assert (or BX00000_pick_n0_1 (= Rvalue-n0_2 Rvalue-n0_1)))
(assert (or BX00000_pick_n0_2 (= Rvalue-n0_3 Rvalue-n0_2)))
(assert (or BX00000_pick_n0_3 (= Rvalue-n0_4 Rvalue-n0_3)))
(assert (or BX00000_pick_n0_4 (= Rvalue-n0_5 Rvalue-n0_4)))
(assert (or BX00002_pick_n1_0 (= Rvalue-n1_1 Rvalue-n1_0)))
(assert (or BX00002_pick_n1_1 (= Rvalue-n1_2 Rvalue-n1_1)))
(assert (or BX00002_pick_n1_2 (= Rvalue-n1_3 Rvalue-n1_2)))
(assert (or BX00002_pick_n1_3 (= Rvalue-n1_4 Rvalue-n1_3)))
(assert (or BX00002_pick_n1_4 (= Rvalue-n1_5 Rvalue-n1_4)))
(assert (or BX00001_pick_n2_0 (= Rvalue-n2_1 Rvalue-n2_0)))
(assert (or BX00001_pick_n2_1 (= Rvalue-n2_2 Rvalue-n2_1)))
(assert (or BX00001_pick_n2_2 (= Rvalue-n2_3 Rvalue-n2_2)))
(assert (or BX00001_pick_n2_3 (= Rvalue-n2_4 Rvalue-n2_3)))
(assert (or BX00001_pick_n2_4 (= Rvalue-n2_5 Rvalue-n2_4)))
  ;; EXCLUSIONS ON ENUM VALUES
  ;; NO ACTIONS AT THE LAST STEP
(assert (not BX00000_pick_n0_5))
(assert (not BX00001_pick_n2_5))
(assert (not BX00002_pick_n1_5))
(check-sat)
(exit)