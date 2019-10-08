(defun composition (s1 s2) 
	(cond
		(; s1 and s2 are nill -> nil + nil = nil
			(and (eq s1 nil) (eq s2 nil))
			nil
		)

		(; s1 is not nil and s2 is nil -> a1 + nil = s1
			(and (not (eq s1 nil)) (eq s2 nil) )
			s1
		)

		(; a1 is nil and s2 is not nil -> nil + s2 = s2
			(and (eq s1 nil) (not (eq s2 nil)) )
			s2
		)

		(; s1 and s2 are atoms 
			(and (not (eq s1 nil)) (not (eq s2 nil)) )
			(composite_not_nil s1 s2)
		)
		
		(T NIL)
	)
)

;; INPUT FORMAT 
;; ej: {x/y, f(g)/z}	( (x y) ((f (? g)) z) )
(defun composite_not_nil (s1 s2)	
	(format t "~%DEBUG:composition.lsp:composite_not_nil: first: sustitution( ~S ~S )" s1 s2)
	; apply s2 sustitution over s1
	(setf s3 (sustitution s1 s2))
	(format t "~%DEBUG:composition.lsp:composite_not_nil: first: result ~S" s3)
	(format t "~%DEBUG:composition.lsp:composite_not_nil: second: join s2 [ ~S ] into s3 [ ~S ]" s2 s3)
	; join s3(that is s2(s1)) and s2
	(dolist (s2_element s2) 
		(setf add_element_allowed (not (is_composition_in_list s2_element s3)))
		; when s2_element denominator not in s3 denominators, s3.append(s2_element)
		(when add_element_allowed (nconc s2_element s3))
		(format t "~%DEBUG:composition.lsp:composite_not_nil: second: s2 element [ ~S ] (is in s3: ~S) " s2_element add_element_allowed)
	)
	(return-from composite_not_nil s3 )
)

(defun is_composition_in_list (comp l)
		( dolist (element l)
			(cond
				(; if both are lisp atom
					(and (is_atom (last comp)) (is_atom (last element)))
					(return-from is_composition_in_list (is_equal (last comp) (last element)))
				)
				(; if both are not lisp atom 
					(and (not (is_atom (last comp))) (not (is_atom (last element))))
					(return-from is_composition_in_list (equal (last comp) (last element)))
				)
				(; in other case
					T 
					(return-from is_composition_in_list NIL)
				)
			)
		)
)