


1.
--Apresente uma definicao recursiva da funcao que junta todas as strings da lista numa so, separando-as pelo caracter ’\n’.
--Por exemplo, unlines ["Prog", "Func"] == "Prog\nFunc".

unlines :: [String] -> string
unlines [x] = x
unlines (h:t) = h ++ "/n" ++ unlines t 

2. 
--O formato csv (comma separated values) serve para descrever tabelas de uma forma textual:
--cada linha da tabela corresponde a uma linha do texto, enquanto que os elementos de cada linha se encontram separados por vırgulas.
--Por exemplo, a string "2,3,6,4\n12,3,12,4\n3,-4,5,7"

a) 
--Considere o tipo type Mat = [[Int]] para representar matrizes e a seguinte definicao da funcao stringToMat 
--que converte strings desse formato em matrizes:
--Apresente a definicao da funcao stringToVector e indique explicitamente o seu tipo


stringToMat :: String -> Mat
stringToMat s = map stringToVector (lines s)

stringToVector :: 

b) 
--Defina a funcao  que recebe a tabela em formato textual e devolve a tabela transposta tambem em formato textual.


transposta :: String -> String
transposta 











3.
--Considere o seguinte tipo de dados para representar uma lista em que os elementos podem ser
--acrescentados a esquerda (Esq) ou a direita (Dir) da lista. Nula representa a lista vazia


data Lista a = Esq a (Lista a) | Dir (Lista a) a | Nula


a)
-- Defina a funcao  que recebe uma Lista nao vazia e devolve a Lista sem o seu elemento mais a direita


semUltimo :: Lista a -> Lista a
-- Casos base existe apenas 1 elemento na lista
semUltimo (Esq x Nula) = Nula
semUltimo (Dir Nula x) = Nula  
-- Casos "recursivos" 
-- Como o elemento está na esquerda, vamos tirar o elemento mais à direita
semUltimo (Esq x l) = Esq x (semUltimo l)
-- Como o elemento "x" está na direita, vamos tirar o elemento
semUltimo (Dir l x) = l


b) 
--Defina Lista como instˆancia da classe Show de forma a que a lista Esq 1 (Dir (Dir (Esq 9 Nula) 3) 4) 
--seja apresentada como [1, 9, 3, 4].

instance Show Lista where 

    toList :: Lista a -> [a]
toList Nula = []
toList (Esq x l) = x : toList l
toList (Dir l x) = toList l ++ [x]

showListaA :: Show a => Lista a -> String
showListaA = show . toList


4. 
--Relembre a definicao do tipo das arvores binarias e da funcao que faz uma travessia inorder de uma arvore.


data BTree a = Empty | Node a (BTree a) (BTree a)
inorder :: BTree a -> [a]
inorder Empty = []
inorder (Node r e d) = (inorder e) ++ r ++ (inorder d)

travesia inorder -> visita primeiro a esq -> raiz -> direita 
travessia postorder -> esq -> dir -> raiz 
a) 
--que coloca em cada nodo daarvore argumento o numero de ordem desse nodo numa travessia inorder. A fun¸ao deve percorrer 
--a ´arvore uma unica vez.

--Por exemplo, numera (Node ’a’ (Node ’b’ Empty Empty) (Node ’c’ Empty Empty)) deve dar como resultado 
--(Node (’a’,2) (Node (’b’,1) Empty Empty) (Node (’c’,3) Empty Empty))


--Sugestao: Comece por definir a funcao numeraAux :: Int -> BTree a -> (Int,BTree(a,Int)) que recebe um inteiro
--(o primeiro numero a ser usado) e retorna a arvore numerada bem como o numero de elementos dessa arvore.


numeraAux :: Int -> BTree a -> (Int,BTree(a,Int))
numeraAux n Empty = (n , Empty)
numeraAux n (Node x l r) = (n2, Node (n1,x) l' r')
    where
        (n1,l') = numeraAux n l
        (n2,r') = numeraAux (n1+1) r


numera :: BTree a -> BTree (a,Int)
numera tree = snd (numeraAux tree 1)

b) 


--A funcao inorder nao e injectiva: ha muitas arvores diferentes que dao origem a mesma travessia: 
--por exemplo, as arvores Node 1 Empty (Node 2 Empty Empty) e Node 2 (Node 1 Empty Empty) Empty tem como travessia a lista [1,2]


--Defina a funcao que, dada uma lista, calcula (a lista de) todas as arvores cuja travessia inorder corresponde a essa lista.

unInorder :: [a] -> [BTree a]
unInorder [] = [Empty]
unInorder l = [Node ]

-- Básicamente o que se está a fazer é percorrer a lista e para cada elemento da lista, vamos criar uma árvore com esse elemento como raiz
-- isso é o que se está a fazer com o c <- [0..length l-1]
-- Depois vamos criar as sub-árvores da esquerda e da direita
-- Para isso vamos usar a função unInorder e passar como argumento a lista até ao elemento c e depois a lista depois do elemento c
-- Para finalizar, temos que ter em consideração que o elemento c é um indice e nao um elemento da lista
-- Por isso temos que usar o operador (!!) para obter o elemento da lista
unInorder l = [Node ((!!) l c) e d | c <- [0..length l-1], e <- unInorder (take c l), d <- unInorder (drop (c+1) l)]



EXAME 2022.2023


1. 
--Considere que se usa o tipo type MSet a = [(a,Int)] para representar multi-conjuntos de elementos de a. 
--Considere ainda que nestas listas nao ha pares cuja primeira componente coincida,nem cuja segunda componente seja menor ou igual a zero


a) 
--Defina a funcao que converte um multi-conjunto na lista dos seus elementos 
--Por exemplo, converteMSet [(’b’,2), (’a’,4), (’c’,1)] corresponde a "bbaaaac"

converteMSet :: MSet a -> [a]
converteMSet [] = []
converteMSet ((h,s):t) = h : converteMSet t 


b) 
--Defina a funcao  que remove um elemento a um multi-conjunto. Se o elemento nao existir, deve ser retornado o multi-conjunto recebido.
Por exemplo, removeMSet ’c’ [(’b’,2), (’a’,4), (’c’,1)] corresponde a [(’b’,2),(’a’,4)], 
e removeMSet ’a’ [(’b’,2), (’a’,4), (’c’,1)] corresponde a [(’b’,2),(’a’,3), (’c’,1)]

removeMSet :: Eq a => a -> MSet a -> MSet a
removeMSet n [] = []
removeMSet n ((h,s)t) = if n == h 
                      then removeMSet n t 
                      else h : removeMSet n t 




c)
--Defina a funcao que faz a uniao de dois multi-conjuntos.
Por exemplo, uniaoMSet [(’b’,2),(’a’,4),(’c’,1)] [(’c’,7),(’a’,3),(’d’,5)] corresponde a [(’c’,8),(’a’,7),(’d’,5),(’b’,2)]


uniaoMSet :: Eq a => MSet a -> MSet a -> MSet a 
uniaoMSet ((h,s):t) ((h',s'):t) = | h == h' = (h, s ++ s') uniaoMSet t t' 
                                  | otherwise (h,s) : (h',s') : uniaoMSet t t'



2.
--Considere o seguinte tipo usado para descrever movimentos de um robot e a sua posicao numa grelha.

type Posicao = (Int,Int)
data Movimento = Norte | Sul | Este | Oeste
data Caminho = C Posicao [Movimento]
Defina uma instancia da classe Eq para o tipo Caminho, considerando iguais os caminhos com a mesma posicao de partida e 
de chegada e com o mesmo numero de movimentos.


instance Eq Caminho where 

posicao :: Eq -> Caminho -> Caminho -> Bool
posicao (C pos1 mov1) (C pos2 mov2) = pos1 == pos2 && posicaoAux mov1 mov2


posicaoAux :: [Movimento] -> [Movimento] -> Bool
posicaoAux (h:t) (h':t') = h == h' && posicaoAux t t' 
posicaoAux [] [] = True 


3.
--Apresente uma definicao alternativa da funcao func, usando recursividade explıcita em vez de funcoes de ordem superior
-- e fazendo uma unica travessia da lista.


func :: [[Int]] -> [Int]
func l = concat (filter (\x -> sum x >10) l)


func :: [[Int]] -> [Int] 
func [] = []
func (h:t) = if sum h > 10
            then h ++ func t 
            else func t 


EXAME 2021-2022


1.
--Apresente uma definicao recursiva da funcao (pre-definida) que dado um inteiro e um elemento x constroi uma lista 
--com n elementos, todos iguais a .
Por exemplo, replicate 3 10 corresponde a [10,10,10].


replicate :: Int -> a -> [a]
replicate 0 a = []
replicate n a = if n > 0 
               then a replicate (n-1) a 
               else []


2.
--Apresente uma definicao recursiva da funcao  que retorna a lista resultante de remover da primeira lista os elementos que nao
-- pertencem a segunda.
Por exemplo, intersect [1,1,2,3,4] [1,3,5] corresponde a [1,1,3].


intersect :: Eq a => [a] -> [a] -> [a]
intersect [] (h:t) = []
intersect (h:t) l = if h 'elem' l 
                         then h : intersect t l
                         else intersect t l 

3.

--Recorde as declaracoes das leaf trees e full trees.

data LTree a = Tip a | Fork (LTree a) (LTree a)
data FTree a b = Leaf a | No b (FTree a b) (FTree a b)

--Defina a funcao que recebe uma LTree Int e gera uma arvore FTree Int Int com a mesma forma, que preserva o valor das folhas 
--e coloca em cada no a soma de todas as folhas da arvore com raiz nesse no.


conv :: LTree Int -> FTree Int Int 
conv Tip a = 










