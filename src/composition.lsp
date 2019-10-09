
;; INPUT FORMAT 
;; ej: {x/y, f(g)/z}	( (x y) ((f (? g)) z) )
(defun composition (s1 s2) 
	(format t "~%       DEBUG:composition.lsp:composition: [ ~S ] [ ~S ]" s1 s2)
	(prog 
		(s2_element add_element s3 s4 result) 
		(cond
			(; s1 and s2 are nill -> nil + nil = nil
				(and (eq s1 NIL) (eq s2 NIL))
				(format t "~%       DEBUG:composition.lsp:composition: composition result NIL")
				(return-from composition NIL )
			)

			(; s1 is not nil and s2 is nil -> a1 + nil = s1
				(and (not (eq s1 NIL)) (eq s2 NIL) )
				(format t "~%       DEBUG:composition.lsp:composition: composition result is s1 because s2 is NIL [ ~S ]" s1)
				(return-from composition s1 )
			)

			(; a1 is nil and s2 is not nil -> nil + s2 = s2
				(and (eq s1 NIL) (not (eq s2 NIL)) )
				(format t "~%       DEBUG:composition.lsp:composition: composition result is s2 because s1 is NIL [ ~S ]" s2)
				(return-from composition s2 )
			)

			(; s1 and s2 are not nil 
				(and (not (eq s1 NIL)) (not (eq s2 NIL)) )
				(format t "~%       DEBUG:composition.lsp:composition: s1 and s2 are not NIL, so applying complex composition")
				(format t "~%       DEBUG:composition.lsp:composition: adding s2 elements (which denominator is not in s1 denominators) to s3")
				; put in s3 the s2 elements which denominator is not in s1 denominators
				(dolist (s2_element s2) 
					(setf add_element (not (is_composition_in_list s2_element s1)))
					(if add_element 
						(format t "~%       DEBUG:composition.lsp:composition: adding s2 element into s3 [ ~S ] " s2_element)
					;else
						(format t "~%       DEBUG:composition.lsp:composition: not adding s2 element into s3 [ ~S ] " s2_element)

					)
					(when add_element 
						(if (eq s3 NIL) 
							(setf s3 (list (append s3 s2_element)))
						;else
							(setf s3 (append s3 (list s2_element)))
						)
					)
				)
				(format t "~%       DEBUG:composition.lsp:composition: the resulting s3 is [ ~S ]" s3)
				; apply s2 sustitution over s1
				(format t "~%       DEBUG:composition.lsp:composition: applying s2 sustitution on s1")
				(setf s4 (multiple_sustitution s1 s2))
				(format t "~%       DEBUG:composition.lsp:composition: s2 sustitution on s1 result [ ~S ]" s3)
				(format t "~%       DEBUG:composition.lsp:composition: joining s3 and s4 into result")
 				(setf result (append s3 s4))
				(format t "~%       DEBUG:composition.lsp:composition: result [ ~S ]" result)
				(return-from composition result)
			)
			
			(T NIL)
		)
		
	)
)

(defun is_composition_in_list (sustitution sustitutions_list)
	(prog (sustitution_last sustitution_list_element_last)
		; get sustitution last element into sustitution_last
		(setf sustitution_last (last sustitution)) 
		; iterate through all elements in sustitutions_list
		( dolist (sustitution_list_element sustitutions_list)
			; get last element from sustitution_list_element
			(setf sustitution_list_element_last (last sustitution_list_element))
			; if the last element of the sustituion is in the sustitution_list element 
			;    return true
			(format t "~%sustition_last [ ~S ] sustitution_list_element_last [ ~S ]" sustitution_last sustitution_list_element_last)
			(when (is_equal sustitution_last sustitution_list_element_last)
				(return-from is_composition_in_list T)
			)
		)
		; if there is no coincidences return NIL
		(return-from is_composition_in_list NIL)
	)
)