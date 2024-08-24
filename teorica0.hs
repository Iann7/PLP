{-
map:: (a->b)->[a]->[b]
map f [] =[]
map f (x:xs) = f x : map f xs

generaliza el mapeo de listas a una funcion 

filter::(a->bool)->[a]->[a]
filter p [] =[]
    filter p (x:xs) = if p x then x:filter p xs 
                    else filter p xs

generaliza el filter 

que tipo tiene map filter? (EJERCICIO PARA EL LECTOR)

Notacion "Lambda" es de la forma: (\x->e) (recibo un param x y devuelvo e)

RECURSION ESTRUCTURAL --> FOLDR
    funciones que reciben listas de algo y devuelven algo - Pablo
    CASO BASE ES FIJO
    NO SE PUEDE USAR LA COLA DE LA LISTA (xs) salvo g xs 
    EJEMPLO DE PLEGADO A DERECHA    
        suma [1,2]->foldr (+) 0 [1,2]
                    (+) 1 (foldr (+) 0 [2])
                    (+) 1 ((+) 2 (foldr (+) 0 []))
                    (+) 1 ((+) 2 0)
                    (+) 1 2
                    3 -> VOILA

RECURSION PRIMITIVA --> RECR
    TODAS LAS DEF DE REC ESTRUCTURAL ESTAN DADAS POR REC PRIMITIVA
    HAY DEF DE REC PRIMITIVAS QUE NO ESTAN DADAS POR REC ESTRUCUTURAL
    SE PUEDE ACCEDER A LA COLA
RECURSION ITERATIVA -> FOLDL
    EL CASO BASE  DEVUELVE EL ACUMULADOR
    CR lo mismo de siempre


productoCartesiano::[a]->[b]->[(a,b)]
productoCartesiano [] _ =[]
productoCartesiano (x:xs) ys = combinarTodos x ys ++ productoCartesiano xs ys 

combinarTodos::a->[b]->[(a,b)]
combinarTodos [] =[]
combinarTodos x (y:ys) = (x,y):combinarTodos x ys 

TODO REVISAR PRODUCTO CARTESIANO 
EJERCICIO HACER ESTO EN ESTRUCTURADO

insertar::Ord a=>a->Ab a->Ab a
insertar x nil =Bin nil x Nil
insertar x (Bin i r d)
    | x<r = Bin(insertar x i) r d 
    | x>r = Bin i r (insertar x d)
    | otherwise = Bin i r d
ESTA RECURSION ES ESTRUCTURAL,PRIMITIVA O ITERATIVA?
me parece que es primitiva 

Recursion estructural -> g :: T -> Y (siendo g la funcion con recursion estructural)
                        recursion sobre estructuras que tienen casos recursivos y tienen casos base
                         Cada caso base se escribe combinando los par´ametros
                         
                         Cada caso recursivo:
                        ▶ No usa la funci´on g.
                        ▶ No usa los par´ametros del constructor que son de tipo T.
                        Pero puede:
                        ▶ Hacer llamados recursivos sobre par´ametros de tipo T.
                        ▶ Usar los par´ametros del constructor que no son de tipo T

foldAB::b->(b->a->b->b)->AB a->b
foldAB z f nil = z
foldAB z f (Bin i r d) = f (foldAB z f i) r (foldAB z f d )

¿Que funcion es (foldAB nil bin)? la identidad (ja ja ja)

mapAB::(a->b)-> AB a-> AB b
mapAB f a = foldAB (\ri v rd-> Bin ri (f v) rd ) Nil
-}