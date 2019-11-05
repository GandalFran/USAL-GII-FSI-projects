;
;	author: Héctor Sánchez San Blas & Francisco Pinto-Santos
;	date: 10/10/2019
;	file: utils_test.lsp

(load "load.lsp")

(defun test_is_atom(test_name var expected)
	(setq numberOfTabs (1+ numberOfTabs))
	(setf result (is_atom var))
	(setf result_equal (is_equal result expected))
	(logging loglevel "-" t "TEST:utils_test.lsp: ~S [correcto ~S] : (is_atom ~S) = ~S (expected: ~S)" test_name result_equal var result expected)
)

(defun test_is_var(test_name var expected)
	(setq numberOfTabs (1+ numberOfTabs))
	(setf result (is_var var))
	(setf result_equal (is_equal result expected))
	(logging loglevel "-" t "TEST:utils_test.lsp: ~S [correcto ~S] : (is_var ~S) = ~S (expected: ~S)" test_name result_equal var result expected)
)

(defun test_is_equal(test_name var1 var2 expected)
	(setq numberOfTabs (1+ numberOfTabs))
	(setf result (is_equal var1 var2))
	(setf result_equal (is_equal result expected))
	(logging loglevel "-" t "TEST:utils_test.lsp: ~S [correcto ~S] : (is_equal ~S ~S) = ~S (expected: ~S)" test_name result_equal var1 var2 result expected)
)


(format t "~%~%TEST:utils_test.lsp: TESTS OF UTILS")

(test_is_atom "is_atom   0"	NIL    T  )
(test_is_atom "is_atom   1"	'X     T  )
(test_is_atom "is_atom   2"	'(? X) T  )
(test_is_atom "is_atom   3"	'(A X) NIL)

(test_is_var "is_var    0"	NIL		NIL)
(test_is_var "is_var    1"	'X		NIL)
(test_is_var "is_var    2"	'(? X)	T  )
(test_is_var "is_var    3"	'(A X)	NIL)

(test_is_equal "is_equal  0" NIL    NIL		T  )
(test_is_equal "is_equal  1" NIL    'A		NIL)
(test_is_equal "is_equal  2" NIL    '(A X)	NIL)
(test_is_equal "is_equal  3" 'A		NIL		NIL)
(test_is_equal "is_equal  4" '(A X)	NIL 	NIL)
(test_is_equal "is_equal  5" 'X		'Y     	NIL)
(test_is_equal "is_equal  6" 'X		'X     	T  )
(test_is_equal "is_equal  7" 'X		'(? X)  NIL)
(test_is_equal "is_equal  8" '(? X)	'(? X)  T  )
(test_is_equal "is_equal  9" '(A X)	'(? X)  NIL)
(test_is_equal "is_equal 10" '(? X)	'(A X)  NIL)
(test_is_equal "is_equal 11" '(A X)	'(A X)  T  )