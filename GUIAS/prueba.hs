nub :: Eq a => [a] -> [a]
nub [] = []
nub (x:xs) = x : filter (\y -> x /= y) (nub xs)