{-
  QVQ curry . uncurry = id
  por EXT FUNCIONAL esto equivale 
    para toda F:: a->b->c. (curry.uncurry) f = id f 
    hay muchas formas de probar igualdad, podemos reducir un termino para llegar al otro
    podemos reducir los dos y llegar a lo mismo, yara yara 


    (curry.uncurry) f =_comp curry (uncurext funcionalry f) 
    =_u     curry(\(x,y)-> f x y)
    =_c     (\x' y'->(\(x,y)->f (x',y'))) (x',y')
    =_Beta  (\x' y' -> f x' y') (x' y')
    =_n     (\x' -> f x' y') (x')
    =_n     f x' y'

  ...............QED............................................

  --------------------------------------------------------------

  Ej 2 
      \forall p::either Int (Int,Int) \forall q:: Either Int (int,int)
      QVQ prod p q = prod qp 
      POR EXTENSIONALIDAQD SOBRE EITHER/SUMA/UNION DISJUNTA TENEMOS CUATRO CASOS      


      QVQ \forall p::Either Int (Int,Int) \forall::Either Int (Int,Int) p q = prod q p
        POR EXTENSIONALIDAD DE EITHER HAY 4 CASO S
          por ext Either Int (Int,Int), podemos usar extendionalidad de pares y los casos son 
            1 P=Left m, Q=left n con m::Int,n::Int 
            2 P=Left m, Q= Right (x,y)
            3 P= right (x,y), Q= right (a b)
            4 P= right (x,y), Q= left a 

        ahora que mostramos la ext de pares tenemos que mostrar cada paso 
          CASO 1 
            prod p q = prod (left n) (left n) =_{p0} Left (n*m)
            =_INT Left (m*n)
            =_{p0} prod (left n) (left m)
          
          CASO 2
            prod p q =  prod (Left m) (Right (y,z))
            =_{p1}      right ((m*y),(m*z))
            =_int       Right ((y*m),(z*m))
            =_p2        prod  (Right(y,z)) (Left m) =_1 prod q p

          CASO 3
          MUY PARECIDO AL 2, GABI NOS LOS DEJO DE TAREA <3           

          CASO 4
            Prod (Right (w,x)) (Right (y,z)) 
            =_p3    Left (y*w + x*z)
            =_int   Left (w*y + z*x)
            =_p3    Prod (Right (y,z)) (Right (w,z)) = prod q p QED  

  EJ 3 
    Demostrar la siguiente propiedad 
    \forall c::Conj a. \forall d::Conj a . interseccion  c (diferencia c d) = vacio
    interseccion d (diferencia c d) 
    =_d interseccion d (\e-> ce && not d e) 
    =(\x->dx && (\e-> c e && not de)) x
    =_b \x-> dx &&   c x && not (d x)
    =_bool \x->false
    =_v vacio

  induccion sobre naturales
    probar p(0)
    pruebo que si vale p(n) vale p(n+1)
    induccion estrucural sobre los naturales

  Induccion estrucutral general
    pruebo los casos base
    pruebo que si vale P(arg1)->P(argN)
    vale P(C arg1..argk)
  
  pasos a seguir
    Leer la propiedad entenderla y convencerse de que es true
    plantear la propiedad como predicado unario
    plantear el esquema de inducción
    plantear casos bases
    plantear casos inductivos
  
  EJ 4
    QVQ length 1 = length 2                   por ext funcional esto equivale a 
    \forall ys::[a].length 1 ys = length2 ys  usamos induccion en ys 
    
    caso ys=[]
      length1 []=0  {lado izquierdo}
      length2 []= (foldr (\ _ res ->1+res)0) [] =f0 0  {lado derecho}
      0=0 
    
    caso ys=x:xs
    HI:   P(xs) = length1 xs = length2 xs
    QVQ:  P(ys) = length1 (x:xs) = length2 (x:xs)
    {lado derecho}    length1 (x:xs) =_L11 1 + length1 xs =_HI 1+length2 xs 

    {lado izquierdo}  length2 (x:xs) =_L2 (foldr (\_ res-> 1+res)0) (x:xs)
    =_F1  (\_ res->1+res) x (foldr (\_ res->1+res) 0 xs)
    =     F x (length 2 xs) 
    =_maxB   (\res->1+res) (length2 xs) 
    =_B   1+length2 xs 
    ----------------------------------QED ------------------------------

    EJ5 
    
    QVQ  Ord a⇒∀ e::a . ∀ ys::[a] . (elem e ys ⇒ e ≤ maximum ys)
    en que estructura vamos a hacer recursion? sobre la lista 
    CB []
    HI P(XS)
    QVQ P(X:XS)

    si no vale ord a la implicacion de afuera es trivialmente verdadera
    (recordar que las implicaciones asocian a derecha) daemas si vale ORda a, tambien vale
    Eq a (por la jerarquia de clases de tipos en haskell)

    P(ys) \forall e::a. elem e ys => e <= maximum ys
    ord a vale por diapositiva

    CASO YS=[]
      elem e [] => e<= maximum []
      =_E0  false=e<=maximum []
      el antecedente es falso por ende toda la implicacion es verdadera       
    
    CASO YS= X:XS HI=P(xs)
      elem e (x:xs) => e<= maximum (x:xs)
      =_e1 (e==x)|| eleem e xs => e<= maximum (x:xs)
      AHORA NO PODEMOS HACER REEMPLAZO, NO PODEMOS HACER HI
      QUE HACEMOS?
      EXTENSIONALIDAD!!!!
      por extensionalidad de listas   xs=[] || xs=x:xs
      1 xs=[]
          e==x || elem e [] => e<= maximum [x]
          e==x => e<=x 
          =_ordA true  
      2 xs=z:zs
        (e==x || elem e z:zs) => e<= maximum (x:z:zs)
        por extensionalidad de bool  e==x && true || false 
        caso true
          true || elem e z:zs => e<= maximum (x:z:zs)
          =_bool a<= maximum (x:z:zs)
          =_?? (if x<maximum (z:zs) then maximum(z:zs) else x)
          por ext bool x<maximum(z:zs) es T o F 
            CASE TRUE 
              E<= MAXIMUM (z:zs) pero e=X y 
              x<maximum(z:zs)=> e<= maximum(z:zs)

            CASO FALSE 
              false || elem e (z:zs)=>e<=maximum(x:z:zs)
              =_bool  elem e(z:zs)=> e<= maximum (x:z:zs0
              POR HI ELEM e (z:zs) => e<= maximum (z:zs) 
              por transitividad d=> basta con ver que 
              maximum (z:zs) <= maximum (x:z:zs)
                LEMA  
                    FORALL XS::[a] maximum xs<= maximum(x:xs) para cualquier x::a
                    TAREA RESOLVER ESTE LEMA TODO
              por lema vale 
              QED 

  EJ 5  queremos probar que 
      ∀ ys::[a] . length ys = length (reverse ys)      
      P (ys) = length ys = length (foldl (flip (:)) [] ys)
      HI = length xs = length (foldl (flip (:)) [] xs)
      pero necesitamos 1 + len ...
      el objetivo: probar una propiedad mas general 
      PROBEMOS
        ∀ ys::[a].∀ zs::[a].length zs+length ys =length (foldl (flip (:)) zs ys)
        ZS =[]
        LENGTH [] = 0

        CASO YS = []
        {lado izq} len [] =_l0 0
        {lado der} len (foldl (flip (:)) []) [] = length (foldl flip (:)) (x:[]) xs) 
        ------------------------------------------------
          LEMA
            \forall ys::[a] \forall ac::[a] length ac + length ys = length (foldl (flip(:)) ac ys)
            INDUCCION EN YS. P(ys) = yara yara 
              caso ys=[]
                len (foldl (flip (:)) ac []) =_f0 len ac 
                len ac + len [] =_l0 len ac + 0 = len ac 
              CASO YS=X:XS
                len ac + len(x:xs) =_l1 len ac +1 + len xs 
                len (foldl flip (.) ac (x:xs)) =_f1
                len (fodll flip(:) (x:ac) xs) =_hi
                len (x:ac) + len xs 
                =_l1 1+ len ac + len xs 
                =_int len ac +1 + len xs 
        ------------------------------------------------
      QVQ \forall ys::[a] len ys = len (foldl (flip (:)) [] ys)
      =por lema con ac=[]
      {LADO DERECHO}    = len[] + len ys = 0 + len ys = len ys 
      {LADO IZQUIERDO}  = ??? 
  EJ 6 
    TAREA HACER FLIP TAKE
    tenemos una lista y tenemos un integer 
    en que conviene hacer una recursion? en las dos
    pero a ojo pareciera que convien hacerlo por lista 
  
  EJ 7
  qvq ∀ t::AB a . cantNodos t = length (inorder t)
  INDUCCION EN ARBOLES (T)
  caso t=Nil
    cantNodos Nil = len (inorder Nil)
    {LADO DERECho} =_{CNO} 0
    {LADO IZQUIERDO} =_{IO} len []
    {LADO IZQUIERDO} =_{L0} 0
    0=0 QED
  CASO t= Bin i r d 
  HI P(i) && P(d) (cantNodos i = len (inorder i)) yara yara 
  {LADO IZQ} cantNodos (Bin i r d) = 1 + cantNodos i + cantNodos d 
            = 1 + len (inorder i) + len (inorder d) 
            = len (inorder i) + (1+len(inorder d))
            = len (inorder i) + len(r:inorder d)
            =_lema len(inorder i ++ (r:inorder d)
  {LADO DER} len (inorder (Bin i r d))= len(inorder i ++ r:inorder d)
  GANAMOS! ahora falta probar el lema

  LEMA \forall ys::[a] \forall xs::[a] 
      len ys + len xs = len (ys++xs)
      TODO PROBAR LEMA 
  

  ARBOL23 ab p(q)
  caso q = Hoja x
  caso q = Dos raiz primero segundo | HI = P(primero) &&  P(segundo)
  
-}        