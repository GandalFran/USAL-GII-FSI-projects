;
;	author: Héctor Sánchez San Blas & Francisco Pinto-Santos
;	date: 10/10/2019
;	file: composition.lsp

(defun composition (s1 s2) 
	(logging "debug" NIL t "DEBUG:composition.lsp:composition: [ ~S ] [ ~S ]" s1 s2)
	(prog (s1_editable s2_editable s2_element add_element s3 result) 
		(cond
			(; s1 and s2 are nill -> nil + nil = nil
				(and (eq s1 NIL) (eq s2 NIL))
				(logging "debug" NIL t "DEBUG:composition.lsp:composition: composition result NIL")
				(return-from composition NIL )
			)

			(; s1 is not nil and s2 is nil -> a1 + nil = s1
				(and (not (eq s1 NIL)) (eq s2 NIL) )
				(logging "debug" NIL t "DEBUG:composition.lsp:composition: composition result is s1 because s2 is NIL [ ~S ]" s1)
				(return-from composition s1 )
			)

			(; a1 is nil and s2 is not nil -> nil + s2 = s2
				(and (eq s1 NIL) (not (eq s2 NIL)) )
				(logging "debug" NIL t "DEBUG:composition.lsp:composition: composition result is s2 because s1 is NIL [ ~S ]" s2)
				(return-from composition s2 )
			)

			(; s1 and s2 are not nil 
				(and (not (eq s1 NIL)) (not (eq s2 NIL)) )
				; copy args to edit only editable elements
				(setf s1_editable (copy-tree s1))
				(setf s2_editable (copy-tree s2))

				; if s1 is a simple composition, create a list to contain it
				(when (and (eq 2 (length s1_editable)) (or (is_atom (first s1_editable)) (is_atom (first (last s2_editable))))) 
					(setf s1_editable (list s1_editable))
				)

				(logging "debug" NIL t "DEBUG:composition.lsp:composition: s1 and s2 are not NIL -> applying complex composition")
				
				; apply s2 sustitution over s1
				(logging "debug" "+" t "DEBUG:composition.lsp:composition: sustitution( s1 [ ~S ] s2 [ ~S ] )" s1 s2)
				(setf s3 (sustitution s1_editable s2_editable))
				(logging "debug" "-" t "DEBUG:composition.lsp:composition: sustitution( s1 [ ~S ] s2 [ ~S ] ) = [ ~S ]" s1 s2 s3)

				; put in s3 the s2 elements which denominator is not in s1 denominators
				(logging "debug" NIL t "DEBUG:composition.lsp:composition: adding s2 elements (which denominator is not in s1 denominators) to s3")

				(cond
					(; if s2_editable is a single sustitution instead a sustitution list
						(and (eq 2 (length s2_editable)) (or (is_atom (first s2_editable)) (is_atom (first (last s2_editable))) ) )
						(setf add_element (is_element_allowed s2_editable s1))
						(if add_element 
							(logging "debug" NIL t "DEBUG:composition.lsp:composition: adding s2 element [ ~S ] into s3" s2_editable)
						;else
							(logging "debug" NIL t "DEBUG:composition.lsp:composition: not adding s2 element [ ~S ] into s3" s2_editable)
						)
						(when add_element
							(setf s3 (append s3 (list s2_editable)))
						)
					)
					(; if s2_editable is a list of sustitutions
						T
						; body
						(dolist (s2_element s2_editable) 
							(setf add_element (is_element_allowed s2_element s1))
							(if add_element 
								(logging "debug" NIL t "DEBUG:composition.lsp:composition: adding s2 element into s3 [ ~S ] " s2_element)
							;else
								(logging "debug" NIL t "DEBUG:composition.lsp:composition: not adding s2 element into s3 [ ~S ] " s2_element)
							)
							(when add_element 
								(setf s3 (append s3 (list s2_element)))
							)
						)
					)
				)
				
				(logging "debug" NIL t "DEBUG:composition.lsp:composition: the resulting s3 is [ ~S ]" s3)
				(return-from composition s3)
			)
			
			(T NIL)
		)
		
	)
)

(defun is_element_allowed (sustitution sustitutions_list)
	(prog (sustitution_last sustitution_first sustitution_list_element_last sustitution_list_element_first sustitution_list_tmp)
		; get sustitution last element into sustitution_last
		(setf sustitution_last (first(last sustitution)))
		(setf sustitution_first (first sustitution))
		;NOTE: first(last(list)) because last return a list 

		;if if the sustitution_list is a single sustitution, create a list
		(if (and (eq 2 (length sustitutions_list)) (or (is_atom (first sustitutions_list)) (is_atom (first (last sustitutions_list))) ) )
			(setf sustitution_list_tmp (list sustitutions_list))
		;else
			(setf sustitution_list_tmp sustitutions_list)
		)

		; iterate through all elements in sustitutions_list
		( dolist (sustitution_list_element sustitution_list_tmp)
			; get last element from sustitution_list_element
			(setf sustitution_list_element_last (first(last sustitution_list_element)))
			(setf sustitution_list_element_first (first sustitution_list_element)) 
			; if the last element of the sustitution is in the sustitution_list element 
			;    return NIL
			(when (or (is_equal sustitution_last sustitution_list_element_last))
				(return-from is_element_allowed NIL)
			)
		)
		; if there is no coincidences return T
		(return-from is_element_allowed T)
	)
)