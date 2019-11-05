;
;	author: Héctor Sánchez San Blas & Francisco Pinto-Santos
;	date: 10/10/2019
;	file: composition_test.lsp

(load "load.lsp")

(defun test_composition (test_name first_var second_var expected) 
	(logging "debug" "+" t "TEST:composition_test.lsp: ~S :(composition ~S ~S) (expected: ~S)" test_name first_var second_var expected)
	(setf result (composition first_var second_var))
	(setf result_equal (is_equal result expected))
	(logging loglevel "-" t "TEST:composition_test.lsp: ~S [correcto ~S] : (composition ~S ~S) = ~S (expected: ~S)" test_name result_equal first_var second_var result expected)
)

(format t "~%~%TEST:composition_test.lsp: TESTS OF COMPOSITION")
(test_composition "test 0" NIL                     NIL                   NIL                           )
(test_composition "test 1" '((x y))                NIL                   '((x y))                      )
(test_composition "test 2" NIL                     '((x y))              '((x y))                      )
(test_composition "test 3" '((F H) (? X))          '(A (? Y))            '(((F H) (? X)) (A (? Y)))    )
(test_composition "test 4" '(((? X) (? Y)) (A B))  '( (M (? X)) (R B) )  '((M (? Y)) (A R) (M (? X)))  )