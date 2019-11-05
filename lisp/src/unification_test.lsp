;
;	author: Héctor Sánchez San Blas & Francisco Pinto-Santos
;	date: 10/10/2019
;	file: unification_test.lsp

(load "load.lsp")

(defun test_unification (test_name first_var second_var expected) 
	(logging "debug" "+" t "TEST:unification_test.lsp: ~S :(unification ~S ~S) (expected: ~S)" test_name first_var second_var expected)
	(setf result (unification first_var second_var))
	(setf result_equal (is_equal result expected))
	(logging loglevel "-" t "TEST:unification_test.lsp: ~S [correcto ~S] : (unification ~S ~S) = ~S (expected: ~S)" test_name result_equal first_var second_var result expected)
)

(format t "~%~%TEST:unification_test.lsp: TESTS OF UNIFICATION")
(test_unification "test 0" '(F (? X) (G (? X)))  '(F (? A) (G (? B)) )  '(((? B) (? X)) ((? B) (? A))) )
(test_unification "test 1" '(F (? X) (G (? X) )) '(F A (G A))           '(A (? X))                     )
(test_unification "test 2" '(G (? X) A)          '(G (M N) (? y))       '(((M N) (? X)) (A (? Y)))     )
(test_unification "test 3" '(FRUTA MANZANA)      '(FRUTA (? x))         '(MANZANA (? X))               )
(test_unification "test 4" '(A B C D)            '(X Y Z Z)             'UNIFICATION_ERROR             )