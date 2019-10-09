
(defun unification (e1 e2)
	(format t "~%       DEBUG:unification.lsp:unification: [ ~S ] [ ~S ]" e1 e2)
	(cond
		(; e1 or e2 is atom
			(or (is_atom e1) (is_atom e2))
			(return-from unification (unification_with_atom e1 e2))
		)
		(; e1 and e2 are not atom
			(and (not (is_atom e1)) (not (is_atom e2)))
			(return-from unification (unification_with_list e1 e2))
		)
	)
)

(defun unification_with_atom (e1 e2)
	(format t "~%       DEBUG:unification.lsp:unification_with_atom: [ ~S ] [ ~S ]" e1 e2)
	(prog (is_in)
		; if e2 is atom and e1 not, switch them
		(when (and (not(is_atom e1)) (is_atom e2) )
			(format t "~%       DEBUG:unification.lsp:unification_with_atom: e2 is atom and e1 not -> (unification_with_atom e2 e1)")
			(return-from unification_with_atom (unification_with_atom e2 e1))
		)

		; if e1 == e2 return NIL
		(when (is_equal e1 e2)
			(format t "~%       DEBUG:unification.lsp:unification_with_atom: e1 [ ~S ] is equal to e2 [ ~S ] -> return NIL " e1 e2)
			(return-from unification_with_atom NIL)
		)

		;if e1 is variable
		(when (is_var e1)
			(format t "~%       DEBUG:unification.lsp:unification_with_atom: e1 is var and e2 not")
			; checking if e1 is in e2
			(setf is_in (is_in_list e1 e2))
			(format t "~%       DEBUG:unification.lsp:unification_with_atom: checking if e1 is in e2 [~S]" is_in)
			(when (is_in)
				(format t "~%       DEBUG:unification.lsp:unification_with_atom: e1 is in e2 -> return NIL")
				(return-from unification_with_atom NIL)
			)
			; making e2/e1
			(format t "~%       DEBUG:unification.lsp:unification_with_atom: making E2/E1 -> TODO que hay que hacer aqui????")
			(return-from unification_with_atom NOSE_QUE_DEVOLVER)	
		)

		; if e2 is variable
		(when (is_var e2)
			; making e1/e2
			(format t "~%       DEBUG:unification.lsp:unification_with_atom: making e1/e2 -> TODO: que sigintica esto E1/E2???")
			(return-from unification_with_atom NOSE_QUE_DEVOLVER)
		)

		;in other case return nil
		(format t "~%       DEBUG:unification.lsp:unification_with_atom: end of function -> return NIL ")
		(return-from unification_with_atom NIL)
	)
)

(defun unification_with_list (e1 e2)
	(format t "~%       DEBUG:unification.lsp:unification_with_list: [ ~S ] [ ~S ]" e1 e2)
	(prog (f1 f2 t1 t2 z1 z2 g1 g2 result)
		;getting f1, f2, t1, t2
		(setf t2 (rest e2))
		(setf t1 (rest e1))
		(setf f1 (first e1))
		(setf f2 (first e2))
		(format t "~%       DEBUG:unification.lsp:unification_with_list: f1 [ ~S ] t1 [ ~S ] f2 [ ~S ] t2 [ ~S ]" f1 t1 f2 t2)
		;calculating unification of f1 and f2 into z1
		(format t "~%       DEBUG:unification.lsp:unification_with_list: calculating z1 -> unification( f1 [ ~S ] f2 [ ~S ])" f1 f2)
		(setf z1 (unification f1 f2))
		(format t "~%       DEBUG:unification.lsp:unification_with_list: calculating z1 -> unification( f1 [ ~S ] f2 [ ~S ]) = [ ~S ]" f1 f2 z1)
		(when (is_equal z1 NIL)
			(format t "~%       DEBUG:unification.lsp:unification_with_list: z1 result is NIL -> return NIL")
			(return-from unification_with_list NIL)
		)
		;calculating sustitution of z1 and t1 into g1
		(format t "~%       DEBUG:unification.lsp:unification_with_list: calculating g1 -> sustitution( z1 [ ~S ] t1 [ ~S ])" z1 t1)
		(setf g1 (sustitution z1 t1))
		(format t "~%       DEBUG:unification.lsp:unification_with_list: calculating g1 -> sustitution( z1 [ ~S ] t1 [ ~S ]) = [ ~S ]" z1 t1 g1)
		;calculating sustitution of z1 and t1 into g1
		(format t "~%       DEBUG:unification.lsp:unification_with_list: calculating g2 -> sustitution( z2 [ ~S ] t2 [ ~S ])" z2 t2)
		(setf g2 (sustitution z2 t2))
		(format t "~%       DEBUG:unification.lsp:unification_with_list: calculating g2 -> sustitution( z2 [ ~S ] t2 [ ~S ]) = [ ~S ]" z2 t2 g2)
		;calculating unification of g1 and g2 into z2
		(format t "~%       DEBUG:unification.lsp:unification_with_list: calculating z1 -> unification( g1 [ ~S ] g2 [ ~S ])" g1 g2)
		(setf z2 (unification g1 g2))
		(format t "~%       DEBUG:unification.lsp:unification_with_list: calculating z1 -> unification( g1 [ ~S ] g2 [ ~S ]) = [ ~S ]" g1 g2 z2)
		(when (is_equal z2 NIL)
			(format t "~%       DEBUG:unification.lsp:unification_with_list: z2 result is NIL -> return NIL")
			(return-from unification_with_list NIL)
		)
		;calculating composition of z1 and z2
		(format t "~%       DEBUG:unification.lsp:unification_with_list: calculating result -> composition( z1 [ ~S ] z2 [ ~S ])" z1 z2)
		(setf result (composition z1 z2))
		(format t "~%       DEBUG:unification.lsp:unification_with_list: calculating result -> composition( z1 [ ~S ] z2 [ ~S ]) = [ ~S ]" z1 z2 result)
		;finished unification, returning result
		(format t "~%       DEBUG:unification.lsp:unification_with_list: finished unification( e1 [ ~S ] e2 [ ~S ]) = [ ~S ]" e1 e2 result)
		(return-from unification_with_list result)
	)
)