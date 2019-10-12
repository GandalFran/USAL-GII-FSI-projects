
(setf unification_error "unification_error")

(defun unification (e1 e2)
	
	(prog (e1_editable e2_editable) 
		(setf e1_editable (copy-tree e1))
		(setf e2_editable (copy-tree e2))
		;apply processing to input elements 
		(when (eq (length e1_editable) 1) 
			(setf e1_editable (first e1_editable))
		)
		(when (eq (length e2_editable) 1) 
			(setf e2_editable (first e2_editable))
		)
		(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification: [ ~S ] [ ~S ]" e1_editable e2_editable))
		(cond
			(; e1 or e2 is atom
				(or (is_atom e1_editable) (is_atom e2_editable))
				(return-from unification (unification_with_atom e1_editable e2_editable))
			)
			(; e1 and e2 are not atom
				(and (not (is_atom e1_editable)) (not (is_atom e2_editable)))
				(return-from unification (unification_with_list e1_editable e2_editable))
			)
			( T 
				(print "~% POS NO SE QUE HACER EN ESTE CASO")
			)
		)
	)
)

(defun unification_with_atom (e1 e2)
	(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_atom: [ ~S ] [ ~S ]" e1 e2))
	(prog (is_in result)
		(cond
			(; if e2 is atom and e1 not, switch them
				(and (not(is_atom e1)) (is_atom e2) )
				
				(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_atom: e2 is atom and e1 not -> (unification_with_atom e2 e1)"))
				(return-from unification_with_atom (unification_with_atom e2 e1))
			)

			(; if e1 == e2 return NIL
 				(is_equal e1 e2)
				
				(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_atom: e1 [ ~S ] is equal to e2 [ ~S ] -> return NIL " e1 e2))
				(return-from unification_with_atom NIL)
			)

			(; if e1 is variable
				(is_var e1)
				
				; checking if e1 is in e2
				(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_atom: e1 is var -> checking if e1 is in e2"))
				(when (member e1 e2)
					(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_atom: e1 is var -> e1 is in e2 -> return unification_error"))
					(return-from unification_with_atom unification_error)
				)
				; making e2/e1
				(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_atom: e1 is var -> e1 is not in e2 -> e2 [ ~S ] / e1 [ ~S ] " e2 e1))
				(setf result (list e2 e1))
				(return-from unification_with_atom result)	
			)

			(; if e2 is variable
				(is_var e2)
				
				(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_atom: e2 is var -> e1 [ ~S ] / e2 [ ~S ]" e1 e2))
				(setf result (list e1 e2))
				(return-from unification_with_atom result)
			)

			( T
				;in other case return error
				(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_atom: e1 and e2 are not var -> return unification_error "))
				(return-from unification_with_atom unification_error)
			)
		)
	)
)

(defun unification_with_list (e1 e2)
	(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_list: [ ~S ] [ ~S ]" e1 e2))
	(prog (f1 f2 t1 t2 z1 z2 g1 g2 result)
		;getting f1, f2, t1, t2
		(setf t1 (rest e1))
		(setf t2 (rest e2))
		(setf f1 (first e1))
		(setf f2 (first e2))
		(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_list: f1 [ ~S ] t1 [ ~S ] f2 [ ~S ] t2 [ ~S ]" f1 t1 f2 t2))
		;calculating unification of f1 and f2 into z1
		(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_list: calculating z1 -> unification( f1 [ ~S ] f2 [ ~S ])" f1 f2))
		(setf z1 (unification f1 f2))
		(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_list: calculating z1 -> unification( f1 [ ~S ] f2 [ ~S ]) = [ ~S ]" f1 f2 z1))
		(when (is_equal z1 unification_error)
			(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_list: z1 result is NIL -> return NIL"))
			(return-from unification_with_list NIL)
		)
		;calculating sustitution of z1 and t1 into g1
		(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_list: calculating g1 -> sustitution( t1 [ ~S ] z1 [ ~S ])" t1 z1))
		(setf g1 (sustitution t1 z1))
		(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_list: calculating g1 -> sustitution( t1 [ ~S ] z1 [ ~S ]) = [ ~S ]" t1 z1 g1))
		;calculating sustitution of z1 and t1 into g1
		(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_list: calculating g2 -> sustitution( t2 [ ~S ] z1 [ ~S ])" t2 z1))
		(setf g2 (sustitution t2 z1))
		(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_list: calculating g2 -> sustitution( t2 [ ~S ] z1 [ ~S ]) = [ ~S ]" t2 z1 g2))
		;calculating unification of g1 and g2 into z2
		(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_list: calculating z2 -> unification( g1 [ ~S ] g2 [ ~S ])" g1 g2))
		(setf z2 (unification g1 g2))
		(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_list: calculating z2 -> unification( g1 [ ~S ] g2 [ ~S ]) = [ ~S ]" g1 g2 z2))
		(when (is_equal z2 unification_error)
			(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_list: z2 result is NIL -> return NIL"))
			(return-from unification_with_list NIL)
		)
		;calculating composition of z1 and z2
		(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_list: calculating result -> composition( z1 [ ~S ] z2 [ ~S ])" z1 z2))
		(setf result (composition z1 z2))
		(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_list: calculating result -> composition( z1 [ ~S ] z2 [ ~S ]) = [ ~S ]" z1 z2 result))
		;finished unification, returning result
		(when (string= loglevel "debug") (format t "~%       DEBUG:unification.lsp:unification_with_list: finished unification( e1 [ ~S ] e2 [ ~S ]) = [ ~S ]" e1 e2 result))
		(return-from unification_with_list result)
	)
)