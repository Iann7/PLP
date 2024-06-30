%%creditos a fausto, creador del codigo.
desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

%% va generando cuadrados semi latinos, que van desde 0 hasta infinito
cuadradoSemiLatino(N,XS):- desde(0,X),
                           gen_matriz_con_cota(XS,N,N,X).


%% luego itera N veces sobre gen matriz cota la cual 
%% va creando XS y vuelve entrar a si misma esta vez solo con M 
gen_matriz_con_cota([XS],1,N,X):- llenar_fila(XS,N,X).
gen_matriz_con_cota([XS|M],N,F,X):- N\=1,N2 is N-1, 
                                    gen_matriz_con_cota(M,N2,F,X),
                                    llenar_fila(XS,F,X).

%% por ultimo la funcion que llena todas las filas
%% le va restando a la cota los valores que ya estan en la fila
%% se guarda las dos cosas y sigue en la recursion  
llenar_fila([X],1,X).
llenar_fila([X|XS],N,Cota) :- N \=1, between(0,Cota,Y),X1 is Cota -Y,X=X1,N2 is N-1,
                              llenar_fila(XS,N2,Y).

%% Ahora,vamos a hacer magic square
%% la unica dif con cuadrado semi latino es que las col y las filas suman lo mismo 
%% como tambien asi las diagonales 
%% pedir que las columnas sumen lo mismo es pedir que la transpuesta 
%% tambien sea un cuadrado semi latino 
%% no se me ocurre como pedir las diagonales 
%% para esto vamos a utilizar un transpose que se le ocurrio a alguien en stack 
%% https://stackoverflow.com/questions/4280986/how-to-transpose-a-matrix-in-

%% para las diagonales habria que hacer 

transpose([[]|_], []).
transpose(Matrix, [Row|Rows]) :- transpose_1st_col(Matrix, Row, RestMatrix),
                                 transpose(RestMatrix, Rows).
transpose_1st_col([], [], []).
transpose_1st_col([[H|T]|Rows], [H|Hs], [T|Ts]) :- transpose_1st_col(Rows, Hs, Ts).

% Calculate the sum of the main diagonal elements of a square matrix
diagonal_sum([], 0).
diagonal_sum([Row|[NextRow|Rest]], Sum) :-
    nth1(I, Row, DiagonalElement),
    Sum1 is Sum + DiagonalElement,
    diagonal_sum(NextRow, Sum1).

%% por suerte el enunciado NO NOS PIDE calcular las diagonales 
magicSquare(N,XS):-cuadradoSemiLatino(N,XS),
                   transpose(XS,S),cuadradoSemiLatino(N,S),

                   

