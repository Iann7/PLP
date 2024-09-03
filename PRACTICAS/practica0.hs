{-
Breve explicacion de ghci
:r para recargar
:t para conseguir el tipo 
-}

{-version currificada y no currificada de la misma funcion 
currificar es desempaquetar los argumentos de una función
prod' 2 es una funcion que recibe un int y lo multiplica por dos -}
prod::(Int,Int)->Int
prod (x,y) = x*y

prod'::Int->Int->Int
prod' x y = x*y

--EJ APP PARCIAL -> DOBLE x = prod 2 x 
{-
LISTAS POR COMPRENSION 
EJEMPLO GENERADOR DE PRIMOS [n|n<-[2...],esPrimo n]
listaComp f xs p = [f x |x<-xs, p x]
-}



