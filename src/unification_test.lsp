(load "load.lsp")

; basic test
(setf test_unification_var_first '((? y)) )
(setf test_unification_var_second '((? x) (func (? h) )))
(setf test_unification_var_result (unification test_unification_var_first test_unification_var_second))
(format t "~%INFO:unification_test.lsp: constant: (unification ~S ~S): ~S (expected: ???)" test_unification_var_first test_unification_var_second test_unification_var_result)
