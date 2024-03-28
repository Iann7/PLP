import Data.Maybe
import Data.Either

main :: IO ()
main = return ()

--dado un número devuelve su valor absoluto
valorAbsoluto::Float -> Float
valorAbsoluto = (\x->if x<=0 then x*(-1) else x)

--dado un número que representa un año, indica si el mismo es bisiesto
bisiesto::Int->Bool
bisiesto x=isBisisesto
    where isBisisesto=((mod x 4)==0 && (mod x 100)/=0) || ((mod x 100)==0 && mod x 400 ==0)

--factorial
factorial::Int->Int
factorial 0 =1
factorial x = x*factorial x-1

--Maybe Either
--data Maybe a = Nothing | Just a
--data Either a b = Left a | Right b
-- dado un número devuelve su inverso multiplicativo
--si está definido, o Nothing en caso contrario
inverso :: Float -> Maybe Float  
inverso x = case x of   
    0 -> Nothing  
    x -> Just (1/x)
aEntero :: Either Int Bool -> Int
aEntero x = case x of 
    Left x -> 1
    Right True -> 1 
    Right False -> 0


data AB a = Nil | Bin (AB a) a (AB a)

vacioAB :: (AB a) -> Bool
vacioAB a= case a of
    Nil->True
    Bin t1 a t2 ->False

negacionAB::AB Bool->AB Bool
negacionAB a = foldAEB  a 
        
foldAEB::(AB Bool)->AB Bool      
foldAEB n = case n of
    Nil-> Nil
    Bin t1 n t2 -> Bin (foldAEB t1) (not(n)) (foldAEB t2)


    