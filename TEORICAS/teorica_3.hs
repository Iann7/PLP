{-
AXIOMAS
    reglas que no tienen premisas
    son validas solamente por existir(?)
DERIVACION
    arbol finito formado por reglas de inferencia 
    parte de ciertas premisas y llega a una conclusión

    un JUICIO es DERIVABLE si hay alguna derivacion 
    sin premisas que lo concluye 
FORMULAS
    Las formulas son las expresiones que se pueden generar a partir de la 
    siguiente gramatica 
    τ, σ, ρ, . . . ::= P | (τ ∧ σ) | (τ 
    OBSERVACION 
        La gramaticas definen sistemas deductivos de manera abreviada 
        una expresion τ se puede generar a partir de la gramatica de arriba 
        sii el juicio τ FORM es derivable en el sistema de antes 
CONTEXTO    
    un contexto es un cjto finito de formulas,
    los notamos con letras griegas mayúsculas  (Γ, ∆, Σ, . . .)
    Por ejemplo:
        Γ = {P ⇒ Q, ¬Q}
    el sistema de DECUCCION NATURAL predica sobre juicios de la forma
            Γ|-τ
    un juicio afirma que a partir de las hip´otesis en el
    contexto Γ es posible deducir la f´ormula de la tesis.

LOGICA INTUICIONISTA VS CLASICA
    NJ - sist deduccion natural intuicionista
    NK - sist deduccion natural clasica 
    - NK EXTIENDE a NJ con principios de razonamientos clasicos
        alcanza con agregar uno de ellos, por ejemplo, la doble negacion
    - Si un juicio es derivable en NJ tambien es derivable en NK
    - NJ es mas restrictiva, no permite usar la doble negacion y las otras
    - en matematica se usa generalmente la logica clasica 
    LOGICA INTUICIONISTA EN COMPUTACION
        Permite razonar acerca de INFO
        Las derivaciones de NJ se pueden entender como programas. 
        NJ es la BASE de un lenguaje de programacion funciona
VALUACION 
    Una valuación es una función v : P → {V, F} que asigna valores de
    verdad a las variables proposicionales

    Una valuaci´on v satisface una f´ormula τ si v ⊨ τ , donde:
        v ⊨ P si y s´olo si v (P) = V
        v ⊨ τ ∧ σ si y s´olo si v ⊨ τ y v ⊨ σ
        v ⊨ τ ⇒ σ si y s´olo si v ⊭ τ o v ⊨ σ
        v ⊨ τ ∨ σ si y s´olo si v ⊨ τ o v ⊨ σ
        v ⊨ ⊥ nunca vale
        v ⊨ ¬τ si y s´olo si v ⊭ τ
        
TEOREMA (CORRECION Y COMPLETITUD)
    1. Γ ⊢ τ es derivable en NK.
    2. Γ ⊨ τ

LEMA PRINCIPAL
    Si Γ determina a todas las variables que aparecen en τ , entonces:
    1. O bien Γ ⊢ τ es derivable en NK.
    2. O bien Γ ⊢ ¬τ es derivable en NK.
-}