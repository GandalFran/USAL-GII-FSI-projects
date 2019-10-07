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

(defun composite_not_nil (s1 s2)
	(prog (s3, ignore) 
		(
			; apply s2 sustitution over s1
			(setf s3 (sustitution s1 s2))
			; join s3(that is s2(s1)) and s2		
			(dolist (s2_element s2 ignore) 
				( when (s2_element.denominador not in s3.denominadores) (s3.append(s2_element)) )
			)
			(return s3)
		)

	)
)
