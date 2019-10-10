(load "load.lsp")

; basic test
(setf test_unification_var_first '(P A (? y)) )
(setf test_unification_var_second '(P (? x) (func (? h) )))
(setf test_unification_var_result (unification test_unification_var_first test_unification_var_second))
(format t "~%INFO:unification_test.lsp: constant: (unification ~S ~S): ~S (expected: ???)" test_unification_var_first test_unification_var_second test_unification_var_result)
