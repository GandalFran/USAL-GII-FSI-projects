
(defun multiple_sustitution (listaACambiar listaCambios)
    (dolist (cambio listaCambios) 
        (format t "~%       DEBUG:sustitution.lsp:multiple_sustitution: applying sustitution [ ~S ] to [ ~S ]" cambio listaACambiar) 
        (sustitution listaACambiar cambio)
        (format t "~%       DEBUG:sustitution.lsp:multiple_sustitution: sustitution [ ~S ] result [ ~S ]" cambio listaACambiar)
    )
)

(defun sustitution (listaACambiar cambio)
    (cond
        ((is_atom listaACambiar)
            (return-from sustitution NIL)
        )
        ( (is_atom listaACambiar)
            (return-from sustitution NIL)
        )
        (T
            (dolist (var listaACambiar)
                (setf tempList (list var))
                (when (listp var)
                    (apply (var cambio))
                )
                (when (equal tempList (rest cambio))
                    (setf tempVar (get_postition_in_list var listaACambiar))
                    (setf (nth tempVar listaACambiar) (first cambio))
                )
            )
            (return-from sustitution listaACambiar)
        )
    )
)