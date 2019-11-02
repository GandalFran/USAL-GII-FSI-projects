
(load "load.lsp")
(setf loglevel "debug")

(defun test_unification (test_name first_var second_var expected) 
	(logging loglevel "+" t "TEST:unification_test.lsp: ~S :(unification ~S ~S) (expected: ~S)" test_name first_var second_var expected)
	(setf result (unification first_var second_var))
	(logging loglevel "-" t "TEST:unification_test.lsp: ~S : (unification ~S ~S) = ~S (expected: ~S)" test_name first_var second_var result expected)
)

(format t "~%TEST:unification_test.lsp: TESTS OF UNIFICATION")
(test_unification "test 1" '((? X) A)            '((F H) (? Y))   '(((F H) (? X)) (A (? Y))) )
(test_unification "test 2" '((? X) (G (? X)))    '(A (G A))       '(A (? X)) )
(test_unification "test 3" '((? X) (? Y) (? X))  '(R (G(? X)) P)  NIL )