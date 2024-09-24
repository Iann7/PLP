{-
CALCULO LAMBDA 
    lenguaje de programacion definido de 
    manera rigurosa(matematica) 

    se basa en DOS operaciones
        - Construir funciones
        - Aplicarlas 

    Historicamente
        Concebido en la decada de 1930 por
        Alonzo Church para formalizar 
        la noción de función efectivamente computable 

        Usado desde la decada de 1960 para estudiar 
        semantica formal de lenguajes de programción 

        intentar explicar algol en terminos de calculo 
        lambda 

    Actualmente 
        nucleo de lenguajes de programación funcionales 
        y asistentes de demostración

        LISP,OCAML,HASKELL,COQ,AGDA,LEAN,....

        Laboratorio para investigar nuevas caracteristicas 
        de logica,categoria,etc.

    Sintaxis y tipado
        λ
        Sintaxis de los tipos
            tau,sigma,ro,...::= Bool | Tau->Sigma
        Sintaxis de los tipos
            M,N,P,...::=    x                   -Variable
                        |   M N                 -Aplicación
                        |   true                -verdadero
                        |   false               -falso
                        |   if M then N else P  - condicional

        Asumimos que la aplicacion es asociativa a izquierda
        MNP = (MN)P != M(NP)
    
    EJEMPLO DE TERMINOS    
        λx:bool.x
        λx:bool->bool.x
        (λx:bool.x) false 
        (λx:bool->bool.x) (λy:bool.y)
        (λx:bool.λy:bool->bool.y x) true 
        λx:bool. if x then false els true 
        true true 
        if λx:bool.x then false else true 
        
    VARIABLES LIBRES Y LIGADAS
        una ocurrencia de x esta ligada si aparece adnetro de 
        una abstraccion lambda x. una ocurrencia de x esta 
        libre si no esta ligada 

        Ejemplo 
            marcar ocurrencias de variables libres y ligadas 
            (λx:bool->bool.λy:bool x y)(λy:bool.x y) y
                                   | |--|       | |  |
                                   Lig  Lig     | v  Libre
                                                | Ligada
                                                Libre
    
    fv(x)={x}
    fv(true)=VACIA
    fv(false)=VACIA
    fv(if M then N else P) = fv(M) U fv(N) U fv(P)
    fv(m n) = fv(M) U fv(N)
    fv(λx:tau.M) = fv(M)\{x}

    Alfa equivalencia   
        Los terminos que difieren solo en el nombre de variables ligadas
        se consideran iguales 
    
    Contexto de tipado 
        un contexto de tipado es un conjunto finito de pares
        sin variables repetidas 
    Juicios de tipado 
        el sistema de tipos predica sobre juicios de tipados 
        de la forma: 
            Gamma|-M:tau
    
    Γ ⊢ true : bool t-true Γ ⊢ false : bool t-false
Γ ⊢ M : bool Γ ⊢ N : τ Γ ⊢ P : τ
Γ ⊢ if M then N else P : τ t-if
Γ, x : τ ⊢ x : τ t-var Γ, x : τ ⊢ M : σ
Γ ⊢ λx : τ . M : τ → σ t-abs
Γ ⊢ M : τ → σ Γ ⊢ N : τ
Γ ⊢ M N : τ t-app
    
┌────────────────────────────────────────────────────────────────────┐
│                                                                    │
│                                                                    │
│                                                                    │
│       Γ ⊢ M : bool Γ ⊢ N : τ Γ ⊢ P : τ                             │
│       --------------------------------t-if                         │
│       Γ ⊢ if M then N else P : τ                                   │
│                                                                    │
│                                                                    │
│                                   ------------------T-var          │
│       ----------------t-true       Γ, x : τ ⊢ x : τ                │
│        Γ ⊢ true : bool                                             │
│                                                                    │
│       ----------------t-false                                      │
│       Γ ⊢ false : bool                                             │
│                                                                    │
│                                                                    │
│      Γ, x : τ ⊢ M : σ                Γ ⊢ M : τ → σ Γ ⊢ N : τ       │
│      -----------------------T-abs    -----------------------T-app  │
│      Γ ⊢ λx : τ . M : τ → σ          Γ ⊢ M N : τ                   │
│                                                                    │
│                                                                    │
└────────────────────────────────────────────────────────────────────┘

EJEMPLO- derivaciones de juicio de tipado
┌─────────────────────────────────────────────────────────────────────┐
│                                                                     │
│       TVAR            TFALSE                  AX                    │
│   ──────────────    ──────────────────       ──────────             │
│   x:bool|-x:bool    X:bool|-false:bool        x:bool|-x             │
│   ───────────────────────────────────T-IF----d────────────────────  │
│   x:bool|-if x then false else x: bool                              │
│   ──────────────────────────────────────────T-ABS.                  │
│   |-λ:bool.if x then false else x:bool->bool                        │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────────────┐
│         tvar        tvar                                                     │
│     ─────────────  ──────                                                    │
│     GM|-y:b->b->b GM|-X:B                tvar                                │
│     ────────────────────────────────    ────────                             │
│          T-VAR         GM|- yx:B->B     GM|z:B                        T-App  │
│     ───────────────    ───────────────────────────────────────────────────── │
│      GM|-y:B->B->B     GM|- yxz:B                                            │
│      ─────────────────────────────────────────────────────────────────────── │
│  GM= x:B,y:B->B->B,z:B|-y(xz):B->B    T-ABS                                  │
│      ──────────────────────────────────                                      │
│      x:B,y:B->B->B|-λz:B.y(yxz):B->B->B                              T-ABS   │
│     ──────────────────────────────────────────────────────────────────────   │
│                      x:B|-λy:B->B->B.λz:B.y(yxz):???                         │
│                                                                              │
│                      B=BOOL <3                                               │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘

┌───────────────────────────────────────────────────────────────────────────────────────────┐
│                                                                                           │
│                                                              sigma=(sigma->p)->IMPOSIBLE  │
│                                                                                           │
│                                                                                           │
│ GM|- xy:sigma->p                     GM|- xz:sigma->p                                     │
│ ───────────────────────────────────────────────────────────────────                       │
│ x:tau->sigma->p,y:tau,z:tau  |-xy(xz):                                                    │
│                                ││  │                                                      │
│                                ││  │                                                      │
│                                ││  sigma                                                  │
│                                ││                                                         │
│                                │tau                                                       │
│                                └tau->sigma->p                                             │
│                                                                                           │
└───────────────────────────────────────────────────────────────────────────────────────────┘

TEORMEA (UNICIDAD DE TIPOS)
Si Gamma|-M:tau y Gamma|-M:Sigma son derivables, entonces tau=sigma

TEOREMA(weakening+strengthening)
Si gamma|-M:tau es derivable y fv(M) contenido en dom (gamma interseccion gamma')
entonces gamma'|-M:tau es drivable 


SEMANTICAL FORMAL
el sistema de tipos indica como se construyen los programas 
queremos ademas darles significados (semantica)
    Distintas maneras de dar semantica formal
        1-Semantica operacional 
        Indica como se ejecuta el lrograma hasta lelgar a un resultado

        Semantica small step: ejecucion paso a paso
        Semantica big step: evaluacion directa al resultado

        2-Semantica denotacional
        interpreta los programas como objetos matemáticos

        3-Semantica axiomatica 
        establece relaciones lógicas entre el estado del programa antes y despues
        de la ejecución 

        SEMANTICA OPERACIONAL SMALL STEP
            PROGRAMAS
            un programa es un termino M tipable y cerrad (fv(M)=VACIO)
                el juicio de tipado |-M:tau debe ser derivable para algun tau 
            JUICIOS DE EVALUACION
                la semantica operacional predica sobre juicios de evaluacion 
                M->N
                donde M y N son programas 
            VALORES
                los valores son los posibles resultados de evaluar programas
                V::=true|false|lambda x:tau.M
            
            REGLAS DE EVALUACION PARA OPERACIONES SMALL STEP 

            -------------------------e-ifTrue
            if true then M else N → M 

            ---------------------------e-ifFalse
            if false then M else N → N 

            ---------------------------------------E-IF
            f M then N else P → if M′ then N else P

            M->M'   
            -----------e-app1
            M N → M′ N 

            -------------------------------e-app2
            (λx : τ . M) N → (λx : τ . M) N

            -----------------------------e-appAbs
            (λx : τ . M) V → M{x := V }

SUSTITUCIÓN
    la operacion de sustitución
    M{x := N}
    denota el termino que resulta de reemplazar 
    todas las ocurrencias libres de x en M por N             
    DEFINICION DE SUSTITUCION
        x{x := N} =_def N
        a{x := N} =_def a si a ∈ {true, false} ∪ X \ {x}
        (if M then P else Q){x := N} =_def if M{x := N}
                                            then P{x := N}
                                            else Q{x := N}
        (M1 M2){x := N} =_def M1{x := N} M2{x := N}
        (λy : τ. M){x := N} =_def
            |    λy : τ. M si x = y
            |    λy : τ. M{x := N} si x̸ = y , y  /∈ fv(N)
            |    λz : τ. M{y := z}{x := N} si x̸ = y , y ∈ fv(N),
            |    z /∈ {x, y } ∪ fv(M) ∪ fv(N)

Teorema (Determinismo)
    Si M → N1 y M → N2 entonces N1 = N2.

Teorema (Preservaci´on de tipos)
    Si ⊢ M : τ y M → N entonces ⊢ N : τ .

teorema (Progreso)
    Si ⊢ M : τ entonces:
    1. O bien M es un valor.
    2. O bien existe N tal que M → N.

Teorema (Terminación)
    Si ⊢ M : τ , entonces no hay una cadena infinita de pasos:
    M → M1 → M2 → . . .            

Corolario (Canonicidad)
    1. Si ⊢ M : bool es derivable, entonces la evaluaci´on de M
    termina y el resultado es true o false.
    2. Si ⊢ M : τ → σ es derivable, entonces la evaluaci´on de M
    termina y el resultado es una abstracci´on.      
    
-}      