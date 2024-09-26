{-
EJERCICIO 1 
Sean las siguientes deiniciones de funciones:
    - intercambiar (x,y) = (y,x)
    - espejar (Left x) = Right x
    espejar (Right x) = Left x
    - asociarI (x,(y,z)) = ((x,y),z)
    - asociarD ((x,y),z)) = (x,(y,z))
    - flip f x y = f y x
    - curry f x y = f (x,y)
    - uncurry f (x,y) = f x y



EJERCICIO 2 
Demostrar las siguientes igualdades utilizando el principio de extensionalidad funcional 
    i. flip . flip = id
    ii. ∀ f::(a,b)->c . uncurry (curry f) = f
    iii. flip const = const id
    iv. ∀ f::a->b . ∀ g::b->c . ∀ h::c->d . ((h . g) . f) = (h . (g . f))
    con la definición usual de la composición: (.) f g x = f (g x).

    i flip.flip = id
        por principio de extensionalidad funcional sabemos que si cumple
        \forall f::(a->b->c)  flip.flip = id 
        entonces vale 

        (flip.flip) f x y = id f x y 

        {LADO IZQUIERDO}
                        = flip (flip f x y) {def .}
                        = flip f y x        {def flip}
                        = flip f x y        {def flip}
                        
        {LADO DERECHO} =_id0 f x y 
        AMBOS LADOS SON IGUALES => QED

    ii ∀ f::(a,b)->c . uncurry (curry f) = f
        por principio de extensionalidad funcional basta ver que
            ∀f::(a,b)-> ∀t::(a,b)
            uncurry (curry f) p = f p
        por principio de extensionalidad de pares basta ver que
            ∃x :: a. ∃y :: b. t = (x,y)

        uncurry (curry f) (x,y) = f (x,y)
        {LADO IZQUIERDO}
            uncurry (curry f) (x,y)
            uncurry f x y   {def uncurry}
            f (x,y)         {def curry}
        
        AMBOS LADOS QUEDAN IGUALES => QED

    iii  flip const = const id
    por ext de funciones 
        flip const x y  = ((const id x) y) 
        const y x = id y
        y = y

    iv ∀ f::a->b . ∀ g::b->c . ∀ h::c->d . ((h . g) . f) = (h . (g . f))
        por ext de funciones
        ((h . g) . f) x = (h . (g . f)) x
        {LADO IZQUIERDO}
        ((h . g) (f x))     {def .}
        (h (g(f(x))))       {def .}
        (h (g.f) x)         {def .}
        (h.(g.f)) x         {def .}

        QED?
        DUDA

EJERCICIO 3 
Considerar las siguientes funciones:
    length :: [a] -> Int
    {L0} length [] = 0
    {L1} length (x:xs) = 1 + length xs
    
    duplicar :: [a] -> [a]
    {D0} duplicar [] = []
    {D1} duplicar (x:xs) = x : x : duplicar xs
    
    append :: [a] -> [a] -> [a]
    {A0} append [] ys = ys
    {A1} append (x:xs) ys = x : append xs ys
    
    (++) :: [a] -> [a] -> [a]
    {++} xs ++ ys = foldr (:) ys xs
    
    ponerAlFinal :: a -> [a] -> [a]
    {P0} ponerAlFinal x = foldr (:) (x:[])

    reverse :: [a] -> [a]
    {R0} reverse = foldl (flip (:)) []

    Demostrar las propiedades 

    i. ∀ xs::[a] . length (duplicar xs) = 2 * length xs
    ii. ∀ xs::[a] . ∀ ys::[a] . length (append xs ys) = length xs + length ys
    iii. ∀ xs::[a] . ∀ x::[a] . [x]++xs = x:xs
    iv. ∀ xs::[a] . ∀ f::(a->b) . length (map f xs) = length xs
    v. ∀ xs::[a] . ∀ p::a->Bool . ∀ e::a . ((elem e (filter p xs)) ⇒ (elem e xs)) (asumiendo Eq a)
    vi. ∀ xs::[a] . ∀ x::a . ponerAlFinal x xs = xs ++ (x:[])
    vii. reverse = foldr (\x rec -> rec ++ (x:[])) []
    viii. ∀ xs::[a] . ∀ x::a . head (reverse (ponerAlFinal x xs)) = x

    i ∀ xs::[a] . length (duplicar xs) = 2 * length xs
    para probar esta igualdad necesitamos ver que vale para todo valor de XS
    por ende hacemos induccion sobre listas
    CB=[]
        len (duplicar []) = 2*len[]
        {LI}
            len ([])    {D0}
            0           {L0}
        {LD}
            2*0         {L0}
            0           {int}
        QED
    PASO INDUCIVO
        qvq len (duplicar x:xs) = 2*len(x:xs)
        HI  len (duplicar xs) = 2*len(xs)
        {LADO IZQUIERDO}
            len (x:x:duplicar xs) {D1}
            2+ len duplicar xs {L2*2}
        {LADO DERECHO}
            2*(1+len xs)    {L2}
            2 + 2*len xs      {INT}

        POR ENDE TENEMOS
             2 + len duplicar xs = 2 +  2*len xs
             len duplicar xs = 2*len xs {x INT}
             ESTO VALE POR LA HI
             QED
              
    
    ii. ∀ xs::[a] . ∀ ys::[a] . length (append xs ys) = length xs + length ys
    para probar esta igualdad necesitamos probar que vale para todos los valores de XS e YS
    vamos a dejar YS constante para hacer induccion sobre XS 

    CB=[]
    len (append [] ys) = len [] + len ys
    len (ys) = 0 + len ys
    len (ys) = len ys 
    QED 

    PASO INDUCTIVO
    QVQ len (append x:xs ys) = len x:xs + len ys
    HI  len (append xs ys) = len xs + len ys
    {LADO IZQUIERDO}
        len (x:append xs ys)    {A1}
        1 + len(append xs ys)   {L1}
    {LADO DERECHO}
        1+ len xs + len ys      {L1}

    1 + len(append xs ys)=1+ len xs + len ys
    VALE X HI? DUDA 

    iii ∀ xs::[a] . ∀ x::a . [x]++xs = x:xs
        CB=[]
            {LI}
                foldr (:) [] [x] {++}
                [x]              {foldr_0}
            {LD}
                [x]             {(:)_0}
            -------QED...............
        PASO INDUCTIVO  
            QVQ [x]++z:zs = x:z:zs
            HI  [x]++zs = x:zs
            {LI}
                x:([]++z:zs) {++_1}
                x:(z:zs) {++_0}
            QED?
            DUDA TODO
    
    iv  ∀ xs::[a] . ∀ f::(a->b) . length (map f xs) = length xs
    induccion sobre XS
    CB=[]
        len (map f []) = len []
        len ([])  = 0
        0=0
    PI
        QVQ length (map f x:xs) = length x:xs
        HI  length (map f xs) = length xs
        {LADO IZQUIERDO}
            length (map f x:xs)
            length (f x : map f xs)
            1 + len(map f xs) 
        {LADO DERECHO}
            len x:xs
            1+len xs
        QED?
        
    v. ∀ xs::[a] . ∀ p::a->Bool . ∀ e::a . ((elem e (filter p xs)) ⇒ (elem e xs)) (asumiendo Eq a)
        INDUCCION SOBRE XS
        CB=[]
            {li}
                ((elem e (filter p []))
                elem e []
                false
            el antecedente es falso por ende toda la implicacion es verdadera
            
        PASO INDUCTIVO                 
            ((elem e (filter p x:xs)) ⇒ (elem e x:xs))
            {ANTECEDENTE}
                elem e (if p x then x:xs else filter p xs) {def filter_1}
            {CONSECUENTE}
                if e==x then true else elem e xs {def elem_1} 

            CASO ANTECEDENTE FALSO => VERDADERO
            CASO ANTECEDENTE VERDADERO => CONSECUENTE TIENE QUE SER VERDADERO

            CASO p x = TRUE ( if e==x then true else elem  e filter p xs)

               

                CASO E==X
                    {consecuente}
                        if e==x then true else elem e xs 
                        true {ift}
                CASO elem e filter p xs 
                    {consecuente}
                        filter p xs=>elem e xs {VALE POR HI}

            CASO p x = FALSE (elem e filter p xs)
                {consecuente}
                        filter p xs=>elem e xs {VALE POR HI}
    
     vi. ∀ xs::[a] . ∀ x::a . ponerAlFinal x xs = xs ++ (x:[])
     
        vamos a probarlo por induccion estructural
        (si vale para el caso base y recursivo de la lista, la igualdad vale)

        CB=[]
             foldr (:) (x:[]) [] = foldr (:) [x] []
             son el mismo termino
             QED

        PASO INDUCTIVO 
            HI= ponerAlFinal x bs = bs ++ (x:[])
            QVQ = ponerAlFinal x b:bs = b:bs ++ (x:[])
            {li}
                ponerAlFinal x b:bs
                foldr (:) (x:[]) b:bs {P0}
                (:) b (foldr (:) [x] bs) {foldr}
            {ld}
                b:bs ++ (x:[])
                foldr (:) ([x]) b:bs {++}
                (:) x (foldr (:) [x] bs) {foldr} 

            OBSERVO QUE REDUCEN A LA MISMA FUNCION
            QED?
            duda 
        vii. reverse = foldr (\x rec -> rec ++ (x:[])) []
                por ext de funciones tenemos que ver que vale
                para toda lista de 

                por induccion en listas, si vale en el cb y en el paso inductivo vale para todas

                CB=[]
                    reverse [] = foldr (\x rec -> rec ++ (x:[])) [] []
                    {LI}
                        reverse [] 
                        foldl (flip (:)) [] []
                        [] {foldl_0}
                    {LD}
                       foldr (\x rec -> rec ++ (x:[])) [] []
                       []   {foldr_0}

                    QED

                PASO INDUCTIVO
                    QVQ reverse [] (x:xs) = foldr (\x rec -> rec ++ (x:[])) [] (x:xs)
                    HI  reverse [] (xs) = foldr (\x rec -> rec ++ (x:[])) [] (xs)
                    {LI}
                        reverse [] (x:xs)
                        foldl (flip (:)) [] (x:xs)
                        foldl (flip (:)) ((flip (:)) [] x)) xs
                        foldl (flip (:)) [x] xs
                        
                    {LD}
                        foldr (\x rec -> rec ++ (x:[])) [] (x:xs)
                        (\x rec -> rec ++ (x:[])) x (foldr (\x rec->...) [] xs) 
                        rec ++ (x:[])
                            where rec=(foldr (\x rec->...) [] xs) 

                        por lo visto en clase vale por la propiedad 
                        foldr f z xs = foldl (flip f) z (reverse xs)

EJ 5 
Dadas las siguientes funciones:
    zip :: [a] -> [b] -> [(a,b)]
    {Z0} zip = foldr (\x rec ys ->
    if null ys
    then []
    else (x, head ys) : rec (tail ys))
    (const [])

    zip' :: [a] -> [b] -> [(a,b)]
    {Z'0} zip' [] ys = []
    {Z'1} zip' (x:xs) ys = if null ys then [] else (x, head ys):zip' xs (tail ys)

    Demostrar que zip = zip' utilizando inducción estructural y el principio de extensionalidad.

    por el principio de induccion funcional tenemos que ver que 
    \forall xs \forall ys se cumple que zip xs ys = zip' xs ys
    como trabajamos sobre listas procedemos a hacer induccion estructural sobre una de ellas


    CB XS=[]
        zip [] ys = zip' [] ys 
        {LI}
            zip [] ys 
            foldr (\x rec ys ->if null ysthen [] else (x, head ys) : rec (tail ys)) (const []) [] {ZIP}
            []                                                                                    {FOLDR_0}
        {LD}
            zip' [] ys
            []      {z'0}
        QED

    PASO INDUCTIVO
    QVQ zip x:xs ys = zip' x:xs ys 
    HI  zip' xs ys = zip' xs ys
    {LADO IZQUIERDO}
        zip x:xs ys
        foldr (\x rec ys ->if null ys then [] else (x, head ys) : rec (tail ys)) (const []) (x:xs) {ZIP}
        (\x rec ys ->if null ys then [] else (x, head ys) : rec (tail ys))  (x:xs)                 {foldr_1}
        if null ys then [] else (x,head ys):rec (tail ys)
    {LADO DERECHO}
        zip' x:xs ys 
        if null ys then [] else (x, head ys):zip' xs (tail ys) {z'1}
    
    CASO NULL YS =TRUE
        {LI}
        []
        {LD}
        []
        QED
    CASO NULL YS =FALSE
        {LI}
            (x,head ys):rec (tail ys)
        {LD}
            (x,head ys):zip' xs (tail ts)
        por HI podemos cambiar rec rail ys 
        por zip' xs (tail ts )
        luego queda demostrado 

EJ 6
nub :: Eq a => [a] -> [a]
{N0} nub [] = []
{N1} nub (x:xs) = x : filter (\y -> x /= y) (nub xs)

union :: Eq a => [a] -> [a] -> [a]
{U0} union xs ys = nub (xs++ys)

intersect :: Eq a => [a] -> [a] -> [a]
{I0} intersect xs ys = filter (\e -> elem e ys) xs

Indicar si las siguientes propiedades son verdaderas o falsas. Si son verdaderas, realizar una demostración. Si
son falsas, presentar un contraejemplo.

i. Eq a => ∀ xs::[a] . ∀ e::a . ∀ p::a -> Bool . elem e xs && p e = elem e (filter p xs)
como queremos que probar que vale para todo xs vamos a hacer induccion sobre listas sobre el 
necesitamos probar el caso base xs=[] y el caso inductivo x:xs
CB
elem e [] && p e = elem e (filter p [])
false && p e = elem e []
false =false 
qed 
PASO INDUCTIVO 
QVQ elem e x:xs && p e = elem e (filter p x:xs)
HI  elem e xs && p e = elem e (filter p xs)
{LI}
    (if e==x then true else elem e xs) && p e
{LD}
    elem e (filter p x:xs)
    elem e (if px then x:xs else xs)
    por ext de bool
    px=true
        elem e x:filter p xs
        if e==x then true else else filter p xs 
        por ext de bool
            caso e==x
                true
            caso e!=x
                vale por HI 
                
    es muy parecido para el lado izquierdo 
    QED 
ii. Eq a => ∀ xs::[a] . ∀ e::a . elem e xs = elem e (nub xs)

iii. Eq a => ∀ xs::[a] . ∀ ys::[a] . ∀ e::a . elem e (union xs ys) = (elem e xs) || (elem e ys)

iv. Eq a => ∀ xs::[a] . ∀ ys::[a] . ∀ e::a . elem e (intersect xs ys) = (elem e xs) && (elem e ys)
    vamos a hacer ind estructural bajo xs 
    cb 
    elem e (intersect [] ys) = elem e [] && elem e ys
    false = false && elem e ys
    false = false
    paso inductivo 
    QVQ elem e (intersect x:xs ys) = (elem e x:xs) && (elem e ys)
    HI elem e (intersect x:xs ys) = (elem e x:xs) && (elem e ys)
    {LI}
        elem e (filter (\e -> elem e ys) x:xs)
        elem e (if elem x ys then x:filter (...) xs else filter(...) xs)
        ext de booleanos 
        caso elem x ys =true 
            elem e x:filter(...) xs
                e==x=true 
                    vale trivialmente 
                e==x=false
                    vale por HI 
        caso elem x ys =false
            elem e filter (...) xs 
            vale x HI 
        lo mismo para el lado derecho 
v. Eq a => ∀ xs::[a] . ∀ ys::[a] . length (union xs ys) = length xs + length ys

vi. Eq a => ∀ xs::[a] . ∀ ys::[a] . length (union xs ys) ≤ length xs + length ys





Ejercicio 9 
Dadas las funciones altura y cantNodos definidas en la práctica 1 para árboles binarios, demostrar la
siguiente propiedad:
∀ x::AB a . altura x ≤ cantNodos x
data AB a = Nil | Bin (AB a) a (AB a)

    altura::AB a->Integer 
    altura = foldAB 0 (\i _ d->1+(max i d))   {ALTURA}

    cantNodos::AB a -> Int 
    CantNodos = foldAB 0 (\ri _ rd -> 1+ri+rd) {CANTNODOS}

    para probar que la desigualdad vale necesitamos probar que vale para todos 
    los x

    como x es un tipo con un constructor recursivo y un constructor base, 
    voy a aplicar induccion estructural sobre x 

    CASO BASE x=Nil 
        altura Nil ≤ cantNodos Nil
        {LI}
            altura Nil
            foldAB 0 (\i d->1+(max i d))  Nil {ALTURA}
            0                                 {cNil}
        {LD}
            cantNodos Nil
            foldAB 0 (\ri v rd -> 1+ri+rd)    {CANTNODOS}
            0                                 {cNil}

        luego, el caso base queda demostrado

    PASO INDUCTIVO
    QVQ altura Bin i r d  ≤ cantNodos Bin i r d 
    HI P(i) && P(d)
    {LI}
         altura Bin i r d 
         foldAB 0 (\i _ d->1+(max i d)) (Bin i r d)   {ALTURA}
         (\i _ d->1+(max i d)) (rec i) r  (rec d)     {foldAB_1}
            where rec =foldAB 0 (\i _ d->1+(max i d))
         1+(max (rec i) (rec d))                      {APP}


    {LD}
        cantNodos Bin i r d 
        foldAB 0 (\ri _ rd -> 1+ri+rd) (Bin i r d)  {CANTNODOS}
        (\ri _ rd -> 1+ri+rd) (rec i) r (rec d)     {foldAB_1}
            where rec = foldAB 0 (\ri _ rd -> 1+ri+rd)
        1+(rec i)+(rec d)                           {APP}

    nos queda que 
    1+(max (rec i) (rec d))<=1+(rec i)+(rec d)   
    por propiedades de int nos queda siempre estrictamente menor
    luego queda demostrado 

Ejercicio 12 F
Dados el tipo Polinomio definido en la práctica 1 y las siguientes funciones:
derivado :: Num a => Polinomio a -> Polinomio a
derivado poli = case poli of
X -> Cte 1
Cte _ -> Cte 0
Suma p q -> Suma (derivado p) (derivado q)
Prod p q -> Suma (Prod (derivado p) q) (Prod (derivado q) p)
sinConstantesNegativas :: Num a => Polinomio a -> Polinomio a
sinConstantesNegativas = foldPoli True (>=0) (&&) (&&)
esRaiz :: Num a => a -> Polinomio a -> Bool
esRaiz n p = evaluar n p == 0
Demostrar las siguientes propiedades:
i. Num a => ∀ p::Polinomio a . ∀ q::Polinomio a . ∀ r::a . (esRaiz r p ⇒ esRaiz r (Prod p q))
ii. Num a => ∀ p::Polinomio a . ∀ k::a . ∀ e::a .
evaluar e (derivado (Prod (Cte k) p)) = evaluar e (Prod (Cte k) (derivado p))
iii. Num a => ∀ p::Polinomio a. (sinConstantesNegativas p⇒sinConstantesNegativas (derivado p))
La recursión utilizada en la denición de la función derivado ¾es estructural, primitiva o ninguna de las dos?
    
    
    
    
    
    
    
    
-}                  


