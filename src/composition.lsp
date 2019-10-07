+ composicion
	nada + algo = algo
	nada + nada = nada
	algo (S1) + algo (S2):
		+ aplicar S2 sobre los numeradores de S1 -> se va metiendo en la composicion final todo lo que se cambie
		+ coger todos los denominadores de S2 que no esten en S1 y añadirlo a la composicion final
+ prueba composicion

(defun composition (s1 s2) 
	
	(prog (x y) 
		
		(cond
			;; s1 and s2 are atoms
			(( and (is_atom s1) (is_atom s2) )
				;; if s1 == s2 return s1 else return list(s1, s2)
				( if (eq_atom s1 s2) (return s1)
					(return (list s1 s2))
				)					
			)

			;; s1 is list and s2 is atom
			( ( and (not (is_atom s1)) (is_atom s2) ) 
				;; if s2 in s1 return s2 else return s2.add(s1)
				(if (not (eq nil (find s2 s1))) (return )

				)
			)
			
			;; s1 is atom and s2 is list
			( ( and (is_atom s1) (not (is_atom s2)) ) 
				(...)
			)

			;; s1 is list and s2 is list
			(( and (not (is_atom s1)) (not (is_atom s2)) ) 
				(...)
			)
			(T NIL)
		)
		
	)
	
)