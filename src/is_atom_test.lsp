(load "is_atom.lsp")


(format t "~%INFO:is_atom_test.lsp: TESTS OF is_atom")

; test nil -> T
(setf test_is_atom_var NIL)
(setf test_is_atom_var_result (is_atom test_is_atom_var) )
(format t "~%INFO:is_atom_test.lsp: constant: (is_atom ~S): ~S (expected: T)" test_is_atom_var test_is_atom_var_result)
; test constant -> T
(setf test_is_atom_var 'A)
(setf test_is_atom_var_result (is_atom test_is_atom_var) )
(format t "~%INFO:is_atom_test.lsp: constant: (is_atom ~S): ~S (expected: T)" test_is_atom_var test_is_atom_var_result)
; test variable -> T
(setf test_is_atom_var '(? a))
(setf test_is_atom_var_result (is_atom test_is_atom_var) )
(format t "~%INFO:is_atom_test.lsp: variable: (is_atom ~S): ~S (expected: T)" test_is_atom_var test_is_atom_var_result)
; test list -> NIL
(setf test_is_atom_var '(a b c))
(setf test_is_atom_var_result (is_atom test_is_atom_var) )
(format t "~%INFO:is_atom_test.lsp: list: (is_atom ~S): ~S (expected: NIL)" test_is_atom_var test_is_atom_var_result)
; test list with ? (1) -> NIL
(setf test_is_atom_var '(a ? b))
(setf test_is_atom_var_result (is_atom test_is_atom_var) )
(format t "~%INFO:is_atom_test.lsp: list with ? (1): (is_atom ~S): ~S (expected: NIL)" test_is_atom_var test_is_atom_var_result)
; test list with ? (2) -> NIL
(setf test_is_atom_var '(? a b))
(setf test_is_atom_var_result (is_atom test_is_atom_var) )
(format t "~%INFO:is_atom_test.lsp: list with ? (2): (is_atom ~S): ~S (expected: NIL)" test_is_atom_var test_is_atom_var_result)
; test list with ? (3) -> NIL
(setf test_is_atom_var '(a b ?))
(setf test_is_atom_var_result (is_atom test_is_atom_var) )
(format t "~%INFO:is_atom_test.lsp: list with ? (3): (is_atom ~S): ~S (expected: NIL)" test_is_atom_var test_is_atom_var_result)


(format t "~%INFO:is_atom_test.lsp: TESTS OF is_var")
; test nil -> NIL
(setf test_is_var_var NIL)
(setf test_is_var_var_result (is_var test_is_var_var) )
(format t "~%INFO:is_atom_test.lsp: : (is_var ~S): ~S (expected: NIL)" test_is_var_var test_is_var_var_result)
; test constant -> NIL
(setf test_is_var_var 'A)
(setf test_is_var_var_result (is_var test_is_var_var) )
(format t "~%INFO:is_atom_test.lsp: : (is_var ~S): ~S (expected: NIL)" test_is_var_var test_is_var_var_result)
; test list -> NIL
(setf test_is_var_var '(a b))
(setf test_is_var_var_result (is_var test_is_var_var) )
(format t "~%INFO:is_atom_test.lsp: : (is_var ~S): ~S (expected: NIL)" test_is_var_var test_is_var_var_result)
; test var -> NIL
(setf test_is_var_var '(? a))
(setf test_is_var_var_result (is_var test_is_var_var) )
(format t "~%INFO:is_atom_test.lsp: : (is_var ~S): ~S (expected: T)" test_is_var_var test_is_var_var_result)
; test list with ? -> NIL
(setf test_is_var_var '(? a b))
(setf test_is_var_var_result (is_var test_is_var_var) )
(format t "~%INFO:is_atom_test.lsp: : (is_var ~S): ~S (expected: NIL)" test_is_var_var test_is_var_var_result)


(format t "~%INFO:is_atom_test.lsp: TESTS OF is_equal")
; test nil -> NIL
(setf test_is_equal_var_1 NIL)
(setf test_is_equal_var_2 NIL)
(setf test_is_equal_var_result (is_equal test_is_equal_var_1 test_is_equal_var_2) )
(format t "~%INFO:is_atom_test.lsp: : (is_equal ~S ~S): ~S (expected: T)" test_is_equal_var_1 test_is_equal_var_2 test_is_equal_var_result)
; test constant, NIL -> NIL
(setf test_is_equal_var_1 'A)
(setf test_is_equal_var_2 NIL)
(setf test_is_equal_var_result (is_equal test_is_equal_var_1 test_is_equal_var_2) )
(format t "~%INFO:is_atom_test.lsp: : (is_equal ~S ~S): ~S (expected: NIL)" test_is_equal_var_1 test_is_equal_var_2 test_is_equal_var_result)
; test constant, var -> NIL
(setf test_is_equal_var_1 'A)
(setf test_is_equal_var_2 '(? a))
(setf test_is_equal_var_result (is_equal test_is_equal_var_1 test_is_equal_var_2) )
(format t "~%INFO:is_atom_test.lsp: : (is_equal ~S ~S): ~S (expected: NIL)" test_is_equal_var_1 test_is_equal_var_2 test_is_equal_var_result)
; test constant, list -> NIL
(setf test_is_equal_var_1 'A)
(setf test_is_equal_var_2 '(a b))
(setf test_is_equal_var_result (is_equal test_is_equal_var_1 test_is_equal_var_2) )
(format t "~%INFO:is_atom_test.lsp: : (is_equal ~S ~S): ~S (expected: NIL)" test_is_equal_var_1 test_is_equal_var_2 test_is_equal_var_result)
; test var, NIL -> NIL
(setf test_is_equal_var_1 '(? a))
(setf test_is_equal_var_2 NIL)
(setf test_is_equal_var_result (is_equal test_is_equal_var_1 test_is_equal_var_2) )
(format t "~%INFO:is_atom_test.lsp: : (is_equal ~S ~S): ~S (expected: NIL)" test_is_equal_var_1 test_is_equal_var_2 test_is_equal_var_result)
; test var, list -> NIL
(setf test_is_equal_var_1 '(? a))
(setf test_is_equal_var_2 '(a b))
(setf test_is_equal_var_result (is_equal test_is_equal_var_1 test_is_equal_var_2) )
(format t "~%INFO:is_atom_test.lsp: : (is_equal ~S ~S): ~S (expected: NIL)" test_is_equal_var_1 test_is_equal_var_2 test_is_equal_var_result)
; test var1, var2 -> NIL
(setf test_is_equal_var_1 '(? a))
(setf test_is_equal_var_2 '(? b))
(setf test_is_equal_var_result (is_equal test_is_equal_var_1 test_is_equal_var_2) )
(format t "~%INFO:is_atom_test.lsp: : (is_equal ~S ~S): ~S (expected: NIL)" test_is_equal_var_1 test_is_equal_var_2 test_is_equal_var_result)
; test var1, var1 -> NIL
(setf test_is_equal_var_1 '(? a))
(setf test_is_equal_var_2 '(? a))
(setf test_is_equal_var_result (is_equal test_is_equal_var_1 test_is_equal_var_2) )
(format t "~%INFO:is_atom_test.lsp: : (is_equal ~S ~S): ~S (expected: T)" test_is_equal_var_1 test_is_equal_var_2 test_is_equal_var_result)
; test list with ?, var -> NIL
(setf test_is_equal_var_1 '(? a b))
(setf test_is_equal_var_2 '(? a))
(setf test_is_equal_var_result (is_equal test_is_equal_var_1 test_is_equal_var_2) )
(format t "~%INFO:is_atom_test.lsp: : (is_equal ~S ~S): ~S (expected: NIL)" test_is_equal_var_1 test_is_equal_var_2 test_is_equal_var_result)
; test list1, list2 -> NIL
(setf test_is_equal_var_1 '(a b))
(setf test_is_equal_var_2 '(a c))
(setf test_is_equal_var_result (is_equal test_is_equal_var_1 test_is_equal_var_2) )
(format t "~%INFO:is_atom_test.lsp: : (is_equal ~S ~S): ~S (expected: NIL)" test_is_equal_var_1 test_is_equal_var_2 test_is_equal_var_result)
; test list1, list1 -> T
(setf test_is_equal_var_1 '(a b))
(setf test_is_equal_var_2 '(a b))
(setf test_is_equal_var_result (is_equal test_is_equal_var_1 test_is_equal_var_2) )
(format t "~%INFO:is_atom_test.lsp: : (is_equal ~S ~S): ~S (expected: T)" test_is_equal_var_1 test_is_equal_var_2 test_is_equal_var_result)