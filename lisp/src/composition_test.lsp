
(load "load.lsp")
(setf loglevel "wa")

(defun test_composition (test_name first_var second_var expected) 
	(when (string= loglevel "debug") (format t "~%TEST:composition_test.lsp: ~S :(composition ~S ~S) (composition: ~S)" test_name first_var second_var expected))
	(setf result (composition first_var second_var))
	(format t "~%TEST:composition_test.lsp: ~S : (composition ~S ~S) = ~S (expected: ~S)" test_name first_var second_var result expected)
)

(format t "~%TEST:composition_test.lsp: TESTS OF COMPOSITION")
(test_composition "single composition - NIL x NIL      " NIL            NIL        NIL                        )
(test_composition "single composition - object x NIL   " '((x y))       NIL        '((x y))                   )
(test_composition "single composition - NIL x object   " NIL            '((x y))   '((x y))                   )
(test_composition "single composition - object x object" '((F H) (? X)) '(A (? Y)) '(((F H) (? X)) (A (? Y))) )