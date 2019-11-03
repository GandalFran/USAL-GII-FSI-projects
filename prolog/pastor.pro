/*****************************************************************************

		Copyright (c) My Company

 Project:  PASTOR
 FileName: PASTOR.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "pastor.inc"

domains
	id=symbol
	diaentrada=symbol
	diasalida=symbol
	box=b(id,diaentrada,diasalida)
	
	lbox=*box
	actual=symbol
	limite=4
	pila=p(lbox,actual,limite)
	
	almacen=alm(pila,pila,pila,pila,pila)

predicates

  	apila(box,pila)
  	inseguro(box, pila)
  	
  	miembro(est,lista)
  	
  	resuelve(lista,est,limite,limite) /* Lista de estados, Estado destino */
  	escribe(lista)
  	mejorsol(integer)

clauses

        opuesto(o,e).
        opuesto(e,o).
        
        /* Pastor con Lobo*/
        mueve(estado(I,I,O,B),estado(F,F,O,B)):-
        	opuesto(I,F),
        	not(inseguro(estado(F,F,O,B))).
        
        	
        /* Lobo con oveja, pastor en el lado opuesto */
        inseguro(estado(P,LO,LO,_)):-
        	opuesto(P,LO).

	/* Oveja con berza, pastor en el lado opuesto */
        inseguro(box, pila):-
        	.
        	
        /*Estados repetidos */
        miembro(E,[E|_]).
        miembro(E,[_|T]):-
        	miembro(E,T).
        	
        /*Resolucion de algoritmo */
        resuelve(Lista,Destino,_,_):-
        	Lista=[H|T],
        	Destino=H,
        	escribe(Lista).
        
        resuelve(Lista,Destino,Lim_ant,Limite):-
        	Lista=[H|T],
        	not(miembro(H,T)),
        	mueve(H,Hfinal),
        	Nlista=[Hfinal|Lista],
        	Nue_Lim=Lim_ant+1,
        	Nue_Lim<=Limite,
        	resuelve(Nlista,Destino,Nue_Lim,Limite).
        	
        /*Escritura de la lista */
        escribe([]).
        escribe([H|T]):-
        	escribe(T),
        	write(H,'\n').
        	
        mejorsol(Lim_ini):-
        	resuelve([estado(e,e,e,e)],estado(o,o,o,o),1,Lim_ini).
        	
        mejorsol(Lim_ini):-
        	Nue_lim=Lim_ini+1,
        	mejorsol(Nue_lim).

goal

	/*resuelve([estado(e,e,e,e)],estado(o,o,o,o),1,8).*/
	mejorsol(1).
  
  