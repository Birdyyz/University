data ExpInt = Const Int
      | Simetrico ExpInt
      | Mais ExpInt ExpInt
      | Menos ExpInt ExpInt
      | Mult ExpInt ExpInt
      deriving Show
      data RTree a = R a [RTree a]
1.
--a)
calcula :: ExpInt -> Int 
calcula (const x) = x
calcula (Simetrico x) = - (calcula x)
calcula (Mais e1 e2) = (calcula e1) + (calcula e2)
calcula (Menos e1 e2) = (calcula e1) - (calula e2)
calcula (Mult e1 e2) = (calcula e1) * (calcula e2)
2.
-- Defina uma funcao infixa :: ExpInt -> String de forma a que infixa (Mais (Const 3) (Menos (Const 2) (Const 5))) de como resultado
"(3 + (2 - 5))".
-- b)
infixa :: ExpInt -> String
infixa (Const x) = show x
infixa (Simetrico x) = "(-" ++ infixa x ++ ")"
infixa (Mais e1 e2) = "(" ++ finfica e1 ++ "+" ++ infixa e2 ++ ")" 
infixa (Menos e1 e2) = "(" ++ infixa e1 ++ "-" ++ infixa e2 ++ ")"
infixa (Mult e1 e2) = "(" ++ infixa e1 ++ "*" ++ infixa e2 ++ ")" 

c)
-- Defina uma outra funcao de conversao para strings posfixa :: ExpInt -> String de forma a que quando aplicada 
a expressao acima de como resultado "3 2 5 -+".
posfixa :: ExpInt -> String
posfixa (const x) = show x
posfixa (simetrico x) = "(" ++ posfixa x ++ ")"
posfixa (Mais e1 e2) = 'posfixa e1 ++ posfixa e2 ++ "+"
posfixa (Menos e1 e2) = posfixa e1 ++ posfixa e2 ++ "-"
posfixa (Mult e1 e2) = posfixa e1 ++ posfixa e2 ++ "*

2.
--a) soma :: Num a => RTree a -> a que soma os elementos da arvore.
 soma :: Num a => RTree a -> a
 soma ( R i l) = i + sum(map soma l) 
 -- i - informacao
 -- l - lista
 --ou
 soma' ( R i l) = i + foldr f 0 l 
                  where f t r = soma' t + r 
--ou como funcao anonima
soma '' (R i l) = i+ fold ( \ t r -> soma '' t + r) 0 l 

-c)prune :: Int -> RTree a -> RTree a que remove de uma arvore todos os elementos a partir de uma determinada profundidade

prune :: Int -> RTree a -> RTree a 
prune 1 ( R i l) = R i []
prune n (R i l) = ( R i (map(prune (n-1) (l))))
 -- prune 5 r t 
 


d)
--que gera a arvore simetrica

mirror :: RTree a -> RTree a 
mirror ( R i l ) = R i (map mirror ( reverse l)) 


e) 
--que corresponde a travessia postorder da arvore.

postorder :: RTree a -> [a] 
postorder (R i l) = concat (map postorder l) ++ [r] 


3. 
data BTree a = Empty | Node a (BTree a) (BTree a)

Nestas arvores a informacao esta nos nodos (as extermidades da arvore tem apenas
uma marca – Empty). 

E tambem habitual definirem-se arvores em que a informacao 
esta apenas nas extermidades (leaf trees):

data LTree a = Tip a | Fork (LTree a) (LTree a)
ex:
arvore = Fork (Fork (Tip 5)
                    (Fork (Tip 6)
                          (Tip 4)))
              (Fork (Fork (Tip 3)
                          (Tip 7))
                    (Tip 5))

a) 
que soma as folhas de uma arvore.

ltSum :: Num a => LTree a -> a
ltSum (Tip a) = a 
ltSum Fork a b = ltSum a + ltSum b

b) 
--que lista as folhas de uma arvore (da esquerda para a direita).

listaLT :: LTree a -> [a]
listaLT Tip a = [a]
listaLT Fork a b = listaLT a ++ listaLT b 

c) 
--que calcula a altura de uma arvore.

ltHeight :: LTree a -> Int 
ltHeight (Tip a) = 0
ltHeight Fork a b = 1 + max (ltHeight a) ( ltHeight b)


4.  
data FTree a b = Leaf b | No a (FTree a b) (FTree a b)

Sao as chamadas full trees onde a informa¸c˜ao est´a n˜ao s´o nos nodos, como tamb´em nas
folhas (note que o tipo da informa¸c˜ao nos nodos e nas folhas n˜ao tem que ser o mesmo)


a) 
--Defina a funcao  que separa uma arvore com informacao nos nodos e nas folhas em duas arvores de tipos diferentes.

splitFTree :: FTree a b -> (BTree a, LTree b)
splitFTree Leaf n = ( Empty, Tip n) 
splitFTree No a b c = (Node ( a, fst splitFTree b)( fst splitFTree c) , Fork (snd splitFTree b )(snd splitFTree c) )


b) 
Defina ainda a funcao que sempre que as arvores sejam compativeis as junta numa so.
 
joinTrees :: BTree a -> LTree b -> Maybe (FTree a b)
joinTrees Empty (Tip a) = Just (Leaf a)
joinTrees (Node e l r) (Fork a b) = case (joinTrees l a, joinTrees r b) of (Just x, Just y) -> Just (No e x y)
                                           _ -> Nothing
joinTrees _ _ = Nothing

















2.
data RTree a = R a [RTree a]

a) 
-- que soma os elementos da ´arvore.

soma :: Num a => RTree a -> a
soma R x l = x ++ (map soma l)



b) 
--que calcula a altura da arvore.

altura :: RTree a -> Int 
altura R x l = 1 + max (map altura l)

c)
--que remove de uma arvore todos os elementos a partir de uma determinada profundidade.

prune :: Int -> RTree a -> RTree a 
prune a (R x l) = if a = 0
                  then R x []
                  else R x (map prune (a-1) l )

d) 
-- que gera a arvore simetrica.

mirror :: RTree a -> RTree a
mirror R x l = R x (map reverse l)


e) 
-- que corresponde a travessia postorder da arvore.

postorder :: RTree a -> [a]
postorder R x l = concat (map postorder l) ++ [r] 


