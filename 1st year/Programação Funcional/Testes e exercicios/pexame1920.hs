import Data.List (groupBy)
import Data.List (elemIndices)


--inits [11,21,13] corresponde a [[],[11],[11,21],[11,21,13]].
inits :: [a] -> [[a]]
inits [] = [[]]
inits (h:t) = [] : map (h:) (inits t)


--isPrefixOf [10,20] [10,20,30] corresponde a True enquanto que isPrefixOf [10,30] [10,20,30] corresponde a False.

isPrefixOf:: Eq a => [a] -> [a] -> Bool
isPrefixOf [] l = True 
isPrefixOf l [] = False 
isPrefixOf (h:t) (h':t') = h == h' && isPrefixOf t t' 




data BTree a = Empty | Node a (BTree a) (BTree a)


--que calcula o numero de folhas (i.e., nodos sem descendentes) da arvore.
folhas :: BTree a -> Int
folhas Empty = 0
folhas (Node x Empty Empty) = 1
folhas (Node x Empty r) = folhas r 
folhas (Node x l Empty) = folhas l
folhas (Node x l r) =  folhas l + folhas r
         

--que dado um caminho (False corresponde a esquerda e True a direita) e uma arvore, da a lista com a informacao
-- dos nodos por onde esse caminho passa.

path :: [Bool] -> BTree a -> [a]
path (False:t) (Node x l r) = x : path t l 
path (True:t) (Node x l r) = x : path t r 


--intersect [1,1,2,3,4] [1,3,5] corresponde a [1,1,3]
intersect :: Eq a => [a] -> [a] -> [a]
intersect [] l = []
intersect (h:t) l = if h `elem` l 
                   then h : intersect t l 
                   else intersect t l 

--tails [1,2,3] corresponde a [[1,2,3],[2,3],[3],[]]
tails :: [a] -> [[a]]
tails [] = [[]]
tails l = l : tail l : [last l] : [[]]



data RTree a = R a [RTree a] deriving (Show, Eq)

-- paths (R 1 [R 2 [], R 3 [R 4 [R 5 [], R 6 []]],R 7 []]) deve corresponder `a lista [[1,2],[1,3,4,5],[1,3,4,6],[1,7]]


--zip [1,2,3] [10,20,30,40] corresponde a [(1,10),(2,20),(3,30)].
zip' :: [a] -> [b] -> [(a,b)]
zip' [] (h:t) =[]
zip' (h:t) (h':t') = (h,h') : zip t t' 

--preCrescente [3,7,9,6,10,22] corresponde a [3,7,9] 
--preCrescente [1,2,7,9,9,1,8] corresponde a [1,2,7,9]

preCrescente :: Ord a => [a] -> [a]
preCrescente [] = []
preCrescente (h:t) = if h >= head t 
                    then [h] 
                    else h : preCrescente t 

amplitude :: [Int] -> Int
amplitude [] = 0
amplitude l = maximum l - minimum l

--organiza "abracadabra" corresponde a [(’a’,[0,3,5,7,10]),(’b’,[1,8]), (’r’,[2,9]),(c,[4])].
organiza :: Eq a => [a] -> [(a,[Int])]
organiza lista = [(x, elemIndices x lista) | x <- removeDuplicatas lista]
  where
    removeDuplicatas :: Eq a => [a] -> [a]
    removeDuplicatas [] = []
    removeDuplicatas (x:xs) = x : removeDuplicatas (filter (/= x) xs)


--unlines ["Prog", "Func"] == "Prog\nFunc".
unlines' :: [String] -> String
unlines' [] = []
unlines' [h] = h 
unlines' (h:t) = h ++ "\n" ++ unlines' t 

data Lista a = Esq a (Lista a) | Dir (Lista a) a | Nula

--que recebe uma Lista nao vazia e devolve a Lista sem o seu elemento mais a direita.
semUltimo :: Lista a -> Lista a
semUltimo (Esq x Nula) = Nula 
semUltimo (Dir Nula l) = Nula 
semUltimo (Esq x l) = Esq x (semUltimo l)
semUltimo (Dir l x) = l
  

--Esq 1 (Dir (Dir (Esq 9 Nula) 3) 4) seja apresentada como [1, 9, 3, 4].
-- Em vez de estarmos a complicar o exercicio, convertemos a "Lista a" para uma lista normal e depois aplicamos a função show
-- Função que recebe uma "Lista a" e devolve uma lista de a
toList :: Lista a -> [a]
toList Nula = []
toList (Esq x l) = x : toList l
toList (Dir l x) = toList l ++ [x]

-- Como o show para listas normais já está definido, podemos usar a função show para converter a lista para string
showListaA :: Show a => Lista a -> String
showListaA = show . toList

{- 1. Apresente uma definição recursiva das seguintes funções sobre listas:

(a) isSorted :: (Ord a) => [a] -> Bool que testa se uma lista está ordenada por ordem crescente. -}

isSorted :: (Ord a) => [a] -> Bool
isSorted [x] = True 
isSorted (h:s:t) = if h < s 
                  then isSorted (s:t)
                  else False 

{- (b) inits :: [a] -> [[a]] que calcula a lista dos prefixos de uma lista. Por exemplo, inits [11,21,13]
corresponde a [[],[11],[11,21],[11,21,13]]. -}

inits' :: [a] -> [[a]]
inits' [] = [[]]
inits' (h:t) = [] : map (h:) (inits t)


--3. Considere o seguinte tipo para representar árvores em que a informação está nas extermidades:

data LTree a = Tip a | Fork (LTree a) (LTree a)

{- (a) Defina a função listaLT :: LTree a -> [a] que dá a lista das folhas de uma árvore (da esquerda
para a direita). -}

listaLT :: LTree a -> [a]
listaLT (Tip x) = [x]
listaLT (Fork l r) = listaLT l ++ listaLT r 


{- (b) Defina uma instância da classe Show para este tipo que apresente uma folha por cada linha, precedida de tantos
pontos quanta a sua profundidade na árvore. Veja o exemplo.

> Fork (Fork (Tip 7) (Tip 1)) (Tip 2)
..7
..1
.2
 -}
instance Show a => Show (LTree a) where
    show tree = showTree tree 0
        where
            showTree (Tip x) c = replicate c '.' ++ show x
            showTree (Fork left right) c = showTree left (c + 1) ++ "\n" ++ showTree right (c + 1)
  
  
--1. Considere o tipo MSet a para representar multi-conjuntos de tipo a

type MSet a = [(a,Int)]

{- Considere ainda que nestas listas não há pares cuja primeira componente coincida, nem cuja segunda
componente seja menor ou igual a zero. Para além disso, os multi-conjuntos estão organizados
por ordem decrescente da muiltplicidade. O multi-conjunto {’b’,’a’,’c’,’b’,’b’,’a’,’b’} é
representado pela lista [(’b’,4),(’a’,2),(’c’,1)], por exemplo. -}

{-(a) Defina a função cardMSet :: MSet a -> Int que calcula a cardinalidade de um multiconjunto. 
Por exemplo, cardMSet [(’b’,4),(’a’,2),(’c’,1)] devolve 7. -}


cardMSet :: MSet a -> Int 
cardMSet [] = 0 
cardMSet ((h,s):t) = s + cardMSet t 


--1. Apresente uma definição recursiva da função (pré-definida) 

--(a) elemIndices :: Eq a => a -> [a] -> [Int] que calcula a lista de posições em que um dado elemento ocorre numa lista.

elemIndices' :: Eq a => a -> [a] -> [Int]
elemIndices' x [] = []
elemIndices' x l = aux 0 x l
                   where aux i v [] = []
                         aux i v (h:t) = if v == h
                                         then (i) : aux (i+1) v t 
                                         else aux (i+1) v t



data Contacto = Casa Integer | Trab Integer | Tlm Integer | Email String deriving (Show)
type Nome = String
type Agenda = [(Nome, [Contacto])]


-- dado um nome, um email e uma agenda, acrescenta essa informacao `a agenda.
acrescEmail :: Nome -> Contacto -> Agenda -> Agenda
acrescEmail x y [] = [(x, [y])]
acrescEmail x y ((nom, [c]):t) =
    if x == nom
        then (nom, [c, y]) : t
        else (x, [y]) : (nom, [c]) : t

verEmails :: Nome -> Agenda -> Maybe [String] 
verEmails x [] = Nothing []
verEmails x ((nom,[c]):t) acc = if x == nom 
                             then Just (c: verEmails x t )
                             else verEmails x t 