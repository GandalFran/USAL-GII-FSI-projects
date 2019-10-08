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
;; ej: {x/y, f(g)/z}	( (x y) ((f g) z) )
(defun composite_not_nil (s1 s2)	
	; apply s2 sustitution over s1
	(setf s3 (sustitution s1 s2))
	(format t "~%INFO:composition.lsp:composite_not_nil: sustitution( ~S ~S ) = ~S" s1 s2 s3)
	; join s3(that is s2(s1)) and s2
	(dolist (s2_element s2) 
		(format t "~%INFO:composition.lsp ~S:composite_not_nil: loop s2_element ~S | ~S " s2_element s3)
		(format t "~%INFO:composition.lsp:composite_not_nil: ~S } ~S" (last s2_element) (last s3))
		; when s2_element denominator not in s3 denominators, s3.append(s2_element)
		( when (not (is_composition_in_list s2_element s3)) (nconc s2_element s3))
	)

	(return-from composite_not_nil s3 )
)

(defun is_composition_in_list (comp l)
		( dolist (element l)
			(cond
				(; if both are lisp atom
					(and (atom (last comp)) (atom (last element)))
					(when (eq (last comp) (last element)) (return-from is_composition_in_list  T))
				)
				(; if both are not lisp atom 
					(and (not (atom (last comp))) (not (atom (last element))))
					(when (equal (last comp) (last element)) (return-from is_composition_in_list  T))
				)
				(; in other case
					(T (return-from is_composition_in_list NIL))
				)
			)
		)
)