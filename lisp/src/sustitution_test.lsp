
(load "load.lsp")

(defun test_sustitution (test_name first_var second_var expected) 
	(logging "debug" "+" t "TEST:sustitution_test.lsp: ~S :(sustitution ~S ~S) (expected: ~S)" test_name first_var second_var expected)
	(setf result (sustitution first_var second_var))
	(setf result_equal (is_equal result expected))
	(logging loglevel "-" t "TEST:sustitution_test.lsp: ~S [correcto ~S] : (sustitution ~S ~S) = ~S (expected: ~S)" test_name result_equal first_var second_var result expected)
)

(format t "~%~%TEST:sustitution_test.lsp: TESTS OF SUSTITUTION")
(test_sustitution "test 0" '(x)     '(y x)         '(y)     )
(test_sustitution "test 1" '(x)     '((? x) x)     '((? x)) )
(test_sustitution "test 2" '((? x)) '(y (? x))     '(y)     )
(test_sustitution "test 3" '((? x)) '((? y) (? x)) '((? y)) )
(test_sustitution "test 4" '(F H (? X)) '( ((? Y) F) ((A B C (? Z)) (? X)) ) '((? Y) H (A B C (? Z)) ) )