(load "load.lsp")

(setf test_unification_var_first '((? x) A) )
(setf test_unification_var_second '((f h) (? y)) )
(format t "~%TEST:unification_test.lsp: (unification ~S ~S)" test_unification_var_first test_unification_var_second)
(setf test_unification_var_result (unification test_unification_var_first test_unification_var_second))
(format t "~%TEST:unification_test.lsp: constant: (unification ~S ~S) = ~S (expected: ( ((F H) (? X)) (A (? Y))) )" test_unification_var_first test_unification_var_second test_unification_var_result)

(setf test_unification_var_first '( (? X) (G (? Y)) ) )
(setf test_unification_var_second '( A (G (? A)) ) )
(format t "~%TEST:unification_test.lsp: (unification ~S ~S)" test_unification_var_first test_unification_var_second)
(setf test_unification_var_result (unification test_unification_var_first test_unification_var_second))
(format t "~%TEST:unification_test.lsp: constant: (unification ~S ~S) = ~S (expected: ( None )" test_unification_var_first test_unification_var_second test_unification_var_result)

;(setf test_unification_var_first '(( (? X) (? Y) (? X))) )
;(setf test_unification_var_second '( ( R (g (? X)) P)) )
;(format t "~%TEST:unification_test.lsp: (unification ~S ~S)" test_unification_var_first test_unification_var_second)
;(setf test_unification_var_result (unification test_unification_var_first test_unification_var_second))
;(format t "~%TEST:unification_test.lsp: constant: (unification ~S ~S) = ~S (expected: ( None )" test_unification_var_first test_unification_var_second test_unification_var_result)
