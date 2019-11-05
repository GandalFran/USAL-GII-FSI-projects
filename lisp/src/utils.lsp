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

(defun is_var(a)
	(cond
		; if is not list is not var
		((atom a) NIL)
		; if has ? and lenght 2 is var
		(( and (eq (first a) '?) (eq (length a) 2) ) T)
		(T NIL)
	)
)

(defun is_equal (a1 a2)
	(cond
		; if a1 and a2 are nil
		( (and (eq NIL a1) (eq NIL a2)) T )
		; if a1 and a2 are atoms (lisp atoms)
		( (and (atom a1) (atom a2)) (eq a1 a2) )
		; if a1 and a2 are list
		( (and (not(atom a1)) (not(atom a2)))  (equal a1 a2))
		; in other case NIL
		(T NIL)
	)
)