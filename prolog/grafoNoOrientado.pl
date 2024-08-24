nodo(1).
nodo(2).
nodo(3).
arista(1,2).
arista(2,3).
arista(X,Y):-arista(Y,X).

%% caminoSimple(+G,+D,+H,?L)
%% nos dice si L es un camino simple en el grafo G
%% que empieza en D y termina en H
caminoSimple(g(_,_),H,H,[H]).
caminoSimple(g(V,E),D,H,[D|L]):- member(arista(D,D1),E),
                                 caminoSimple(g(V,E),D1,H,L).

%% caminoHamiltoniano(+G,?L)
%% Un camino L en un grafo G es Hamiltoniano sii L es un camino simple que contiene a todos los nodos G
caminoHamiltoniano(g(V,E),L):- member(I,V),member(F,V),
                               caminoSimple(g(V,E),I,F,L),
                               estanTodos(V,L).

estanTodos([],_).
estanTodos([X|XS],L):-member(X,L),estanTodos(XS,L).        

%% esConexo(+G)
esConexo(g(V,E)):- forall(member(X,V),forall(member(X1,V),caminoSimple(g(V,E),X,X1,_))).

%% el ultimo ejercicio es igual a EsConexo
%% TODO:fijarme si esConexo funciona y si puedo usar forall.

%% caminoSimple(g([1,2,3],[arista(1,2),arista(2,3)]),1,3,L).
%% caminoHamiltoniano(g([1,2,3],[arista(1,2),arista(2,3)]),L).