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















-}