(set-logic QF_LRA)
(declare-fun BX00000_pick_n0_0 () Bool)
(declare-fun BX00001_pick_n2_0 () Bool)
(declare-fun BX00002_pick_n1_0 () Bool)
(declare-fun Rtotal_value_0 () Real)
(declare-fun Rvalue-n0_0 () Real)
(declare-fun Rvalue-n1_0 () Real)
(declare-fun Rvalue-n2_0 () Real)
  ;; GOAL
(assert (= Rtotal_value_0 15))
  ;; INITIAL STATE
(assert (= Rtotal_value_0 0))
(assert (= Rvalue-n0_0 5))
(assert (= Rvalue-n1_0 5))
(assert (= Rvalue-n2_0 5))
  ;; EFFECTS
  ;; PRECONDITIONS
  ;; MUTUAL EXCLUSION FOR INTERFERING ACTIONS
  ;; FRAME AXIOMS
  ;; EXCLUSIONS ON ENUM VALUES
  ;; NO ACTIONS AT THE LAST STEP
(assert (not BX00000_pick_n0_0))
(assert (not BX00001_pick_n2_0))
(assert (not BX00002_pick_n1_0))
(check-sat)
(exit)
