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
		; is a NIL -> NIL
		( (eq NIL a) NIL)
		; is a real atom -> NIL 
		( (atom a) NIL)
		; is a list like this (? x): list[0]=? and len(list) = 2 
		( ( and (eq (first a) '?) (eq (length a) 2) ) T)
		; in other case NIL
		(T NIL)
	)
)

(defun is_equal (a1 a2)
	(cond		
		; a1 and a2 can be lisp atoms
		; if a1 and a2 are atoms (lisp atoms)
		( (and (atom a1) (atom a2)) (eq a1 a2) )
		; if s1 is atom and s2 not or s2 is atom and s1 not (lisp atoms)
		( (or (and (atom a1) (not (atom a2))) (and (not (atom a1)) (atom a2)))  NIL)
		; a1 or a2 can't be lisp atoms
		; if s1 and s2 are var
		( (and (is_var a1) (is_var a2)) (equal (last a1) (last a2)))
		; if s1 is var and s2 not or s2 is var and s1 not
		( (or (and (is_var a1) (not (is_var a2))) (and (not (is_var a1)) (is_var a2)))  NIL)
		; if s1 is not var and s2 is not var
		( (and (not(is_var a1)) (not(is_var a2)))  (equal a1 a2))
		; in other case NIL
		(T NIL)
	)
)