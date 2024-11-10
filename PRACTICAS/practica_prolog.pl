%last(?L,?U).
last([X],X).
last([_|XS],R):-last(XS,R).

%reverse(+L,-L1).
reverse([X],[X]).
reverse([X|XS],L):-reverse(XS,L1),append(L1,[X],L).

%prefijo(?P,+L).
prefijo(P,L):-append(P,_,L).

%sufijo(?P,+L).
sufijo(P,L):-append(_,P,L).
