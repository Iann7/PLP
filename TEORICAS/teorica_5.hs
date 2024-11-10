{-
INFERENCIA DE TIPOS 

compilacion -> como transcribir un programa equivalente a otro lenguaje 
no todo lenguaje tiene tipos
inferencia de tipos -> dado un programa sin tipo, recupera los tipos de cada parte del programa 

NOTACION    
    TERMINOS SIN ANOTACIONES DE TIPOS
        U:= x|lambda x.U| U U|True| False| if U then U else U 
    TERMINOS CON ANOTACIONES DE TIPOS
        M := 

    definicion:
        un termino U sin anotaciones de tipo es tipable sii existen:
            un contexto de tipado gamma
            un termino con anotaciones de tipos M 
            un tipo tau 
        tales que erase(M)=U y gamma|-M:tau
    
    el problema de inferencia de tipos consiste en 
        dado un termino U determinar si es tipable 
        en caso de que U sea tipable 
            hallar un contexto gamma, un termino M y un tipo tau 
            tales que erase(M)=U y gamma|-M:tau 
    
    Inferencia de tipos 
        el algoritmo se aasa en manipular tipos parcialmente conocidos 
        Ejemplo-tipos parcialmente conocidos 
            en X True sabemos que X:bool->X1
            en if x y then true else false sabemos que x:X2->Bool
        incorporamos INCOGNITAS (x1,x2,...,xn) a los tipos
        Vamos a necesitar resolver ecuaciones entre tipos con incognitas
    
    EJEMPLOS
    (x1->Bool) = ((Bool->Bool)->x2)
    tiene solucion, x1=bool->bool,x2=Bool
    x1->x1=((bool->bool)->x2)
    tiene solucion x1=(bool->bool) x2=(bool->bool)
    x1->bool=x1
    ABSURDO




























-}