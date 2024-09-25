{-
calculo lambda 

DADA LA SIGUIENTE EXPRESIÓN 
(λx : Bool. λy : Bool → Bool. y (y x)) ((λz : Bool. true) false) (λw : Bool. w)
¿Qué significa esto? ¿Significa algo? ¿Es válido? ¿Es un valor? ¿Cómo nos damos cuenta?

Sintaxis del calculo lambda
los tipos del calculo lambda se definen mediante la siguiente gramatica 

Sigma:=Bool|Sigma->Sigma 

y sus terminos son los siguientes 

M ::= x | λx : σ.M | M M | true | false | if M then M else M

donde x pertenece a X el conjunto de todas las variables. Llamamos T al conjunto de todos los terminos 

Variables libres y ligadas 
las variables libres son todas aquellas fuera del alcance de las λs
las variables ligadas son las que estan ligadas las λs
fv : T → X devuelve todas las variables libres en el termino T 

Asociatividad y prece




        A                       B
┌────────────────┐ ┌───────────────────────┐
│ λx:b->b.x True │ │x y x:b->b. x y        │
│ ──────┬─────── │ │----------------AP     │
│  ┌────┘        │ │x y      λx:b->b.x y   │
│  │abs          │ │---app   -----------ans│
│  ▼             │ │x y          x  y      │
│ x true         │ │             ------abs │
|                | |             |    |    | 
│   ┌────┐app    │ │             x    y    │
│   │    │       │ │                       │
│   x    true    │ │                       │
└────────────────┘ └───────────────────────┘

A = λx:b->b.x True
quien esta libre en a? 
solo X
B= x y x:b->b. x y
quien esta libre en b?
las x e y de afuera de la lambda, y la y adentro de la lambda 


asociatividad y precedencia 
σ → τ → ρ = σ → (τ → ρ) 6 = (σ → τ ) → ρ 
M N O = (M N )O 6 = M (N O) 
λx : σ.M N = λx : σ.(M N ) 6 = (λx : σ.M )N 

Sistema de tipado
Los juicios de tipado Γ ` M : τ válidos se pueden derivar mediante el siguiente sistema de
reglas de deducción

    ------------------ax-v
    Γ, x : τ |- x : τ 


    Γ, x : τ |- M : σ
    ----------------------- ->_i
    Γ |- λx : τ .M : τ → σ 

    Γ|-M : τ → σ    Γ |- N : τ
    ------------------------------- →e
    Γ |-M N : σ 

    Γ |- M : Bool Γ |- N1 : τ Γ |- N2 : τ
    --------------------------------if
    Γ |- if M then N1 else N2 : τ 

SEMANTICA OPERACIONAL 
La siguiente gramática de valores y las reglas de reducción definen la estrategia call-by-value.
V ::= true | false | λx : σ.M
    (λx : σ.M )V → M {x := V } (β)
    if true then M else N → M (ift)
    if false then M else N → N (iff )

Si M → N , entonces:
    M O → N O (μ)
    V M → V N (ν)
    if M then O else P → if N then O else P (ifc)

axv             T-true      T-var 
---------- ------------- ----------
GAMMA|-X:b GAMMA|-TRUE:B GAMMA|-y:b          IF
-----------------------------------------------
GAMMA=x:b,y:b|-if x then true else y):b    t-abs
----------------------------------------------
|-λy:b if x then true else y):b->b       t-abs
---------------------------------------------  ----------- axs
|- (λx:b, λy:b if x then true else y):b->b->B  |-FALSE:b
----------------------------------------------- ->e
|-(λx:b, λy:b if x then true else y) false :b>b

B) 
----------------- axt
x:bool|-true:bool

C) no tiene ningun juiicio de tipado valido 
                                AXV
                            ----------   ----------AXB
                            gamma|-x:σ -> y:σ           AXV
                            --------------------  -----------------------------  
            AXV              GAMMA|-XY: τ->σ        gamam|-Z:τ                  T-app
-------------------------   ----------------------------------------------
GAMMA|-x: σ-->τv->σ                GAMMA|- x y z:σ
--------------------------------------------------------------------------APP
GAMMA=x:p,y:σ,z:τ|-x(xyz):τ->σ 
--------------------------------------------------------------------------T_abs
x:p,y:σ|-λz : τ.x(xyz):τ->τ->σ 
--------------------------------------------------------------------------T_ABS
x:p|-λy : σ.λz : τ.x(xyz). :σ->τ->τ->σ
-------------------------------------------------------------------------- T-ABS
|-λx : ρ.λy : σ.λz : τ.x(xyz) : (:σ->τ->σ)->σ->τ->τ->σ
(identificando qué tipos pueden ser τ , σ y ρ)



                            ------------------axv ---------------axv
                            GAMMA|-G:sigma->tau  GAMMA|-x:sigma
---------------axv          ---------------------------T-APP
GAMMA|-F:tau:ro             GAMMA|-g x: tau 
------------------------------------------------------------------Tapp
GAMMA=f:tau->ro,g:sigma->tau,x:sigma |- f (g x):ro
------------------------------------------------------------------T-abs
f:tau->ro,g:sigma->tau|-λx:sigma.F(g x):sigma->ro
-------------------------------------------------------------------T-ABS
F:tau->ro|-λg:sigma->tau.λx:sigma. F(gx) :(sigma->tau)->sigma->ro
-------------------------------------------- T-abs
|-λf:tau->ro.λg:sigma->tau.λx:sigma. F(G X)


((λx:bool.λy:bool. if x then true else y)false)true ->Beta 
(y:bool. if false then true else y) true ->Beta
if false then true else true  -> iff
true (termino 0)


(λx:bool.λy:bool->bool.y(yx))((λz:bool.true)false)(λw:bool.w)
->APPi,APPr,B (λx:bool.λy:bool->bool.y(yx)) true (λw:b.w)
->(λy:bool->bool.y(y true)) w
-> w (w true) -> true 


EJERCICIO probar que la semantica operacionas de calculo lambda con booleanos 
con la estrategia ce call by value esta determinada 
es decir probar que si M->M1 y M->M2 entonces m1=m2

casos bases  ift iff beta (reglas de computo)
B:M=(λx:sigma.M') V 
M1= M{x:=V}
savemos que M tambien reduce a m2 
peero solo podemos usar esta regla para reducir a M 
por ende solo se puede aplicar a esta y queda lo mismo 
QED 

caso inductivo: reglas de congruencia 
todas tienen la premisa M'->m HI di M'->n1
y m´->n2 entonce n1=n2 s

EXTENSION CON NUMEROS NATURALES
σ ::= . . . | Nat
M ::= . . . | zero | succ(M ) | pred(M ) | isZero(M )

-------------ax0
Γ |- zero : Nat 

Γ |- M : Nat
------------------succ
Γ |- succ(M ) : Nat 

Γ |- M:nat
-------------------pred
Γ |- pred(M ) : Nat

Γ |- M : Nat
-----------------------isZero
Γ |- isZero(M ) : Boo

V ::= . . . | zero | succ(V )
pred(succ(V )) → V          (pred)
isZero(zero) → true         (isZero0)
isZero(succ(V )) → false    (isZeron)

Si M → N , entonces:
succ(M ) → succ(N )         (succc)
pred(M ) → pred(N )         (predc)
isZero(M ) → isZero(N )     (isZeroc)


----------------------------------
cambiando regals semanticas
supongamos que agregamos las siguiente regla para las abstracciones 
si m->n entonces 
λx:t.M->λx:t.n 

| repensal cl cjto de valores para respetar esta modificacion pensar por ejemplo si 
λx:bool id_bool true es o no un valor  ¿y λx:bool?
x?

V::=true|False|λx:sigma.F|0|succ(V) donde F es una forma normal

que reglas deberian modificarse para no romper el determinismo?
(λx : σ.F )V → F {x := V } (β)


-}