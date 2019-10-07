

(defun same_atom (a1 a2)

	(cond		
		; if a1 or a2 is not atom return NIL
		( (or (not(is_atom(a1))) (not(is_atom(a2)))  ) NIL ) 
		; check if s1 is list or s2 is list
		( () T)
		; in other case NIL
		(T NIL)
	)
)

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