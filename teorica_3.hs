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

-}
