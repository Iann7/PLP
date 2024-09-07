{-IMPLEMENTAR TAKE-}

take2::[a]->Int->[a]
take2 =  foldr (\x rxs ->(\n->if n==0 then [] else x:rxs(n-1)))
               (const []) 
{-quedarte esperando la n en (\x rxs n->blah) es lo mismo que
 (\x rxs ->\n->(blah))-}


 sacarUna::Eq a => a->[a]->[a]
 sacarUna e = recr (\x xs rec -> if x==e then xs else x:rec) []


{-GENERACION INFINITA-}
{-LISTAS POR COMPRENSION-}
{-
[x**2|x<-[1..10]]
*=exponente de los floats
-}

{-
    pares::[(Int,Int)]
    pares = [(x,y)| x<-[1..],y-<[1..]]

    va a generar todos los pares, pero primero fija el x y despues el y
    pero como los Ys son infinitos el x se queda en uno
  
    -NUNCA USAR DOS GENERADORES INFINITOS, SIEMPRE USAR SOLO UNO!!!!!
    -LEER GENERACION INFINITA EN UTILES,CAMPUS

    take 100 pares
  -}
    pares::[(Int,Int)]
    pares:: [(x,y)| s<-[0..], x<-[0..s],y<-[0..s], x+y==s]

    {-
    FOLD SOBRE ESTRUCTURAS NUEVAS 
    data AEB a = Hoja a | Bin (AEB a) a (AEB a)
    -}

    foldAB:: (a->b)->(b->a->b->b)->Hoja a->b
    foldAB cb f x = case x of 
        Hoja a -> cb A
        Bin i v d -> f (rec i) v (rec d)
            where rec= foldAB cb f 
{-FUNCIONES COMO ESTRUCTURAS DE DATOS-}
{- definimos una funcion que va a ser una estructura de datos
   ej type Conj a =(a->Bool) 
   cuando nuestro tipo no es mas que un renombre de otro tipo se define con type 
   vacio::Conj a
   vacio = const false

   todo::Conj a
   todo = const true 

    IMPLEMENTEMOS AGREGAR

    agregar::Eq a=>a->Conj a -> 
    agregar a b = (\e->if a==e then true else b e)

    interseccion es conjunto a & conjunto b 
    union es conjunto a || conjunto b 
    diferencia es Conjunto a XOR conjunto B 
   -}
