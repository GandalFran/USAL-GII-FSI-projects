;
;   author: Héctor Sánchez San Blas & Francisco Pinto-Santos
;   date: 10/10/2019
;   file: sustitution.lsp

(defun sustitution (list_to_change changes)
    (logging "debug" NIL t "DEBUG:sustitution.lsp:sustitution: list_to_change [ ~S ]  changes [ ~S ]" list_to_change changes)
    (prog (list_with_changes)
        (setf list_with_changes (copy-tree list_to_change))
        (cond 
            (; no change
                (is_atom changes)
                (logging "debug" NIL t "DEBUG:sustitution.lsp:sustitution: no changes recived [ ~S ] -> return list_to_change [ ~S ]" changes list_with_changes)
                (return-from sustitution list_with_changes)
            )

            (; single change
                (is_atom (first changes))
                ;; TODO aqui puede haber el mismo problema que el marcado en compoiscion
                (logging "debug" "+" t "DEBUG:sustitution.lsp:sustitution: single change recived single_sustitution( list_to_change [ ~S ] change [ ~S ] )" list_to_change changes)
                (setf list_with_changes (single_sustitution list_with_changes changes))
                (logging "debug" "-" t "DEBUG:sustitution.lsp:sustitution: single change recived single_sustitution( list_to_change [ ~S ] change [ ~S ] ) = [ ~S ]" list_to_change changes list_with_changes)
                (return-from sustitution list_with_changes)
            )
            (; multiple changes
                T
                (logging "debug" NIL t "DEBUG:sustitution.lsp:sustitution: multiple change recived")
                (dolist (change changes) 
                    (logging "debug" "+" t "DEBUG:sustitution.lsp:sustitution: applying change single_sustitution( list_to_change [ ~S ] change [ ~S ] )" list_with_changes change)
                    (setf list_with_changes (single_sustitution list_with_changes change))
                    (logging "debug" "-" t "DEBUG:sustitution.lsp:sustitution: applying change single_sustitution( list_to_change [ ~S ] change [ ~S ] ) = [ ~S ]" list_with_changes change list_with_changes)
                )
                (return-from sustitution list_with_changes)
            )
        )
    )
)

(defun single_sustitution (list_to_change change)
    (logging "debug" NIL t "DEBUG:sustitution.lsp:single_sustitution: list_to_change [ ~S ]  change [ ~S ]" list_to_change change )
    (prog (list_to_change_editable old new element element_pos new_element)
        (setf list_to_change_editable (copy-tree list_to_change))
        (cond
            (; cant apply change
                (or (is_atom change) (eq 1 (length change)) )
                (logging "debug" NIL t "DEBUG:sustitution.lsp:single_sustitution: change not applicable [ ~S ] -> reutrn list_to_change [ ~S ]" change list_to_change)
                (return-from single_sustitution list_to_change)
            )

            (; the change is applicable
                T
                ; create list of list_toChange if is an atom
                (when (is_atom list_to_change_editable) 
                    (setf list_to_change_editable (list list_to_change_editable) )
                )

                ; get elements from chagne
                (setf new (first change))
                (setf old (first(last change)))

                (logging "debug" NIL t "DEBUG:sustitution.lsp:single_sustitution: change old [ ~S ] for new [ ~S ]" old new)
                (logging "debug" NIL t "DEBUG:sustitution.lsp:single_sustitution: iterating through list [ ~S ] to apply changes" list_to_change_editable)
                
                ; iterate through changes list to apply changes
                (dolist (element list_to_change_editable)
                    ; get element position
                    (setf element_pos (position element list_to_change_editable))

                    (cond
                        ( (is_atom element) ; the element is a var or a constant
                            (logging "debug" NIL t "DEBUG:sustitution.lsp:single_sustitution: the element ~S is atom [ ~S ] in list [ ~S ]" element_pos element list_to_change_editable) 
                            ; if the element is equal to old, make a replacement
                            (when (is_equal element old)
                                ; replace old element in list for new by position
                                (setf (nth element_pos list_to_change_editable) new)      
                            )
                        )

                        ( T ; the element is a list and not a var or constant
                            (logging "debug" NIL t "DEBUG:sustitution.lsp:single_sustitution: the element ~S is list [ ~S ] in list [ ~S ]" element_pos element list_to_change_editable)
                            ; make a recursive call to substitution to apply the change to element list
                            (logging "debug" "+" t "DEBUG:sustitution.lsp:single_sustitution: recursive call (sustitution [ ~S ] [ ~S ])"  element change)
                            (setf new_element (sustitution element change))
                            ; make the replacement
                            (setf (nth element_pos list_to_change_editable) new_element)  
                            (logging "debug" "-" t "DEBUG:sustitution.lsp:single_sustitution: return from recursive call (sustitution [ ~S ] [ ~S ])"  element change) 
                        )
                    ) 
                )

                (return-from single_sustitution list_to_change_editable)
            )
        )
    )
)