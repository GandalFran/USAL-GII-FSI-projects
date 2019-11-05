
(load "load.lsp")

(defun test_composition (test_name first_var second_var expected) 
	(logging "debug" "+" t "TEST:composition_test.lsp: ~S :(composition ~S ~S) (expected: ~S)" test_name first_var second_var expected)
	(setf result (composition first_var second_var))
	(setf result_equal (is_equal result expected))
	(logging loglevel "-" t "TEST:composition_test.lsp: ~S [correcto ~S] : (composition ~S ~S) = ~S (expected: ~S)" test_name result_equal first_var second_var result expected)
)

(format t "~%TEST:composition_test.lsp: TESTS OF COMPOSITION")
(test_composition "test 00" NIL            NIL        NIL                        )
(test_composition "test 01" '((x y))       NIL        '((x y))                   )
(test_composition "test 02" NIL            '((x y))   '((x y))                   )
(test_composition "test 03" '((F H) (? X)) '(A (? Y)) '(((F H) (? X)) (A (? Y))) )