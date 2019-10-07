(load "is_atom.lsp")

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