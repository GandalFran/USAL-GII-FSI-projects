(load "load.lsp")

(format t "~%TEST:composition_test.lsp: TESTS OF composition")
; test nil,nil -> nil
(setf test_composition_var_1 NIL )
(setf test_composition_var_2 NIL )
(setf test_composition_var_result (composition test_composition_var_1 test_composition_var_2) )
(format t "~%TEST:composition_test.lsp: (composition ~S ~S): ~S (expected: NIL)" test_composition_var_1 test_composition_var_2 test_composition_var_result)
; test something,nil -> somehting
(setf test_composition_var_1 '((x y)))
(setf test_composition_var_2 NIL )
(setf test_composition_var_result (composition test_composition_var_1 test_composition_var_2) )
(format t "~%TEST:composition_test.lsp: (composition ~S ~S): ~S (expected: ((x y)))" test_composition_var_1 test_composition_var_2 test_composition_var_result)

; test nil,something -> something
(setf test_composition_var_1 NIL )
(setf test_composition_var_2 '((x y)) )
(setf test_composition_var_result (composition test_composition_var_1 test_composition_var_2) )
(format t "~%TEST:composition_test.lsp: (composition ~S ~S): ~S (expected: ((x y)))" test_composition_var_1 test_composition_var_2 test_composition_var_result)

; test something,something -> composition
(setf test_composition_var_1 '((F H) (? X)) )
(setf test_composition_var_2 '(A (? Y)) )
(setf test_composition_var_result (composition test_composition_var_1 test_composition_var_2) )
(format t "~%TEST:composition_test.lsp: (composition ~S ~S): ~S (expected: ((z y) (a b) (m n)) )" test_composition_var_1 test_composition_var_2 test_composition_var_result)
