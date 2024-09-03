{-IMPLEMENTAR TAKE-}

take2::[a]->Int->[a]
take2 =  foldr (\x rxs ->(\n->if n==0 then [] else x:rxs(n-1)))
               (const []) 