{-
Para razonar equivalencia de expresiones 

Como hacemos para demostrar igualdades?

    Principio de reemplazo
        sea e1=e2 una ecuacion incluida en el programa 
        las siguientes péraciones preservaran la igualdad de operaciones
        - reemplazar e1 por e2 
        - reemplazar e2 por e1
        Si una igualdad se puede demostrar solo este principio se llama
        IGUALDAD POR DEFINICIÓN 
            EJEMPLO
            sucesor::Int->Int
            {SUC} sucesor n = n+1

            sucesor (factorial 10) +1 
            =(factorial 10+1) +1   por {SUC}

            EJEMPLO 
            {l0} length [] =0
            {l1} length (_:xs) = 1+length xs
            {S0} suma [] =0
            {S1} suma (x:xs) = x+suma xs 

            veamos que length ["a","b"] = suma [1,1]
            len["a","b"]
            =1+len["b"]
            =1+(1+len [])
            =1+(1+0)
            =2

            =1+(1+ suma [])
            =1+(1+0)
            =1+1
            =2

            los dos lados son iguales!

    Induccion sobre booleanos 
        El principio de reemplazo no alcanca para probar todas las equivalencias que nos interesan
        EJEMPLO
        {NT} not True =False
        {NF} not False =True
        ¿Podemos probar que para todo x de tipo bool not(not x)=x?
        el problema es que se nos traba una expresion
        por eso vamos a usar el Principio de Inducción sobre booleanos
        si P(true) y P(false) entonces para todo X de tipo bool P(x)

        1 not(not True) = True
        2 not(not False)=False
        A PROBAR

    Inducción sobre pares 
    cada tipo de datos TIENE SU PROPIO TIPO DE INDUCCIÓN 
    EJEMPLO 
    {fst} fst (x,_) =x
    {snd} snd (_,y) =y
    {SWAP} swap(x,y)=(y,x)
    ¿podemos probar que para todo p del tipo tupla fst p=snd (swap p)?
    las expresiones fst p y snd (swap p) estan "trabadas"
    (por que sin la inducción p es solamente una palabra)
    si para todo X e Y del tipo a,b respectivamente  P((x,y))
    entonces para todo p del tipo (a,b) P(p)

    ahora basta con probar:
        fst (x,y) = snd (swap(x,y))

        fst(x,y)=x=snd(y,x)=snd(swap(x,y))
        por ende acabamos de probar la igualdad de ambas funcions 
        para demostrar que dos igualdades son iguales
        conviene reducir el termino de la izquierda hasta que no se pueda reducir mas
        hacer lo mismo con el termino de la derecha 
        y ver si llegan a una igualdad

    principio de induccion sobre numeros naturales
    si P(zero) y para todo n del tipo natural (P(n)=>succ(n))
                                                |       |
                                                V       V
                                                HI      TI
    entonces para todo n del tipo nat VALE P(n)
    HI: Hipotesis Inductiva
    TI: Tesis Inductiva
    EJEMPLO
        {S0} suma zero m=m
        {S1} suma Suc n = Suc (suma n m)

        para probar que para todo N del tipo natural suma n zero =n 
        basta probar:
        POR INDUCCIÓN sobre los naturales
        CB ZERO suma zero zero =zero
        HI suma suc n zero= suc n 

        CB VALE POR DEFINICIÓN
        HI suma n zero=n
        TI suma (suc n) zero =suc n 
        como probamos HI=>TI?
        (SUMA SUC N zero)= x S1 (suc suma n zero)=xHI (suc n)
    
    Inducción Estructural
    en el caso gral tenemos un tipo de caso inductivo con casos base y con casos inductivos
    principio de induccion estructural
    sea p una propiedad acerca de las expresiones tipo T tal que:
        -P vale sobre todos los constructores base de T 
        -P vale sobre todos los constructores recursivos de T, asumiendo como HI
         que vale para los parametros de tipo T 
    entonces para todo X del tipo T p(x)
    EJEMPLO
    data [a] = [] | a:[a]
    ¿Como sería el principio de inducción?
    si queremos que probar que para todo X del tipo lista de A vale 
    P(xs)

    por el principio de induccion estructural si P([]) y P(x:xs)
    entonces para todo xs del tipo [a] vale P(xs)
    CB []
    HI P(xs)
    TI P(x:xs)

    Ejemplo: principio de induccion sobre arboles binarios
    data AB a = NIl | Bin (AB a) a (AB a)
    Si P(Nil)
    y para todo arbol i,d del tipo AB a y para toda raiz r del tipo a 
    HI P(i) ^ P(d)
    TI Bin i r d
    HI=>TI
    Ejemplo: principio de induccion sobre polinomios 
    data Poli a = X | Cte a | Suma (Poli a) (Poli a) | Prod (Poli a) (Poli a)
    
    Si P(X) y para todo k del tipo a P(Cte k)
    y para todo i,d del tipo Poli A entonces P(i) ^ P(D) => P(suma i d)
    y para todo i,d del tipo Poli A entonces P(i) ^ P(D) => P(prod i d)
    entonces todo q del tipo Poli a entonces vale P(q)

    CB X Cte a 
    HI P(i) ^ P(d)
    TI Prod i d , Suma i d
    

    Ejemplo:induccion sobre listas

    map f [] = []   {M0}
    map f (x:xs) = f x:map f xs {M1}
    
    [] ++ ys =ys    {A0}
    (x:xs) ++ ys = x:(xs++ys)   {A1}

    propiedad si F a->b xs::[a] ys::[a] entonces
    map f (xs ++ ys) = map f xs ++ map f ys -----------> esto es P
    ¿Como hacemos esto?
    hacemos induccion estructural sobre xs 
    CB P([])
    HI P(XS)
    TI  P(x:xs)
    para todo x del tipo a, para todo xs del tipo [a] (P(xs)=>P(x:xs))

    RESOLUCIÓN
    CB 
    map f ([]++ys)=map f [] ++ map f ys
    map f []=[] x M0
    map f ([]++ys)= map f (ys) xA0
    -----------
    map f ys = map f ys
    son iguales!

    PASO INDUCTIVO
    para todo xs del tipo [a] para todo x del tipo a. P(xs)=>P(x:xs)

    map f (x:xs ++ys) = map f x:xs ++ map ys
    
    map f (x:xs ++ys)
    = map f (x:(xs++ys)) xA1
    = f x : map f (xs++ys) xM1
    = f x:(map f xs ++ map f ys) x HI
    = map f(x:xs) ++ map f ys xM1

    luego, probamos que los dos terminos son iguales 

    EJEMPLO
    Propiedad: si f::a->b->b z::b xs::[a]
    foldr f z xs = foldl (flip f) z (reverse xs) => P(xs)
    
    por induccion en la estructura de XS. el CB es facil 
    el caso inductivo es para todo x del tipo a para todo xs del tipo a HI=>TI
    foldr f z (x:xs)
    = f x (foldr f z xs) x def Foldr            {DEF FOLDR}
    = f x (foldl (flip f) z  (reverse xs))      {HI}
    = flip f (foldl (flip f) z (reverse xs)) x  {DEF FLIP}
    = foldl (flip f) z (reverse xs ++ [x])      (???) FALTA PROBAR EL LEMA
    = foldl (flip f) z (reverse (x:xs))

    LEMA si g::b->a->b z::b x::a xs::[a]
    dem: por INDUCCION en xd 
        
        CB 
        foldl g z ([]++[x]) = g (foldl g z []) x
        = foldl g z [xs]            por def 
        = foldl g (g z x) []        por def foldl
        = g z x                     por def foldl
        = g (foldl g z []) x        por def foldl

        PASO INDUCTIVO
        sup que foldl g z (ys++[x])= g (foldl g z ys) x
        Luego:
                foldl g z (y:ys)++[x])
                = foldl q z (y:ys++[x])         por def ++
                = foldl g (g z y) (ys++[x])     por def foldl
                            |   
                            V   
                            Z'               
                = g (foldl g (g z y) ys ) x     por HI
                = g (foldl g z (y:ys)) x        por def foldl

                qvq = g(foldl g z (y:ys)) x
        REVISION: P(xs): agregamos (para todo z del tipo b)


EXTENSIONALIDAD

Usando el principio de induccion estructural se puede probar

Extensionalidad para para pares
Si p::(a,b) entonces existe un x del tipo a x del tipo b tal que p=(x,y)

Extensionalidad para sumas
si e::Either a b entonces
o bien existe un x del tipo a tal que e= Left x
o bien existe un y del tipo b tal que e=Right y 

Puntos de vista intencional vs extensional? 
¿vale la equivalencia de expresiones?
    quicksort=insertionSort
punto de vista intencional dice que dos valores son iguales si estan definidos de la misma manera 
punto de vista extensional dice que dos valores son iguales cuando no los puedo distinguir al observarlos 
    propiedad inmediata: para todo valor de entrada de la funcion, si se cumple que f=g las podemos intercambiar
                        (f x = g x para todo x del tipo a )
    principio de extensionalidad funcional
        si para todo x del tipo a f x = g x entonces f = g
    EJEMPLO
    vamos que swap.swap = id :: (a,b)->(a,b)
    por extensionalidad funcional basta ver que:
    para todo p del tipo (a,b). (swap.swap) p = id p
    por induccion sobre pares basta ver que:
    para todo x del tipo a para todo y del tipo b. (swap.swap) (x,y) = id (x,y)
    luego aplicamos las definiciones y llegamos a demostrar la igualdad (ejercicio para el lector <3)


Razonamos ecuacionalmente usando tres principios
    PRINCIPIO DE REEMPLAZO 
    PRINCIPIO DE INDUCCION ESTRUCTURAL 
    PRINCIPIO DE EXTENSIONALIDAD FUNCIONAL 

supongamos que logramos demostrar que e1=e1
¿que nos asegura eso sobre e1 y e2?
podemos intercambiar las dos expresiones entre si
cualquier observacion que haga sobre e1 tendra que dar lo mismo sobre e2
CUIDADO: la igualdad extensional de funciones es mas grues que la igualdad intensional. Por ej 
         se puede demostrar:

         quickSort=insertionSort::[int]->[int]
         pero son algoritmos distintos 

¿como demostramos que NO vale una igualdad e1=e2::A?
cuando encontramos a un observador donde las dos funciones no sean iguales 
EJEMPLO
demostrar que NO vale la igualdad
id=swap ::(Int,Int)->(Int,Int)
la idea es llegar a un booleano para hacer la comparación 


ISOMORFIMOS DE TIPOS 
¿Que relacion tienen los siguientes valores?
("hola",(1,True))::(String,(Int,Bool))
((True,"Hola"),1)::((Bool,String),Int)
"Hay como una inyeccion entre estos dos datos"
representan la misma informacion pero escrita de distinta MANERA

podemos transformar los valores de un tipo en valores del otro!:D

podemos decir que dos tipo sde a y b son ISOMORFOS si 
1 hay una funcion F::A->B total
2 hay una funcion g::B->A total
3 se puede demostrar que g.f=id :: A->A
4 se puede demostrar que f.g=id :: B->B

Ejemplo 
veamos que ((a,b)->c) ~ (a->b->c)

QVQ
uncurry.curry = id
por extensionalidad funcional QVQ
para todo f::((a,b)->c). (uncurry.curry) f = id f ::(a,b)->c 
sea f::(a,b)->c y veamos que 
(uncurry.curry) f = id f ::(a,b)->c
(uncurry.curry) f = uncurry (curry f)       por DEF (.)
HACER LA EXTENSIONALIDAD OTRA VEZ   
por ext funcional, basta ver que
    para todo p del tipo (a,b). (uncurry.curry) f p = id f p
sea p::(a,b) veamos:
                    (uncurry.curry) f p = id f p::C
por induccion en p, basta ver que:
    forall x::A forall y:b  (uncurry.curry) f (x,y) = id f (x,y) ::C

sean x::a y::b luego 
    (uncurry.curry) f (x,y) = uncurry (curry f) (x,y)   PORDEF (.)
=   
-}
