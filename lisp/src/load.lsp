;
;	author: Héctor Sánchez San Blas & Francisco Pinto-Santos
;	date: 10/10/2019
;	file: load.lsp

; ALL LOGLVELES IN lowercase
; allowed loglevels: debug, none
(setf loglevel "none")

(load "log.lsp")
(load "utils.lsp")
(load "sustitution.lsp")
(load "composition.lsp")
(load "unification.lsp")