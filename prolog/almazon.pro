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
	pila=p(identificador,lbox,actual,limite)
	
	almacen=alm(pila,pila,pila,pila,pila)

	/*backtracking*/
	est=estado(lbox, almacen)
	estp=estadopila(lbox, pila)
	lista=est*

predicates
  	
	/*REGLAS DE PRODUCCION*/
	muevecaja(est,est)
  	colocaenpila(box,almacen,almacen)
  	coloca(box,pila,pila)
	mayordiasalida(box,box)
	contienepila(box,lbox)
	vaciapila(lbox,lbox,pila,pila)
  	/*
  	sacadepila(box,almacen,almacen)
  	saca(box,pila,pila)
  	*/
	
	/*SISTEMA DE CONTROL*/
  	miembro(est,lista)
  	backtrack(lista,est,limite,limite) /* Lista de estados, Estado final, Profundidad actual, Profundiad maxima */
  	solution(integer,lbox,almacen)
  	
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
	
	/*vaciar pila entera*/
	muevecaja(estado(LProdi,alm(Pi,P2,P3,P4,P5)),estado(LProdf,alm(Pf,P2,P3,P4,P5))):-
		vaciapila(LProdi,LProdf,Pi,Pf).
		
	muevecaja(estado(LProdi,alm(P1,Pi,P3,P4,P5)),estado(LProdf,alm(P1,Pf,P3,P4,P5))):-
		vaciapila(LProdi,LProdf,Pi,Pf).
		
	muevecaja(estado(LProdi,alm(P1,P2,Pi,P4,P5)),estado(LProdf,alm(P1,P2,Pf,P4,P5))):-
		vaciapila(LProdi,LProdf,Pi,Pf).
		
	muevecaja(estado(LProdi,alm(P1,P2,P3,Pi,P5)),estado(LProdf,alm(P1,P2,P3,Pf,P5))):-
		vaciapila(LProdi,LProdf,Pi,Pf).
		
	muevecaja(estado(LProdi,alm(P1,P2,P3,P4,Pi)),estado(LProdf,alm(P1,P2,P3,P4,Pf))):-
		vaciapila(LProdi,LProdf,Pi,Pf).
		
	vaciapila(LPROD,LPROD,p([],ACTUAL,LIMITE),p([],ACTUAL,LIMITE)).
	vaciapila(LProdi,LProdf,p(LBOXi,ACTUALi,LIMITE),p(LBOXf,ACTUALf,LIMITE)) :-	
		ACTUALi <> 0,
		ACTUALf = ACTUALi - 1,
		LBOXi=[BOX|LBOXiTail],
		LBOXf=LBOXiTail,
		LProdtmp1=[BOX|LProdi],
		vaciapila(LProdtmp1,LProdtmp2,p(LBOXf,ACTUALf,LIMITE)),
		LProdf=LProdtmp2.


	/*seleccionar una de las pilas del almacen para meter caja*/
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
		
	/*si pila vacia => meter caja*/
	coloca(BOX, p(PID,_,ACTUALi,LIMITE), p(PID,LBOXf,ACTUALf,LIMITE)):-
		ACTUALi=0,
		ACTUALf=ACTUALi+1,
		LBOXf=[Box].
		/*write("\nAccion: ",Box," -> ", PID,":", LBOXf).*/
	
	/*si pila no vacia Y pila no llena Y caja no en pila Y pop(pila).diasalida>caja.fechasalida => meter caja*/
	coloca(BOX, p(PID,LBOXi,ACTUALi,LIMITE),p(PID,LBOXf,ACTUALf,LIMITE)):-
		ACTUALi <> 0,
		ACTUALi<LIMITE,
		not(contienepila(BOX,LBOXi)),
		LBOXi=[TopBox|_],
		mayordiasalida(Box,TopBox),
		ACTUALf=ACTUALi+1,
		LBOXf=[Box|LBOXi].
		/*write("\nAccion ",Box," -> ", PID,":", LBOXf).*/
	
	/*para verificar que el dia de salida de la caja actual es menor que el de la priemra caja de la pila*/
	mayordiasalida(b(_,_,DSBOX),b(_,_,DSTOPBOX)):-
		DSBOX <= DSTOPBOX.
	
	/*para saber si una pila tiene una caja*/
        contienepila(E,[E|_]).
        contienepila(E,[_|T]):-
        	contienepila(E,T).
	
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
        	
        imprimepila(p(ID, LBOX, ACTUAL, LIMITE)) :-
        	write("[",ID,"] (",ACTUAL,"/",LIMITE,") : ",LBOX).
     
        imprimelistaestados([],_).
        imprimelistaestados([H|T],NumEstado):-
        	NumEstado2 = NumEstado - 1,
        	imprimelistaestados(T,NumEstado2),
        	write("\nESTADO ",NumEstado),
        	imprimeestado(H).
		
goal

     solution(22
     	,[b(9,1,17),b(10,1,17),b(11,1,17),b(12,1,17),b(13,1,17),b(14,1,17),b(15,1,17),
	  b(16,1,17),b(17,1,17),b(18,1,17),b(19,1,17),b(20,1,17),b(3,1,18),b(4,1,18),
	  b(5,1,18),b(6,1,18),b(7,1,18),b(8,1,18),b(1,1,19),b(2,1,19)
	], alm( p(1,[],0,4), p(2,[],0,4), p(3,[],0,4), p(4,[],0,4), p(5,[],0,4))
     ).
     
/*
	POSSIBLE SOLUTION
	p([b(12,1,17),b(11,1,17),b(10,1,17),b(9,1,17)],4,4)
	p([b(16,1,17),b(15,1,17),b(14,1,17),b(13,1,17)],4,4)
	p([b(20,1,17),b(19,1,17),b(18,1,17),b(17,1,17)],4,4)
	p([b(6,1,18),b(5,1,18),b(4,1,18),b(3,1,18)],4,4
	p([b(8,1,18),b(7,1,18),b(2,1,19),b(1,1,19)],4,4)
*/

	/*seleccionar caja de pila para meter en lista de produccion
	muevecaja(estado(LBOXi,ALMACENi),estado(LBOXf,ALMACENf)):-
		sacadepila(BOX,ALMACENi,ALMACENf),
		LBOXf = [BOX|LBOXi].
	
	seleccionar una de las pilas del almacen para sacar caja
	
	sacadepila(BOX,alm(P1,P2,P3,P4,Pi),alm(P1,P2,P3,P4,Pf)):-
		saca(BOX,Pi,Pf).
		
	sacadepila(BOX,alm(P1,P2,P3,Pi,P5),alm(P1,P2,P3,Pf,P5)):-
		saca(BOX,Pi,Pf).
	
	sacadepila(BOX,alm(P1,P2,Pi,P4,P5),alm(P1,P2,Pf,P4,P5)):-
		saca(BOX,Pi,Pf).
		
	sacadepila(BOX,alm(P1,Pi,P3,P4,P5),alm(P1,Pf,P3,P4,P5)):-
		saca(BOX,Pi,Pf).
	
	sacadepila(BOX,alm(Pi,P2,P3,P4,P5),alm(Pf,P2,P3,P4,P5)):-
		saca(BOX,Pi,Pf).
	
	si pila tiene mas de dos elementos => sacar caja
	saca(BOX, p(PID,LBOXi,ACTUALi,LIMITE),p(PID,LBOXf,ACTUALf,LIMITE)):-
		ACTUALi > 1,
		LBOXi = [Box|LBOXiTail],
		ACTUALf = ACTUALi -1,
		LBOXf = LBOXiTail,
		BOX = Box.
*/