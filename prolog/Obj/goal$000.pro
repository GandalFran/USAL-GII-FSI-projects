/*****************************************************************************

		Copyright (c) aLmazon.Inc

 Project:  ALMAZON
 FileName: ALMAZON.PRO
 Purpose: No description
 Written by: Hector Sanchez San Blas y Francisco Pinto Santos
 Comments:
******************************************************************************/

include "almazon.inc"


domains
	
	/*reglas de produccion*/
	identificador=integer
	diaentrada=integer
	diasalida=integer
	box=b(identificador,diaentrada,diasalida)
	lbox=box*
	
	actual=integer
	limite=integer
	pila=p(lbox,actual,limite)
	
	almacen=alm(pila,pila,pila,pila,pila)

	/*backtracking*/
	est=estado(lbox, almacen)
	estp=estadopila(lbox, pila)
	lista=est*

predicates
  	
	/*reglas de produccion*/
  	nondeterm seleccionapila(est,est)
  	nondeterm apila(estp, estp)
  	nondeterm desapila(estp, estp)
	mayordiasalida(box,box)
	
	/*backtracking*/
  	nondeterm miembro(est,lista)
  	nondeterm backtrack(lista,est,limite,limite) /* Lista de estados, Estado final, Profundidad actual, Profundiad maxima */
  	escribe(lista)
  	nondeterm solution(integer,lbox,almacen)

clauses

	/*reglas de produccion*/
	
	/*seleccionar una de las pilas del almacen*/
	seleccionapila(estado(LBoxi,alm(Pi,P2,P3,P4,P5)),estado(LBoxf,alm(Pf,P2,P3,P4,P5))):-
		apila(estadopila(LBoxi,Pi),estadopila(LBoxf,Pf)).
		
	seleccionapila(estado(LBoxi,alm(P1,Pi,P3,P4,P5)),estado(LBoxf,alm(P1,Pf,P3,P4,P5))):-
		apila(estadopila(LBoxi,Pi),estadopila(LBoxf,Pf)).
		
	seleccionapila(estado(LBoxi,alm(P1,P2,Pi,P4,P5)),estado(LBoxf,alm(P1,P2,Pf,P4,P5))):-
		apila(estadopila(LBoxi,Pi),estadopila(LBoxf,Pf)).
		
	seleccionapila(estado(LBoxi,alm(P1,P2,P3,Pi,P5)),estado(LBoxf,alm(P1,P2,P3,Pf,P5))):-
		apila(estadopila(LBoxi,Pi),estadopila(LBoxf,Pf)).
		
	seleccionapila(estado(LBoxi,alm(P1,P2,P3,P4,Pi)),estado(LBoxf,alm(P1,P2,P3,P4,Pf))):-
		apila(estadopila(LBoxi,Pi),estadopila(LBoxf,Pf)).
		/*
	seleccionapila(estado(LBoxi,alm(Pi,P2,P3,P4,P5)),estado(LBoxf,alm(Pf,P2,P3,P4,P5))):-
		desapila(estadopila(LBoxi,Pi),estadopila(LBoxf,Pf)).
		
	seleccionapila(estado(LBoxi,alm(P1,Pi,P3,P4,P5)),estado(LBoxf,alm(P1,Pf,P3,P4,P5))):-
		desapila(estadopila(LBoxi,Pi),estadopila(LBoxf,Pf)).
		
	seleccionapila(estado(LBoxi,alm(P1,P2,Pi,P4,P5)),estado(LBoxf,alm(P1,P2,Pf,P4,P5))):-
		desapila(estadopila(LBoxi,Pi),estadopila(LBoxf,Pf)).
		
	seleccionapila(estado(LBoxi,alm(P1,P2,P3,Pi,P5)),estado(LBoxf,alm(P1,P2,P3,Pf,P5))):-
		desapila(estadopila(LBoxi,Pi),estadopila(LBoxf,Pf)).
		
	seleccionapila(estado(LBoxi,alm(P1,P2,P3,P4,Pi)),estado(LBoxf,alm(P1,P2,P3,P4,Pf))):-
		desapila(estadopila(LBoxi,Pi),estadopila(LBoxf,Pf)).
		*/
	/*si pila vacia => meter caja*/
	apila(estadopila(LPRODi, p([],ACTUALi,LIMITE)), estadopila(LPRODf,p(LBOXf,ACTUALf,LIMITE))):-
		ACTUALi=0,
		ACTUALf=ACTUALi+1,
		LPRODi=[Box|LPRODiTail],
		LPRODf=LPRODiTail,
		LBOXf=[Box].
	
	/*si pila no vacia Y pila no llena Y pop(pila).diasalida>caja.fechasalida => meter caja*/
	apila(estadopila(LPRODi, p(LBOXi,ACTUALi,LIMITE)), estadopila(LPRODf,p(LBOXf,ACTUALf,LIMITE))):-
		ACTUALi <> 0,
		ACTUALi<LIMITE,
		LBOXi=[TopBox|_],
		LPRODi=[Box|LPRODiTail],
		mayordiasalida(Box,TopBox),
		ACTUALf=ACTUALi+1,
		LPRODf=LPRODiTail,
		LBOXf=[Box|LBOXi].
	
	/*si pila no vacia => sacar caja*/
	desapila(estadopila(LPRODi, p(LBOXi,ACTUALi,LIMITE)), estadopila(LPRODf,p(LBOXf,ACTUALf,LIMITE))):-
		ACTUALi <> 0,
		LBOXi=[TopBox|LOBXiTail],
		ACTUALf=ACTUALi-1,
		LPRODf=[TopBox|LPRODi],
		LBOXf=LOBXiTail.
		
	/*para verificar que el dia de salida de la caja actual es menor que el de la priemra caja de la pila*/
	mayordiasalida(b(_,_,DSBOX),b(_,_,DSTOPBOX)):-
		DSTOPBOX > DSBOX.
		
	/* backtrack */
	
        /*Estados repetidos */
        miembro(E,[E|_]).
        miembro(E,[_|T]):-
        	miembro(E,T).
	        	
        /*Resolucion de algoritmo */
        backtrack(Lista,Destino,_,_):-
        	Lista=[H|_],
        	Destino=H,
        	escribe(Lista).
        
        backtrack(Lista,Destino,Lim_ant,Limite):-
        	write(Limite," backtrack \n"),
        	Lista=[H|T],
        	not(miembro(H,T)),
        	seleccionapila(H,Hfinal),
        	Nlista=[Hfinal|Lista],
        	Nue_Lim=Lim_ant+1,
        	Nue_Lim<=Limite,
        	backtrack(Nlista,Destino,Nue_Lim,Limite).
        	
        /*Escritura de la lista */
        escribe([]).
        escribe([H|T]):-
        	escribe(T),
        	write(H,'\n').
        	
        solution(LIM, ListaProd, Almacen):-
        	backtrack([estado(ListaProd,Almacen)],estado([],_),1,LIM).
        	
        solution(LIM, ListaProd, Almacen):-
        	write(LIM,'\n'),
        	NLIM=LIM+1,
        	solution(NLIM, ListaProd, Almacen).
		
goal

     solution(1
     	,[b(9,1,17),b(10,1,17),b(11,1,17),b(12,1,17),b(13,1,17),b(14,1,17),b(15,1,17),
	  b(16,1,17),b(17,1,17),b(18,1,17),b(19,1,17),b(20,1,17),b(3,1,18),b(4,1,18),
	  b(5,1,18),b(6,1,18),b(7,1,18),b(8,1,18),b(1,1,19),b(2,1,19)
	], alm( p([],0,4), p([],0,4), p([],0,4), p([],0,4), p([],0,4))
     ).
     
/*
	POSSIBLE SOLUTION
	p([b(12,1,17),b(11,1,17),b(10,1,17),b(9,1,17)],4,4)
	p([b(16,1,17),b(15,1,17),b(14,1,17),b(13,1,17)],4,4)
	p([b(10,1,17),b(19,1,17),b(18,1,17),b(17,1,17)],4,4)
	p([b(6,1,18),b(5,1,18),b(4,1,18),b(3,1,18)],4,4
	p([b(8,1,18),b(7,1,18),b(2,1,19),b(1,1,19)],4,4)
*/