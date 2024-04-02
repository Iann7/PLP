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
mapPares::(a->b->c)->[(a,b)]->[c]
mapPares f= map (desCurry f)

--https://www.cubawiki.com.ar/index.php/Pr%C3%A1ctica_1_(Paradigmas)
armarPares :: [a] -> [b] -> [(a, b)]
armarPares=foldr  (\a acc bs -> if null bs then [] else (a,head bs):acc (tail bs) ) (const [])

mapDoble::(a->b->c)->[a]->[b]->[c]
mapDoble f (x:xs) (y:ys)= map (desCurry f) (armarPares (x:xs) (y:ys))

--EJERCICIO 10

generate :: ([a] -> Bool) -> ([a] -> a) -> [a]
generate stop next = generateFrom stop next []
generateFrom:: ([a] -> Bool) -> ([a] -> a) -> [a] -> [a]
generateFrom stop next xs 
    | stop xs = init xs
    | otherwise = generateFrom stop next (xs ++ [next xs])

generateBase::([a] -> Bool) -> a -> (a -> a) -> [a]
generateBase stop cb next = generate stop (\l->next (last l))

factoriales::Int->[Int]
factoriales i = generate (\l->(length l)==i+1) (\l->if (length l==0) then 1 else (foldl (*) ((last l)+1) l))

iterateN :: Int -> (a -> a) -> a -> [a]
iterateN n f x = generateBase (\l->(length l)==n) x f

--like that?
generateFromALT::(a-> Bool) -> (a -> a) -> a -> [a]
generateFromALT stop next cb= takeWhile stop (iterate next cb)

-- EJERCICIO 11
-- Creditos al grupo de WPP para foldNat
foldNat :: Int -> Int -> (Int -> Int -> Int) -> Int
foldNat cb 1 _ = cb
foldNat cb n f = f cb (foldNat cb (n-1) f)

potencia::Int->Int->Int
potencia n elevado= foldNat n elevado (\x y->x*y)

--TODO EJERCICIO 13

data AB a = Nil | Hoja a |Bin (AB a) a (AB a)

foldAEB :: b->(a -> b) -> (b -> a -> b -> b) -> AB a -> b
foldAEB cb cHoja cBin arbol = case arbol of
    Nil->cb
    Hoja x->cHoja x
    Bin i r d -> cBin (rec i) r (rec d)
  where rec = foldAEB cb cHoja cBin 


--No se como hacer RECAEB
--recAEB :: b->(a -> b) -> (b -> a -> b -> b)-> AB a -> b
--recAEB cb cHoja cBin arbol = case arbol of
--    Nil->cb
--    Bin i r d -> cBin (rec i) r (rec d)
--    where rec = recAEB cHoja cBin 

esNil::AB a->Bool
esNil ab = case ab of
    Nil->True
    Bin t1 ab t2->False

cantHojas::AB a->Int
cantHojas ab= foldAEB 0 (\x->1) (\i _ d->i+d+1) ab

altura::AB a->Int
altura ab= foldAEB 0 (\x->1) (\i _ d->max (i+1) (d+1)) ab


-- LE AGREGUE UN CB PARA NIL...NO SE ME OCURRE OTRA FORMA POR AHORA
--TODO
mejorSegunAB :: a->(a -> a -> Bool) -> AB a -> a
mejorSegunAB cb f ab= foldAEB (cb) (\x->x) (\i p d-> if (f i d && f i p) then i else (if(f d i && f d p) then d else p)) ab

--EJERCICIO 16

data RoseTree a = Rose a [RoseTree a]

foldRT :: (a -> [b] -> b) -> RoseTree a -> b
foldRT f (Rose x hijos) = f x (map (foldRT f) hijos)

tamaño :: RoseTree a -> Int
tamaño = foldRT (\_ recs -> 1 + sum recs)
--tamaño (Rose x hijos) = 1 + sum (map tamaño hijos)

alturaRoseTree :: RoseTree a -> Int
alturaRoseTree = foldRT (\_ recs -> 1 + maximum (0 : recs))
--maximum es una buena funcion
--tamaño (Rose x hijos) = 1 + sum (map tamaño hijos)

exampleTree :: RoseTree Char
exampleTree =
  Rose 'A'
    [ Rose 'B' []
    , Rose 'C' [ Rose 'D' []
               , Rose 'E' []
               ]
    , Rose 'F' [ Rose 'G' []
               , Rose 'H' [ Rose 'I' []
                          , Rose 'J' []
                          ]
               ]
    ]


--TODO DISTANCIA ROSE TREE 16
--TODO ES ABB 13