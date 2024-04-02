--EJERCICIO 1 
--max2
max2::(Float,Float)->Float
max2 (x, y) 
    | x >= y = x
    | otherwise = y

--normaVectorial
normaVectorial::(Float,Float)->Float
normaVectorial (x, y) = sqrt (x^2 + y^2)

--substracts
substract::Float->Float->Float
substract = flip (-)

--predecesor
predecesor::Float->Float
predecesor = subtract 1

--EvaluarEnCero
evaluarEnCero::(Float->b)->b
evaluarEnCero = \f -> f 0

--DosVeces
dosVeces::(Float->Float)->Float->Float
dosVeces = (\f -> (f . f))

--flipAll
flipAll::[a->b->c]->[b->a->c]
flipAll = map flip

--flipRaro
--https://stackoverflow.com/questions/54428941/haskell-applying-flip-twice-type-of-flip-flip
--flip :: (a -> b -> c) -> b -> a -> c
--flip :: (a' -> b' -> c') -> b' -> a' -> c'
--a = (a' -> b' -> c')
--b = b'
--c = a' -> c'
--flip flip :: b' -> (a' -> b' -> c') -> (a' -> c')
flipRaro::b' -> (a' -> b' -> c') -> (a' -> c')
flipRaro = flip flip 

--EJERCICIO 2

altoCurry::((a,b)->c)->a->b->c
altoCurry f a b = f(a,b)

desCurry::(a->b->c)->(a,b)->c
desCurry f (a,b) = f a b

curryN::[((a,b)->c)]->[(a->b->c)]
curryN = map altoCurry

--EJERCICIO 3 

foldSum::(Foldable t,Num a)=> t a->a
foldSum = foldr (+) 0

--Creo que esta bien?
foldElem::(Foldable t,Eq a)=> a->t a->Bool
foldElem a=foldr ((||).(\x->if x==a then True else False)) False

foldPlus::(Foldable t)=>[a]->t a->[a]
foldPlus a=foldr (:) a

foldFilter::(Foldable t)=>(a->Bool)->t a->[a]
foldFilter f = foldr ((++).(\x->if f x then [x] else [])) [] 

foldMap::(Foldable t)=> (a->b)->t a->[b]
foldMap f=foldr ((:).f) []

mejorSegun::(a->a->Bool)->[a]->a
mejorSegun f = foldr1 (\x y->if f x y then x else y)

--IMPORTANTE
sumasParciales :: Num a => [a] -> [a]
sumasParciales a= scanl1 (+) a

--VISTO EN CLASE
sumaAlt :: Num a => [a] -> a
sumaAlt = foldr (-) 0

--SUMA ALT A LA INVERSA NO SERIA FOLDL?

--EJERCICIO 5
--LA PRIMER FUNCION NO ES ESTRUCTURAL POR QUE ESTAN USANDO TAIL EN EL LLAMADO RECURSIVO
--LA SEGUNDA SI LO ES Y LA VAMOS A REESCRIBIR
-- ACC IS USEFUL 4 accumulating a sequence of elements for later traversal or folding. Useful for implementing all kinds of builders on top.
-- No es mi codigo :C
-- me lo guardo por que considero que es util
-- creditos a MatiWaissman
entrelazar :: [a] -> [a] -> [a]
entrelazar = foldr (\x acc y->if null y then x:acc y else x:head y:acc (tail y)) id

--EJERCICIO 6

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

--Ejercicio y resolución visto en clase
--El esquema de recursión estructural no es adecuado para este ejercicio ya que
--accedemos varias veces a la cola en la recursión

sacarPrimera:: Eq a => a -> [a] -> [a]
sacarPrimera e = recr (\x xs rec -> if e == x then xs else x:rec) []

insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado e = recr (\x xs rec -> if e < x then e:x:xs else (if xs==[] then x:e:xs else x:rec)) []

--EJERCICIO 8




