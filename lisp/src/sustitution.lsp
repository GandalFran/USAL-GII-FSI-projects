(defun sustitution (list_to_change changes)
    (when (string= loglevel "debug") (format t "~%       DEBUG:sustitution.lsp:sustitution: list_to_change [ ~S ]  changes [ ~S ]" list_to_change changes)) 
    (prog (list_with_changes)
        (setf list_with_changes (copy-tree list_to_change))
        (cond 
            (; no change
                (is_atom changes)
                (when (string= loglevel "debug") (format t "~%       DEBUG:sustitution.lsp:sustitution: no changes recived [ ~S ] -> return list_to_change [ ~S ]" changes list_with_changes))
                (return-from sustitution list_with_changes)
            )

            (; single change
                (is_atom (first changes))
                (when (string= loglevel "debug") (format t "~%       DEBUG:sustitution.lsp:sustitution: single change recived single_sustitution( list_to_change [ ~S ] change [ ~S ] )" list_to_change changes))
                (setf list_with_changes (single_sustitution list_with_changes changes))
                (when (string= loglevel "debug") (format t "~%       DEBUG:sustitution.lsp:sustitution: single change recived single_sustitution( list_to_change [ ~S ] change [ ~S ] ) = [ ~S ]" list_to_change changes list_with_changes))
                (return-from sustitution list_with_changes)
            )
            (; multiple changes
                T
                (when (string= loglevel "debug") (format t "~%       DEBUG:sustitution.lsp:sustitution: multiple change recived"))
                (dolist (change changes) 
                    (when (string= loglevel "debug") (format t "~%       DEBUG:sustitution.lsp:sustitution: applying change single_sustitution( list_to_change [ ~S ] change [ ~S ] )" list_with_changes change))
                    (setf list_with_changes (single_sustitution list_with_changes change))
                    (when (string= loglevel "debug") (format t "~%       DEBUG:sustitution.lsp:sustitution: applying change single_sustitution( list_to_change [ ~S ] change [ ~S ] ) = [ ~S ]" list_with_changes change list_with_changes))
                )
                (return-from sustitution list_with_changes)
            )
        )
    )
)

(defun single_sustitution (list_to_change change)
    (when (string= loglevel "debug") (format t "~%       DEBUG:sustitution.lsp:single_sustitution: list_to_change [ ~S ]  change [ ~S ]" list_to_change change)) 
    (prog (list_to_change_editable what_to_change what_to_be_changed result)
        (setf list_to_change_editable (copy-tree list_to_change))
        (cond
            (; cant apply change
                (or (is_atom change) (eq 1 (length change)) )
                (when (string= loglevel "debug") (format t "~%       DEBUG:sustitution.lsp:single_sustitution: change not applicable [ ~S ] -> reutrn list_to_change [ ~S ]" change list_to_change)) 
                (return-from single_sustitution list_to_change)
            )

            (; the change is applicable
                T
                ; create list of list_toChange if is an atom
                (when (is_atom list_to_change_editable) 
                    (setf list_to_change_editable (list list_to_change_editable) )
                )

                ; get elements from chagne
                (setf what_to_change (first change))
                (setf for_what_to_be_changed (first(last change)))

                ; apply change
                (setf result (subst  what_to_change for_what_to_be_changed list_to_change_editable)) 

                (return-from single_sustitution result)
            )
        )
    )
)