
(defun isAtom(var)
	(cond ((atom var) T)
		(((eq (first var) '?) and (eq (length var) 2) ) T)
		(T NIL)
	)