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
  	
/*REGLAS DE PRODUCCION*/
  	/*MOVERSE ENTRE DOS ESTADOS*/
	muevecaja(est,est)
			
  	/*METER CAJA A PILA*/
	colocaenpila(box,almacen,almacen)
  	coloca(box,pila,pila)
  					
  	/*VACIAR PILA*/
	vaciapila(lbox,lbox,almacen,almacen)
  	vacia(pila,pila,lbox)
	
	/*AUXILIARES*/
  	append(lbox,lbox,lbox)
	mayordiasalida(box,box)

/*SISTEMA DE CONTROL*/
  	backtrack(lista,est,limite,limite) /* Lista de estados, Estado final, Profundidad actual, Profundiad maxima */
  	solution(integer,lbox,almacen)
  	miembro(est,lista)
  	
/*IMPRIMIR POR PANTALLA*/
	imprimepila(pila)
	imprimeestado(est)
	imprimealmacen(almacen)
  	imprimelistaestados(lista,integer)

clauses

/*REGLAS DE PRODUCCION*/
	
	/*seleccionar caja para meter en pila*/
	muevecaja(estado(LBoxi,ALMACENi),estado(LBoxiTail,ALMACENf)):-
		LBoxi=[BOX|LBoxiTail],
		colocaenpila(BOX,ALMACENi,ALMACENf).
	
	/*
	vaciar una pila y poner su contenido al final de la lista de prodcuccion.
	con esto, podremos poner los paquetes con mas fecha despues de los de mas fecha
	*/
	muevecaja(estado(LProdi,ALMACENi),estado(LProdf,ALMACENf)):-
		vaciapila(LProdi,LProdf,ALMACENi,ALMACENf).
	
	/*seleccionar pila para meter caja*/
	colocaenpila(BOX,alm(Pi,P2,P3,P4,P5),alm(Pf,P2,P3,P4,P5)):-
		coloca(BOX,Pi,Pf).
		
	colocaenpila(BOX,alm(P1,Pi,P3,P4,P5),alm(P1,Pf,P3,P4,P5)):-
		coloca(BOX,Pi,Pf).
		
	colocaenpila(BOX,alm(P1,P2,Pi,P4,P5),alm(P1,P2,Pf,P4,P5)):-
		coloca(BOX,Pi,Pf).
		
	colocaenpila(BOX,alm(P1,P2,P3,Pi,P5),alm(P1,P2,P3,Pf,P5)):-
		coloca(BOX,Pi,Pf).
		
	colocaenpila(BOX,alm(P1,P2,P3,P4,Pi),alm(P1,P2,P3,P4,Pf)):-
		coloca(BOX,Pi,Pf).
		
	/*seleccionar pila para vaciar y meter las cajas en lista produccion*/
	vaciapila(LProdi,LProdf,alm(Pi,P2,P3,P4,P5),alm(Pf,P2,P3,P4,P5)) :-	
		vacia(Pi,Pf,LPILA),
		append(LProdi,LPILA,LProdf).	
		
	vaciapila(LProdi,LProdf,alm(P1,Pi,P3,P4,P5),alm(P1,Pf,P3,P4,P5)) :-	
		vacia(Pi,Pf,LPILA),
		append(LProdi,LPILA,LProdf).	
		
	vaciapila(LProdi,LProdf,alm(P1,P2,Pi,P4,P5),alm(P1,P2,Pf,P4,P5)) :-	
		vacia(Pi,Pf,LPILA),
		append(LProdi,LPILA,LProdf).	
		
	vaciapila(LProdi,LProdf,alm(P1,P2,P3,Pi,P5),alm(P1,P2,P3,Pf,P5)) :-	
		vacia(Pi,Pf,LPILA),
		append(LProdi,LPILA,LProdf).	
		
	vaciapila(LProdi,LProdf,alm(P1,P2,P3,P4,Pi),alm(P1,P2,P3,P4,Pf)) :-	
		vacia(Pi,Pf,LPILA),
		append(LProdi,LPILA,LProdf).	
		
	/*si pila vacia => meter caja*/
	coloca(BOX, p(_,ACTUALi,LIMITE), p(LBOXf,ACTUALf,LIMITE)):-
		ACTUALi=0,
		ACTUALf=ACTUALi+1,
		LBOXf=[Box].
	
	/*si pila no vacia Y pila no llena Y caja no en pila Y pop(pila).diasalida>caja.fechasalida => meter caja*/
	coloca(BOX, p(LBOXi,ACTUALi,LIMITE),p(LBOXf,ACTUALf,LIMITE)):-
		ACTUALi <> 0,
		ACTUALi<LIMITE,
		LBOXi=[TopBox|_],
		mayordiasalida(Box,TopBox),
		ACTUALf=ACTUALi+1,
		LBOXf=[Box|LBOXi].
	
	/*si pila no vacia => vaciar pila*/
	vacia(p(LBOXi,ACTUAL,LIMITE),p([],0,LIMITE),LBOXi) :-	
		ACTUAL>0.
		
	/*para verificar que el dia de salida de la caja actual es menor que el de la priemra caja de la pila*/
	mayordiasalida(b(_,_,DSBOX),b(_,_,DSTOPBOX)):-
		DSBOX <= DSTOPBOX.
        
	/*añade L2 al final de L1*/
	append([],L,L).
	append([E|T],L2,[E|L1L2]):-
		append(T,L2,L1L2).
	
/*SISTEMA DE CONTROL*/
        
        backtrack(Lista,Destino,Lim_ant,_):-
        	Lista=[H|_],
        	Destino=H,
        	write("\nSolucion encontrada a profundidad ",Lim_ant,":"),
        	imprimelistaestados(Lista,Lim_ant),
        	write("\n").
        
        backtrack(Lista,Destino,Lim_ant,Limite):-
        	Lista=[H|T],
        	not(miembro(H,T)),
        	muevecaja(H,Hfinal),
        	Nlista=[Hfinal|Lista],
        	Nue_Lim=Lim_ant+1,
        	Nue_Lim<=Limite,
        	backtrack(Nlista,Destino,Nue_Lim,Limite).
        	
        solution(LIM, ListaProd, Almacen):-
        	write("\nProfunidad ",LIM),
        	backtrack([estado(ListaProd,Almacen)],estado([],_),1,LIM).
        	
        solution(LIM, ListaProd, Almacen):-
        	NLIM=LIM+1,
        	solution(NLIM, ListaProd, Almacen).
	
        /*Estados repetidos */
        miembro(E,[E|_]).
        miembro(E,[_|T]):-
        	miembro(E,T).
        
        /*IMPRIMR POR PANTALLA*/
        
	imprimeestado(estado(LProd,ALMACEN)):-
		write("\n Lista produccion: ", LProd),
		write("\n Almacen:"),
		imprimealmacen(ALMACEN).
		
	imprimealmacen(alm(P1,P2,P3,P4,P5)):-
		imprimepila(P1),
		write("\n\t"),
		imprimepila(P2),
		write("\n\t"),
		imprimepila(P3),
		write("\n\t"),
		imprimepila(P4),
		write("\n\t"),
		imprimepila(P5).
        	
        imprimepila(p(LBOX, ACTUAL, LIMITE)) :-
        	write("(",ACTUAL,"/",LIMITE,") : ",LBOX).
     
        imprimelistaestados([],_).
        imprimelistaestados([H|T],NumEstado):-
        	NumEstado2 = NumEstado - 1,
        	imprimelistaestados(T,NumEstado2),
        	write("\nESTADO ",NumEstado),
        	imprimeestado(H).
		
goal

     solution(1
     	,[b(9,1,17),b(10,1,17),b(11,1,17),b(12,1,17),b(13,1,17),b(14,1,17),b(15,1,17),
	  b(16,1,17),b(17,1,17),b(18,1,17),b(19,1,17),b(20,1,17),b(3,1,18),b(4,1,18),
	  b(5,1,18),b(6,1,18),b(7,1,18),b(8,1,18),b(1,1,19),b(2,1,19)
	], alm( p([],0,4), p([],0,4), p([],0,4), p([],0,4), p([],0,4))
     ).