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
	move(est,est)
			
  	/*METER CAJA A PILA*/
	push(box,almacen,almacen)
  	pushStack(box,pila,pila)
  					
  	/*SACAR CAJA DE PILA*/
	pop(box,almacen,almacen)
  	popStack(box,pila,pila)
	
	/*AUXILIARES*/
  	/*
  	append(lbox,lbox,lbox)
  	*/
  	add(box,lbox,lbox)
	mayordiasalida(box,box)

/*SISTEMA DE CONTROL*/
  	backtrack(lista,est,limite,limite) /* Lista de estados, Estado final, Profundidad actual, Profundiad maxima */
  	solution(integer,est, est)
  	miembro(est,lista)
  	
/*IMPRIMIR POR PANTALLA*/
	printStack(pila)
	printState(est)
	printStorage(almacen)
  	printStateList(lista,integer)

clauses

/*REGLAS DE PRODUCCION*/
	
	/*meter caja en pila*/
	move(estado(LProdi,ALMACENi),estado(LProdiTail,ALMACENf)):-
		LProdi=[BOX|LProdiTail],
		push(BOX,ALMACENi,ALMACENf).
	
	/*quitar caja de pila*/
	move(estado(LProdi,ALMACENi),estado(LProdf,ALMACENf)):-
		pop(BOX,ALMACENi,ALMACENf),
		add(BOX,LProdi,LProdf).
	
	/*seleccionar pila para meter caja*/
	push(BOX,alm(Pi,P2,P3,P4,P5),alm(Pf,P2,P3,P4,P5)):-
		pushStack(BOX,Pi,Pf).
		
	push(BOX,alm(P1,Pi,P3,P4,P5),alm(P1,Pf,P3,P4,P5)):-
		pushStack(BOX,Pi,Pf).
		
	push(BOX,alm(P1,P2,Pi,P4,P5),alm(P1,P2,Pf,P4,P5)):-
		pushStack(BOX,Pi,Pf).
		
	push(BOX,alm(P1,P2,P3,Pi,P5),alm(P1,P2,P3,Pf,P5)):-
		pushStack(BOX,Pi,Pf).
		
	push(BOX,alm(P1,P2,P3,P4,Pi),alm(P1,P2,P3,P4,Pf)):-
		pushStack(BOX,Pi,Pf).
		
	/*seleccionar pila para vaciar y meter las cajas en lista produccion*/
	pop(BOX,alm(Pi,P2,P3,P4,P5),alm(Pf,P2,P3,P4,P5)) :-	
		popStack(BOX,Pi,Pf).
		
	pop(BOX,alm(P1,Pi,P3,P4,P5),alm(P1,Pf,P3,P4,P5)) :-	
		popStack(BOX,Pi,Pf).	
		
	pop(BOX,alm(P1,P2,Pi,P4,P5),alm(P1,P2,Pf,P4,P5)) :-	
		popStack(BOX,Pi,Pf).
		
	pop(BOX,alm(P1,P2,P3,Pi,P5),alm(P1,P2,P3,Pf,P5)) :-	
		popStack(BOX,Pi,Pf).	
		
	pop(BOX,alm(P1,P2,P3,P4,Pi),alm(P1,P2,P3,P4,Pf)) :-	
		popStack(BOX,Pi,Pf).	
		
	/*si pila vacia => meter caja*/
	pushStack(BOX, p(_,ACTUALi,LIMITE), p(LBOXf,ACTUALf,LIMITE)):-
		ACTUALi=0,
		ACTUALf=ACTUALi+1,
		LBOXf=[BOX].
	
	/*si pila no vacia Y pila no llena Y caja no en pila Y pop(pila).diasalida>caja.fechasalida => meter caja*/
	pushStack(BOX, p(LBOXi,ACTUALi,LIMITE),p([BOX|LBOXi],ACTUALf,LIMITE)):-
		ACTUALi <> 0,
		ACTUALi<LIMITE,
		LBOXi=[TopBox|_],
		mayordiasalida(BOX,TopBox),
		ACTUALf=ACTUALi+1.
	
	/*si pila no vacia => quitar caja*/
	popStack(BOX,p(LBOXi,ACTUALi,LIMITE),p(LBOXf,ACTUALf,LIMITE)) :-	
		ACTUALi>0,
		ACTUALf=ACTUALi-1,
		LBOXi=[BOX|LBOXf].
		
	/*para verificar que el dia de salida de la caja actual es menor que el de la priemra caja de la pila*/
	mayordiasalida(b(_,_,DSBOX),b(_,_,DSTOPBOX)):-
		DSBOX <= DSTOPBOX.
        
	/*añade L2 al final de L1
	append([],L,L).
	append([E|T],L2,[E|L1L2]):-
		append(T,L2,L1L2).
	*/
	add(X,[],[X]).
	add(X,[Y|Tail],[Y|Tail1]):-
        	add(X,Tail,Tail1).
	
	
/*SISTEMA DE CONTROL*/
        
        backtrack(Lista,Destino,Lim_ant,_):-
        	Lista=[H|_],
        	Destino=H,
        	write("\nSolucion encontrada a profundidad ",Lim_ant,":"),
        	printStateList(Lista,Lim_ant),
        	write("\n").
        
        backtrack(Lista,Destino,Lim_ant,Limite):-
        	Lista=[H|T],
        	not(miembro(H,T)),
        	move(H,Hfinal),
        	Nlista=[Hfinal|Lista],
        	Nue_Lim=Lim_ant+1,
        	Nue_Lim<=Limite,
        	backtrack(Nlista,Destino,Nue_Lim,Limite).
        	
        solution(LIM, STATEi, STATEf):-
        	write("\nProfunidad ",LIM),
        	backtrack([STATEi],STATEf,1,LIM).
        	
        solution(LIM, STATEi, STATEf):-
        	NLIM=LIM+1,
        	solution(NLIM, STATEi, STATEf).
	
        /*Estados repetidos */
        miembro(E,[E|_]).
        miembro(E,[_|T]):-
        	miembro(E,T).
        
        /*IMPRIMR POR PANTALLA*/
        printStateList([],_).
        printStateList([H|T],NumEstado):-
        	NumEstado2 = NumEstado - 1,
        	printStateList(T,NumEstado2),
        	write("\nESTADO ",NumEstado),
        	printState(H).
        
	printState(estado(LProd,ALMACEN)):-
		write("\n Lista produccion: ", LProd),
		write("\n Almacen:"),
		printStorage(ALMACEN).
		
	printStorage(alm(P1,P2,P3,P4,P5)):-
		printStack(P1),
		write("\n\t"),
		printStack(P2),
		write("\n\t"),
		printStack(P3),
		write("\n\t"),
		printStack(P4),
		write("\n\t"),
		printStack(P5).
        	
        printStack(p(LBOX, ACTUAL, LIMITE)) :-
        	write("(",ACTUAL,"/",LIMITE,") : ",LBOX).
     	
goal

     solution(
     	30,
     	estado(
     	  [b(9,1,17),b(10,1,17),b(11,1,17),b(12,1,17),b(13,1,17),b(14,1,17),b(15,1,17),
	   b(16,1,17),b(17,1,17),b(18,1,17),b(19,1,17),b(20,1,17),b(3,1,18),b(4,1,18),
	   b(5,1,18),b(6,1,18),b(7,1,18),b(8,1,18),b(1,1,19),b(2,1,19)
	  ], 
	  alm( p([],0,4), p([],0,4), p([],0,4), p([],0,4), p([],0,4))
	),
	estado([],_)
     ).