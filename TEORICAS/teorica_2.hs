{-
HOY VAMOS A VER INTERPRETES
SINTAXIS CONCRETA VS SINTAXIS ABSTRACTA
    El interprete recibe como entrada un dato que representa un programa escrito en lenguaje fuente
    -Sintaxis concreta: se puede representar un programa como una cadena de texto 
        EJ : "while (true) {x=x+1}"::String

    -Sintaxis abstracta
        Se puede representar un programa como un arbol de sintaxis 

    Representaremos programas como arboles de sintaxis abstracta
    convertir la sintaxis concreta en sintaxis abstracta
    es un problema de ANALISIS SINTACTICA (queda fuera del alcance de la materia)    

   Lenguaje de expresiones aritmeticas 
   consideremos un lenguaje de expresiones aritmeticas construidas inductivamente de la siguiente manera 
    1 Una constante entera es una expresion
    2 la suma de dos expresiones es una expresion

    dat val = VN Int | VB Bool
            
    addVal::val->val
    addVAl (VN n) (VN n) = VN (n+m)
    addVal _ _ = error "NO SE PUEDEN SUMAR DOS COSAS QUE NO SEAN NUMEROS"
    -- otra linea para handlear error

    data expr = EConst Int | EAdd expr expr 
    eval::Expr->Val 
    eval (EConstNum n) = VN  n
    eval (EConstBool) b = VB b 
    eval (EAdd e1 e2) = addVal (eval e1) (eval e2)
    ¿Podemos extender el lenguaje agregando constantes booleanas?

    QUEREMOS EXTENDER EL LENGUAJE CON DEFINICIONES LOCALES
        let x=3 in (let y=x+x in 1+y)
        necesitamos mantener registro del valor que tiene cada variable
    Entorno
        un entorno es un diccionario que asocia identificadores a valores

        vamos a suponer que contamos con tipos:
            ID identificadores (nombres de variables)
            (Env a) entonrnos que asocian identificadores a valores de tipo a 

        y la siguiente interfaz
            emptyEnv ::Env a
            lookupEnv::Env a->Id->a
            extendEnv::Env a->Id->a->Env a

data Expr = EconstNum Int 
                | EconstBool Bool
                | EAdd Expr Expr 
                | EVar Id 
                | ELet Id Expr Expr 

    ¿Cual es el resultado de evaluar (EVar "x")?
        el interprete ya no es una funcion eval::expr->val
        si no que tambien devuelve un entorno 

    Comentario
        en el lenguaje con declaraciones locales, una expresion no denota un valor si no una 
        funcion que devuelve un valor en funcion del entorno no dado 
    
    Queremos tener asginaciones/caracteristicas imperativas 
        1 asignaciones x:=e 
        2 composicion secuencial 
    
        vamos a suponer que
            1 el valor de la asignacion es 0 
            2 la semantica de la composicion e1;e2 corresponde a evaluar primero e1, descartando su valor y a continuación
              evaluar e2 

        Variables inmutables
            en un lenguaje puramente funcional, las variables son INMUTABLES
            el entonrno asocia cada variable directamente a un valor
        
        Variables mutables 
        en un lenguaje imperativo, las variables son tipicamente mutables
            - El entorno NO asocia cada variable a un valor 
            - El entorno asocia cada variables a una DIRECCION DE MEMORIA 
            - Ademas hay una memoria que asocia direcciones a valores 
        
        MEMORIAS    
            una memoria es un diccionario que asocia direcciones a valores 
                ADDR direcciones de memoria
                (Mem a) memorias que asocian direcciones a valores de tipo a

            y la siguiente interfaz 
                EmptyMem::Mem a
                freeAddress::Mem a->Addr
                load::Mem a-> Addr -> a
                store::Mem a->Addr->a->Mem a 
      
    Problema 
    El resultado de evaluar una asigancion (x:=e) no puede ser solo un valor 
    (considerar p.ej let x=1 in x:=2;x)

    eval:: Expr -> Env addr 
           -> Mem Val -> (val,mem val)

    CALCULO LAMBDA
    casi todos los lenguajes funcionaels estan basados en el calculo lambda 
    data Expr = EVar id         --x
                |ELam Id Expr   --\x->e
                |EApp Expr Expr --e1 e2

    es posible programar utilizando SOLO estas construcciones
    pero vamos a EXTENDER el calculo lambda para que sea mas comodo y se
    asemeje a un lenguaje realista 


    

CALL BY NAME VS CALL BY VALUE -- ESTRATEGIAS DE EVALUACION
    hay distintas tecnicas para evaluar una aplicacion (e1 e2)
    estas tecnicas se conocen como estrategias de evaluacion 

    Llamada por valor  (call by value)
        se evalua e1 hasta que sea una clausura 
        ** se evalua e2 hasta que sea un valor 
        se procede con la evaluacion del cuerpo de la funcion 
        el parametro queda ligado al valor de e2 

    Llamada por nombre (call by name)
        se evalua e1 hasta que sea una clausura 
        ** se procede DIRECTAMENTE a evaluar el cuerpo de la funcion 
        el parametro queda ligado a e2 SIN EVALUAR 
        Cada vez que se usa el parametro, se valua la expresion e2 

    Llamada por necesidad(call by need)
        para evaluar una aplicacion (e1 e2)
            se evalua e1 hasta que sea una clausura
            se procede directamente a evaluar el cuerpo de la funcion 
            el parametro queda ligado a la expresion e2 sin evaluar 
            **la primera vez que el parametro se necesita, se evalua e2
            se guarda el resultado para evitar e2 nuevamente
            PARA ESTO SE NECESITA CONTAR CON UNA MEMORIA MUTABLE 


    Interprete call by name
        al evaluar (let x=e1 in e2) se evalua directamente e2 
        la variable x queda ligada a una copia no evaluada de e1 
            
        los entornos NO asocian identificadores a valores 
        los entornos asocian identificadores a thunks 
    
    HAY PROGRAMAS QUE EN CALL BY VALUE CORTAN Y EN CALL BY NAME NO 
    
    THUNK
        un thunk es un dato que incluye 
        1 una expresion no evaluada
        2 un entorno que le da valor a sus varianles libres 

        los thunks y valoers se definen del siguiente modo
            data Thunk = TT Expr (Env Thunk)
            data Val = VN Int 
                        | VB Bool
                        | VClosure Id Expr (Env Thunk)

    propiedades de la evaluacion call by need (CBN)

    LOS VALORES PUEDEN SER VALORES FINALES O THUNKS 
    
    NO DETERMINISMO  

    EFECTOS 
        el operador de division falla si el divisor es 0 
        la estructura de control (Try e1 else e2) vealua e1 y en caso de falla 
        procede a evaluar e2 

        como hacemos que permita ese error y se recupere del misomo? 
            eval:: Exp -> Env Int -> Mabe Int 
            data Maybe a = Nothing | Just a 
            
-}