--https://campus.exactas.uba.ar/pluginfile.php/518021/mod_resource/content/6/p1_funcional.pdf
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
--flipAll::[a->b->c]->[b->a->c]
--flipAll = map flip

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
-- curry
curry_v2::((a,b)->c)->a->b->c
curry_v2 f a b = f (a,b)


--uncurry 
uncurry_v2::(a->b->c)->(a,b)->c
uncurry_v2 f t = f (fst t) (snd t)

-- este no lo entiendo TODO
{-curryN::[((a,b)->c)]->[(a->b->c)]
curryN = map altoCurry-}

--EJERCICIO 3 

{-
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f z [] = z
foldr f z (x:xs) = f x (foldr f z xs)
-}

--PARTE 1 
sum_v2:: Num a=>[a]->a
sum_v2 = foldr (\a b-> a+b) 0

elem_primitivo::Eq a=>a->[a]->Bool
elem_primitivo e [] =False
elem_primitivo e (x:xs) = e==x || elem_primitivo e xs

elem_v2::(Eq a)=>a->[a]->Bool
elem_v2 e = foldr (\a b->(a==e || b)) False 

concat_primitivo::[a]->[a]->[a]
concat_primitivo (x:xs) ys = x:ys

concat_v2::[a]->[a]->[a]
concat_v2 = foldr (:) 

filter_v2::(a->Bool)->[a]->[a]
filter_v2 f = foldr (\a b-> if (f a) then a:b else b) []

map_v2::(a->b)->[a]->[b]
map_v2 f = foldr (\a b-> (f a :b)) []

--PARTE 2


mejorSegun::(a->a->Bool)->[a]->a
mejorSegun f = foldr1 (\a b-> if (f a b) then a else b)

--IMPORTANTE,SE PUEDE HACER CON FOLDR? TODO
sumasParciales :: Num a => [a] -> [a]
sumasParciales a= scanl1 (+) a

--VISTO EN CLASE
sumaAlt :: Num a => [a] -> a
sumaAlt = foldr (-) 0

{-
se tiene que usar flip - por que cambias el orden de la resta, lo que cambia la sintaxis del programa 
(recordar que el orden de la funcion de foldl es b->a->b) y el foldr es (a->b->b)
-}
sumaAlt_INVERSA :: Num a => [a] -> a
sumaAlt_INVERSA = foldl (flip (-)) 0   


--EJERCICIO 4 
{-
    NO TENGO NI IDEA DE COMO SE HACE :]
-}

partes_explicito::[a]->[[a]]
partes_explicito [] = [[]]
partes_explicito (x:xs) = (( map (x:) (partes_explicito xs)) ++ partes_explicito xs)

partes::[a]->[[a]]
partes  = foldr (\x r->(( map (x:) (r)) ++ r)) [[]] 

--EJERCICIO 5
{-
elementosEnPosicionesPares :: [a] -> [a]
elementosEnPosicionesPares [] = []
elementosEnPosicionesPares (x:xs) = if null xs
                                    then [x]
                                    else x : elementosEnPosicionesPares (tail xs)
RTA: esta funcion NO es recursiva ya que en la llamada en la recursión usa tail xs, lo cual accede a xs 


entrelazar :: [a] -> [a] -> [a]
entrelazar [] = id
entrelazar (x:xs) = \ys -> if null ys
                    then x : entrelazar xs []
                    else x : head ys : entrelazar xs (tail ys)
RTA: creo que entrelazar es estructural ya que no accede a XS (lista sobre la cual esta haciendo recursion :])
-}
--EJERCICIO 6
recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

sacarUna::Eq a=>a->[a]->[a]
sacarUna e = recr (\a xs b-> if a==e then xs else e:xs) []

insertarOrdenado::Ord a => a->[a]->[a]
insertarOrdenado e=recr (\x xs rec->if e<x then e:x:xs else (if xs==[] then x:e:xs else x:rec)) []

{-El esquema de recursión foldr no es adecuado para esta función ya que necesitamos acceder a la cola
 en el caso de que el elemento actual sea el que queramos eliminar-}
{-
si e<x termina la recursion
si xs==[] termina la recursion
si nada de esto es verdadero x queda en su posicion y se sigue la recursion "mas adentro"
NO ENTIENDO QUE ES REC ACA TODO
-}



{-Ejercicio 7-}
{-genLista::a->(a->a)->Integer->[a]
genLista e_inicial _ 0 =[e_inicial]
genLista e_inicial f cantidad_lista = (f (head recursion)):recursion
    where recursion= genLista e_inicial f (cantidad_lista-1)
-}

genLista::a->(a->a)->Integer->[a]
genLista e_inicial f cantidad_lista = foldNat cantidad_lista [e_inicial] (\cantidad_actual r->f(head r):r)

{-Ejercicio 8-}
mapPares::(a->b->c)->[(a,b)]->[c]
mapPares f = map (uncurry_v2 f)

armarPares::[a]->[b]->[(a,b)]
armarPares = foldr (\a xs ys-> if null ys then [] else (a,head ys):(xs (tail ys))) (const [])

mapDoble::(a->b->c)->[a]->[b]->[c]
mapDoble f (x:xs) (y:ys)= map (uncurry f) (armarPares (x:xs) (y:ys))

{-Ejercicio 11-}

foldNat::Integer->b->(Integer->b->b)->b
foldNat 0 cb _ =cb
foldNat e cb f = f e (foldNat (e-1) cb f)

potencia::Integer->Integer->Integer
potencia exponente base  = foldNat exponente 1 (\x r->base*r)


{-Ejercicio 12-}

data Polinomio a = X|Cte a | Suma (Polinomio a) (Polinomio a) | Prod (Polinomio a) (Polinomio a)

foldPoli::b->(a->b)->(b->b->b)->(b->b->b)->Polinomio a->b 
foldPoli cX cA cSuma cProd x = case x of
    x->cX
    Cte a-> cA a
    Suma i d -> cSuma (rec i) (rec d) 
    Prod i d -> cProd (rec i) (rec d) 
    where rec = foldPoli cX cA cSuma cProd


{-DUDA EJEMPLO DE EVALUAR QUE NO LO ENTIENDO-}
evaluar::Num a=>a->Polinomio a->a
evaluar a = foldPoli a (id) (+) (*)

{-EJERCICIO 12 -}
data AB a = Nil | Bin (AB a) a (AB a)
foldAB::b->(b->a->b->b)->AB a->b
foldAB  cb f x = case x of 
    Nil -> cb
    Bin i r d -> f (rec i) r (rec d)
    where rec = foldAB cb f 

recAB::b->(b->a->b->a->a->b) -> Polinomio a->b
recAB cb f x = case x of
    Nil -> cb
    Bin i r d -> f (rec i) r (rec d) i d 
    where rec = recAB cb f 

esNil::AB a->Bool
esNil ab = case ab of
    Nil->True
    Bin t1 ab t2->False

cantHojas::AB a->Int
cantHojas ab= foldAEB 0 (\x->1) (\i _ d->i+d+1) ab

altura::AB a->Int
altura ab= foldAEB 0 (\x->1) (\i _ d->max (i+1) (d+1)) ab

mejorSegunAB :: a->(a -> a -> Bool) -> AB a -> a
mejorSegunAB cb f ab= foldAEB (cb) (\x->x) (\i p d-> if (f i d && f i p) then i else (if(f d i && f d p) then d else p)) ab

{-DUDA EJERCICIO 14-}
{-empezar guia 2-}