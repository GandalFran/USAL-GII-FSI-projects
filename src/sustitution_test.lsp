
(load "load.lsp")


(format t "~%INFO:sustitution_test.lsp: TESTS OF sustitution")

; basic test
(setf test_sustitution_var_first '(x))
(setf test_sustitution_var_second '(y x))
(setf test_sustitution_var_result (sustitution test_sustitution_var_first test_sustitution_var_second))
(format t "~%INFO:sustitution_test.lsp: constant: (sustitution ~S ~S): ~S (expected: Y)" test_sustitution_var_first test_sustitution_var_second test_sustitution_var_result)
