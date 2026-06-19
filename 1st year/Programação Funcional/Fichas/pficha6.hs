1. Considere o seguinte tipo para representar ´arvores bin´arias.
data BTree a = Empty
| Node a (BTree a) (BTree a)
deriving Show
Defina as seguintes fun¸c˜oes:



a)
 -- que calcula a altura da arvore.
altura :: BTree a -> Int
altura Empty = 0
altura (Node x e d) = 1 + max (altura e) (altura d)

b) 
-- que calcula o numero de nodos da arvore

contaNodos :: BTree a -> Int
contaNodos Empty = 0
contaNodos (Node x e d) = 1 + contaNodos e + contaNodos d 


c) 
-- que calcula o numero de folhas (i.e., nodos sem descendentes) da arvore.

folhas :: BTree a -> Int
folhas Empty = 0
folhas (Node x e d)= folhas e + folhas d 
folhas (Node x Empty Empty) = 1



d)
--que remove de uma ´arvore todos os elementos a partir de uma determinada profundidade.

prune :: Int -> BTree a -> BTree a
prune Empty = Empty 
prune f (Node x e d) = Node (prune x (f-1)e)(prune x (f-1)d)

e)
-- que dado um caminho (False corresponde
a esquerda e True a direita) e uma arvore, da a lista com a informacao dos nodos
por onde esse caminho passa.

-- se h for True vai pela direita, se for False vai pela esquerda 
path :: [Bool] -> BTree a -> [a]
path _ Empty = []
path (h:t) (Node x e d) = if h == True 
                         then x : (path t d)
                         else x: path t e 


f)
-- que da a arvore simetrica

mirror :: BTree a -> BTree a
mirror Empty = Empty 
mirror (Node x e d) = Node x (mirror e) (mirror d) 


g)

-- que generaliza a fun¸c˜ao zipWith para ´arvores bin´arias.
zipWith :: (a->b->c) -> [a] -> [b] -> [c]
zipWith f (h:t) (x:y) = f a b || zipWith f t y 
zipWith _ _ _ = []


zipWithBT :: (a -> b -> c) -> BTree a -> BTree b -> BTree c
zipWithBT f (Node x e d) (Node x' e' d') = Node (f x x') (zipWithBT f e e') (zipWithBT f d d')
zipWithBT _ _ _ = Empty


h) 
--que generaliza a fun¸c˜ao unzip (neste caso de triplos) para ´arvores bin´arias.

unzipBT :: BTree (a,b,c) -> (BTree a,BTree b,BTree c)
unzipBT Empty = (Empty, Empty, Empty)
unzipBT (Node (a,b,c) l r) = (Node a unzipL1 unzipR1, Node b unzipL2 unzipR2, Node c unzipL3 unzipR3)
    where (unzipL1,unzipL2,unzipL3) = unzipBT l
          (unzipR1,unzipR2,unzipR3) = unzipBT r



2.
a)
--Defina uma funcao  que determina o menor elemento de uma arvore binaria de procura nao vazia

minimo :: Ord a => BTree a -> a
minimo (Node x Empty _) = x
minimo (Node x e d) = minimo e 

b)
--Defina uma funcao  que remove o menor elemento de uma ´arvore bin´aria de procura n˜ao vazia

semMinimo :: Ord a => BTree a -> BTree a
semMinimo (Node _ Empty r) = r
semMinimo (Node x e d) = Node x (semMinimo e) d 

c)
-- Defina uma funcao que calcula, com uma unica travessia da arvore o resultado das duas funcoes anteriores.

minSmin :: Ord a => BTree a -> (a,BTree a)
minSmin (Node x Empty d) = (x,d)
minSmin (Node x e d) = (a,Node e b r)
    where (a,b) = minSmin e

d)
--Defina uma fun¸c˜ao que remove um elemento de uma ´arvore bin´aria de procura, usando a fun¸c˜ao anterior.

remove :: Ord a => a -> BTree a -> BTree a 
remove _ Empty = Empty
remove f (Node x e d) = | f < x = Node x (remove f e) d
                        | f > x = Node x e (remove f d)
                        |otherwise case d of Empty = e
                                      _ -> let (g,h) = minSmin r in Node g l h



3.

type Aluno = (Numero,Nome,Regime,Classificacao)
type Numero = Int
type Nome = String
data Regime = ORD | TE | MEL deriving Show
data Classificacao = Aprov Int
| Rep
| Faltou
deriving Show
type Turma = BTree Aluno -- arvore binaria de procura (ordenada por numero)


a)  
--que verifica se um aluno, com um dado numero, esta inscrito.

inscNum :: Numero -> Turma -> Bool
inscNum f Empty = False
insNum f (Node (N, n , R , C)e d ) = if f == N ||
                              then True
                              else False

b)
--que verifica se um aluno, com um dado nome, esta inscrito.

inscNome :: Nome -> Turma -> Bool
inscNome f Empty = False
inscNome f (Node (N, n , R , C)e d ) = if f == n || inscNome f e || inscNome f d 
                                     then True 
                                     else False 

c)
--que lista o numero e nome dos alunos trabalhadores-estudantes (ordenados por numero)

trabEst :: Turma -> [(Numero,Nome)]
trabEst Empty = []
trabEst (Node (N, n , R , C)e d ) = trabEst e ++ [(Numero,Nome)] ++ trabEst d 


d)
-- que calcula a classificacao de um aluno (se o aluno nao estiver inscrito a funcao deve retornar Nothing).
nota :: Numero -> Turma -> Maybe Classificacao
nota f (Node (N, n , R , C)e d )= 
                                |f == N = Just C
                                | f < num = nota n e
                                | otherwise = nota n d 
                                nota _ _ = Nothing

e)
-- que calcula a percentagem de alunos que faltaram a avaliacao.

percFaltas :: Turma -> Float
percFaltas Emoty = 0
percFaltas (Node (N, n , R , Faltou)e d ) = 1 + percFaltas e + percFaltas d 


f) 
--que calcula a media das notas dos alunos que passaram

mediaAprov :: Turma -> Float
mediaAprov (Node (N, n , R , C)e d ) = C ++ mediaAprov e ++ mediaAprov d 











