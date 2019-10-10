;; INPUT FORMAT 
;; ej: {x/y, f(g)/z}	( (x y) ((f (? g)) z) )
(defun composition (s1 s2) 
	(when (string= loglevel "debug") (format t "~%       DEBUG:composition.lsp:composition: [ ~S ] [ ~S ]" s1 s2))
	(prog (s1_editable s2_editable s2_element add_element s3 result) 
		(cond
			(; s1 and s2 are nill -> nil + nil = nil
				(and (eq s1 NIL) (eq s2 NIL))
				(when (string= loglevel "debug") (format t "~%       DEBUG:composition.lsp:composition: composition result NIL"))
				(return-from composition NIL )
			)

			(; s1 is not nil and s2 is nil -> a1 + nil = s1
				(and (not (eq s1 NIL)) (eq s2 NIL) )
				(when (string= loglevel "debug") (format t "~%       DEBUG:composition.lsp:composition: composition result is s1 because s2 is NIL [ ~S ]" s1))
				(return-from composition s1 )
			)

			(; a1 is nil and s2 is not nil -> nil + s2 = s2
				(and (eq s1 NIL) (not (eq s2 NIL)) )
				(when (string= loglevel "debug") (format t "~%       DEBUG:composition.lsp:composition: composition result is s2 because s1 is NIL [ ~S ]" s2))
				(return-from composition s2 )
			)

			(; s1 and s2 are not nil 
				(and (not (eq s1 NIL)) (not (eq s2 NIL)) )
				; copy args to edit only editable elements
				(setf s1_editable (copy-tree s1))
				(setf s2_editable (copy-tree s2))
				(when (string= loglevel "debug") (format t "~%       DEBUG:composition.lsp:composition: s1 and s2 are not NIL, so applying complex composition"))
				
				; apply s2 sustitution over s1
				(when (string= loglevel "debug") (format t "~%       DEBUG:composition.lsp:composition: applying s2 sustitution on s1"))
				(setf s3 (multiple_sustitution s1_editable s2_editable))
				(when (string= loglevel "debug") (format t "~%       DEBUG:composition.lsp:composition: s2 sustitution on s1 result [ ~S ]" s3))
				(when (string= loglevel "debug") (format t "~%       DEBUG:composition.lsp:composition: joining s3 and s3 into result"))

				; put in s3 the s2 elements which denominator is not in s1 denominators
				(when (string= loglevel "debug") (format t "~%       DEBUG:composition.lsp:composition: adding s2 elements (which denominator is not in s1 denominators) to s3"))
				(dolist (s2_element s2_editable) 
					(setf add_element (is_element_allowed s2_element s1))
					(if add_element 
						(when (string= loglevel "debug") (format t "~%       DEBUG:composition.lsp:composition: adding s2 element into s3 [ ~S ] " s2_element))
					;else
						(when (string= loglevel "debug") (format t "~%       DEBUG:composition.lsp:composition: not adding s2 element into s3 [ ~S ] " s2_element))
					)
					(when add_element 
						(setf s3 (append s3 (list s2_element)))
					)
				)
				(when (string= loglevel "debug") (format t "~%       DEBUG:composition.lsp:composition: the resulting s3 is [ ~S ]" s3))
				(return-from composition s3)
			)
			
			(T NIL)
		)
		
	)
)

(defun is_element_allowed (sustitution sustitutions_list)
	(prog (sustitution_last sustitution_first sustitution_list_element_last sustitution_list_element_first)
		; get sustitution last element into sustitution_last
		(setf sustitution_last (first(last sustitution)))
		(setf sustitution_first (first sustitution))
			;NOTE: first(last(list)) because last return a list 
		; iterate through all elements in sustitutions_list
		( dolist (sustitution_list_element sustitutions_list)
			; get last element from sustitution_list_element
			(setf sustitution_list_element_last (first(last sustitution_list_element)))
			(setf sustitution_list_element_first (first sustitution_list_element)) 
			; if the last element of the sustituion is in the sustitution_list element 
			;    return NIL
			(when (string= loglevel "debug") (format t "~% ( ~S ~S )  ( ~S ~S ) " sustitution_first sustitution_last sustitution_list_element_first sustitution_list_element_last))
			(when (or (is_equal sustitution_last sustitution_list_element_first))
				(return-from is_element_allowed NIL)
			)
		)
		; if there is no coincidences return T
		(return-from is_element_allowed T)
	)
)