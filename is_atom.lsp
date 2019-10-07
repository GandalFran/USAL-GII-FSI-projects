(defun is_atom(var)
	(cond
		; is a real atom -> T 
		( (atom var) T ) 
		; is a list like this (? x): list[0]=? and len(list) = 2 
		( ( and (eq (first var) '?) (eq (length var) 2) ) T)
		; in other case NIL
		(T NIL)
	)
)