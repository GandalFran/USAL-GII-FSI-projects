
(load "load.lsp")
(setf loglevel "debug")

(defun test_sustitution (test_name first_var second_var expected) 
	(logging loglevel "+" t "TEST:sustitution_test.lsp: ~S :(sustitution ~S ~S) (expected: ~S)" test_name first_var second_var expected)
	(setf result (sustitution first_var second_var))
	(logging loglevel "-" t "TEST:sustitution_test.lsp: ~S : (sustitution ~S ~S) = ~S (expected: ~S)" test_name first_var second_var result expected)
)

(format t "~%TEST:sustitution_test.lsp: TESTS OF SUSTITUTION")
(test_sustitution "single sustitution - atom x atom    " '(x)     '(y x)         '(y)     )
(test_sustitution "single sustitution - atom x object  " '(x)     '((? x) x)     '((? x)) )
(test_sustitution "single sustitution - object x atom  " '((? x)) '(y (? x))     '(y)     )
(test_sustitution "single sustitution - object x object" '((? x)) '((? y) (? x)) '((? y)) )

(test_sustitution "single sustitution - object x object" '((F H) (? X)) '(A (? Y)) '((F H) (? X)) )