


1.
a) any :: (a -> Bool) -> [a] -> Bool que teste se um predicado e verdade para algum elemento de uma lista; por exemplo:
any odd [1..10] == True
any _ [] = False 
any f (h:t) = f h !! any f t 

b)
--que combina os elementos de duas listas usando uma funcao especıfica; por exemplo:
zipWith (+) [1,2,3,4,5] [10,20,30,40] == [11,22,33,44]

zipWith :: (a->b->c) -> [a] -> [b] -> [c]
zipWith f (h:t) (x:y) = f a b || zipWith f t y 
zipWith _ _ _ = []


c)
-- que determina os primeiros elementos
da lista que satisfazem um dado predicado; por exemplo:
takeWhile odd [1,3,4,5,6,6] == [1,3].


takeWhile :: (a->Bool) -> [a] -> [a]
takeWhile f [] = []
takeWhile f (h:t) = 
                   | f h = h : takeWhile f t 
                   | otherwise []

d)
--que elimina os primeiros elementos da
lista que satisfazem um dado predicado; por exemplo:
dropWhile odd [1,3,4,5,6,6] == [4,5,6,6].

dropWhile :: (a->Bool) -> [a] -> [a] 
dropWhile f [] = []
dropWhile f (h:t) =
                   | f h = dropWhile f t 
                   | otherwise h:t 

e)

-- que calcula simultaneamente os dois
resultados anteriores. Note que apesar de poder ser definida a custa das outras duas, usando a definicao 
span p l = (takeWhile p l, dropWhile p l)
nessa definicao ha trabalho redundante que pode ser evitado. Apresente uma
definicao alternativa onde nao haja duplicacao de trabalho.

span :: (a-> Bool) -> [a] -> ([a],[a])
span f [] = []
span f (h:t) = 
          | f h = let (taken, dropped) = span f t in (h:taken, dropped)             
          | otherwise = ([], h:t)


span' :: (a-> Bool) -> [a] -> ([a],[a])
span' f [] = ([],[])
span' f (x:xs) | f x = (x:a,b)
               | otherwise = ([],(x:xs))
               where (a,b) = span' f xs

f)
-- que apaga o primeiro elemento de uma lista que e “igual” a um dado elemento de acordo com a funcao
de comparacao que e passada como parametro. Por exemplo:
deleteBy (\x y -> snd x == snd y) (1,2) [(3,3),(2,2),(4,2)]

deleteBy :: (a -> a -> Bool) -> a -> [a] -> [a]
deleteBy f [] = []
deleteBy f n (h:t) = if f n h 
                    then t 
                    else h : deleteBy f n t 


g)
--que ordena uma lista comparando os resultados de aplicar uma funcao de extraccao de uma chave a cada elemento de uma lista. 
Por exemplo:
sortOn fst [(3,1),(1,2),(2,5)] == [(1,2),(2,5),(3,1)].


sortOn :: (Ord b) => (a -> b) -> [a] -> [a]
sortOn f [] = []
sortOn f (h:t) = insertOn f h (sortOn f t)
    
insertOn :: (Ord b) => (a -> b) -> a -> [a] -> [a]
insertOn _ x [] = [x]
insertOn f x (h:t) = if f x > f h then h : insertOn f x t else x : h : t


















2.
Relembre a questao sobre polinomios introduzida na Ficha 3, onde um polinomio era
representado por uma lista de monomios representados por pares (coeficiente, expoente)
type Polinomio = [Monomio]
type Monomio = (Float,Int)

c) grau :: Polinomio -> Int que indica o grau de um polinomio
grau l = maxinum (map snd l) 
ou
grau l = foldl (\ acc x -> if (x>acc))                  acc- acumulador
                          |then x 
                          else acc 
                          