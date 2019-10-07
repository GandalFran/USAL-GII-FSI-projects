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

;; PARA QUE FUNCIONE -> cada elemento de una composicion es una lista, en esta lista hay 2 listas (que cambiar, por que se camia), de tal forma que queda
;; ej: {x/y, f(g)/z}	( ((x) (y)) ((f g) (z)) )
;; tarea -> cambiar esto para que x e y no tengan que ser lista
(defun composite_not_nil (s1 s2)
	(prog (s3, ignore) 
		(
			; apply s2 sustitution over s1
			(setf s3 (sustitution s1 s2))
			; join s3(that is s2(s1)) and s2
			(dolist (s2_element s2 ignore) 
				; when s2_element denominator not in s3 denominators, s3.append(s2_element)
				( when (not (is_composition_in_list s2_element s3)) (setf s3 s2_element 's3) )
			)
			(return s3)
		)

	)
)

(defun is_composition_in_list (comp l)
	(prog (ignore, tmp_comp, tmp_element)
		( dolist (element l ignore)
			(setf tmp_comp (last comp))
			(setf tmp_element (last element))
			(cond
				(; if both are lisp atom
					(and (atom tmp_comp) (atom tmp_element))
					(when (eq tmp_comp tmp_element) (return T))
				)
				(; if both are not lisp atom 
					(and (not (atom tmp_comp)) (not (atom tmp_element)))
					(when (equal tmp_comp tmp_element) (return T))
				)
			)
		)
		(return NIL)
	)
)