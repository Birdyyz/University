--que dado um inteiro e um elemento x constr´oi uma lista com n elementos, todos iguais a .
--exemplo, replicate 3 10 corresponde a [10,10,10]

replicatee :: Int -> a -> [a]
replicatee 0 n = []
replicatee x n = n : replicatee (x-1) n 


--retorna a lista resultante de remover da primeira lista os elementos que n˜ao pertencem `a segunda.
--Por exemplo, intersect [1,1,2,3,4] [1,3,5] corresponde a [1,1,3].

intersect :: Eq a => [a] -> [a] -> [a]
intersect [] l = []
intersect (h:t) l = if h `elem` l 
                  then h : intersect t l 
                  else intersect t l 


                
data LTree a = Tip a | Fork (LTree a) (LTree a)
data FTree a b = Leaf a | No b (FTree a b) (FTree a b)

conv :: LTree Int -> FTree Int Int
conv = snd . convAux

convAux :: LTree Int -> (Int, FTree Int Int)
convAux (Tip x) = (x, Leaf x)
convAux (Fork l r) = (s, No s ll rr)
    where (sl, ll) = convAux l
          (sr, rr) = convAux r
          s = sl + sr

type Mat a = [[a]] 

triSup :: Num a => Mat a -> Bool