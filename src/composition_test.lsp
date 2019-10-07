(load "composition.lsp")

; test foo -> foo
(setf test_composition_var_1 ((x y) (a b)) )
(setf test_composition_var_2 ((z y) (c b)) )
(setf test_composition_var_result (composition test_composition_var_1 test_composition_var_2) )
(format t "~%INFO:composition_test.lsp: (composition ~S ~S): ~S (expected: T)" test_composition_var_1 test_composition_var_2 test_composition_var_result)