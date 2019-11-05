
(setq numberOfTabs 0)

(defun logging (level incrementTab &rest args) 

	; do decrement
	(when (string= incrementTab "-") 
		(setq numberOfTabs (1- numberOfTabs))
	)

	; print data
	(when (string= loglevel level)
		; print \n and tabs
		(format t "~%")
		(dotimes (n numberOfTabs) (format t "    "))
		; print data
		(apply #'format args)
	)

	; do increment or decrement
	(when (string= incrementTab "+") 
		(setq numberOfTabs (1+ numberOfTabs))
	)
)