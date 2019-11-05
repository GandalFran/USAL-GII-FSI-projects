;
;	author: Héctor Sánchez San Blas & Francisco Pinto-Santos
;	date: 10/10/2019
;	file: log.lsp

(setq numberOfTabs 1)

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