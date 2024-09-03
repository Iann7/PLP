import Data.Maybe
import Data.Either

main :: IO ()
main = return ()

--EJERCICIO 2 
--A
--dado un número devuelve su valor absoluto
valorAbsoluto::Float -> Float
valorAbsoluto = (\x->if x<=0 then x*(-1) else x)
--B
--dado un número que representa un año, indica si el mismo es bisiesto
bisiesto::Int->Bool
bisiesto x=isBisisesto
    where isBisisesto=((mod x 4)==0 && (mod x 100)/=0) || ((mod x 100)==0 && mod x 400 ==0)
--C
--factorial
factorial::Int->Int
factorial 0 =1
factorial x = x*factorial x-1

--D

esPrimo::Int->Bool
esPrimo a= leastDivisor a a == a

leastDivisor::Int->Int->Int
leastDivisor a 1=a
leastDivisor a b 
    | (mod a b ==0) = min b (leastDivisor a (b-1))
    | otherwise = leastDivisor a (b-1)

cantDivisoresPrimos::Int->Int
cantDivisoresPrimos a = cantDivisoresPrimosAUX a a

cantDivisoresPrimosAUX::Int->Int->Int
cantDivisoresPrimosAUX a 1 =0
cantDivisoresPrimosAUX a b 
    | (mod a b ==0) && (esPrimo b) =1+cantDivisoresPrimosAUX a (b-1)
    | otherwise = cantDivisoresPrimosAUX a (b-1)

--EJERCICIO 2 
--Maybe Either
--data Maybe a = Nothing | Just a
--data Either a b = Left a | Right b
-- dado un número devuelve su inverso multiplicativo
--si está definido, o Nothing en caso contrario

--A
inverso :: Float -> Maybe Float  
inverso x = case x of   
    0 -> Nothing  
    x -> Just (1/x)
--B
aEntero :: Either Int Bool -> Int
aEntero x = case x of 
    Left x -> 1
    Right True -> 1 
    Right False -> 0


--EJERCICIO 3 
--A
limpiar::String->String->String
limpiar ys [] = []
limpiar ys (x:xs)
    | elem x ys = limpiar ys xs 
    | otherwise = x:(limpiar ys xs) 
--B
promedio::[Float]->Float->Float->Float
promedio [] s l = s / l
promedio (x:xs) s l= promedio xs (s+x) (l+1)

difPromedio::[Float]->[Float]
difPromedio (x:xs) = difPromedioAUX (x:xs) (x:xs)

difPromedioAUX::[Float]->[Float]->[Float]
difPromedioAUX [] _ = []
difPromedioAUX (x:xs) l = (x-(promedio l 0 0)): difPromedioAUX xs l 


--C 
todosIguales::[Int]->Bool
todosIguales [] =True
todosIguales (x:xs) = todosIgualesAUX xs x && todosIguales xs 

todosIgualesAUX::[Int]->Int->Bool
todosIgualesAUX [] _ =True
todosIgualesAUX (x:xs) i = x==i && todosIgualesAUX xs i

--EJERCICIO 4 
data AB a = Nil | Bin (AB a) a (AB a)

vacioAB :: (AB a) -> Bool
vacioAB a= case a of
    Nil->True
    Bin t1 a t2 ->False

negacionAB::AB Bool-> AB Bool 
negacionAB Nil  =Nil
negacionAB (Bin t1 a t2)  =Bin (negacionAB t1) (not a) (negacionAB t2)

productoAB :: AB Int -> Int
productoAB Nil = 1
productoAB (Bin l v r) = (v) * (productoAB l) * (productoAB r) 