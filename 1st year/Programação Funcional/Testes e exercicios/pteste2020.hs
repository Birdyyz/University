
1.
--Apresente uma definicao recursiva da funcao  que retorna a lista resultante de remover (as primeiras ocorrencias)
-- dos elementos da segunda lista da primeira. 

Por exemplo,
(\\) [1,2,3,4,5,1,2] [2,3,4,1,2] == [5,1].



(\\) :: Eq a => [a] -> [a] -> [a]
(\\) [] _ = []
(\\) xs [] = xs
(\\) l (h:t) = (\\) (delete h l) t
    where
        delete :: Eq a => a -> [a] -> [a]
        delete _ [] = []
        delete x (h:t)
            | x == h = t
            | otherwise = h : delete x t



2.


a)
--Defina a funcao que remove um elemento a um multi-conjunto. Se o elemento nao existir, deve ser retornado o multi-conjunto recebido.
--Por exemplo, removeMSet ’c’ [(’b’,2), (’a’,4), (’c’,1)] == [(’b’,2), (’a’,4)].

type MSet a = [(a,Int)]


removeMSet :: Eq a => a -> [(a,Int)] -> [(a,Int)]
removeMSet n ((a:b):t) = if n == a 


3.
--Defina a fun¸c˜ao  que parte uma string pelos pontos onde um
--dado caracter ocorre. Por exemplo, partes "um;bom;exemplo;" ’;’ == ["um","bom","exemplo"] e partes "um;exemplo;qualquer" ’;’ == ["um","exemplo","qualquer"].

partes :: String -> Char -> [String],
partes 


















4.
--Considere o seguinte tipo para representar árvores binárias de procura
data BTree a = Empty | Node a (BTree a) (BTree a)

a1 = Node 5 (Node 3 Empty Empty)
            (Node 7 Empty (Node 9 Empty Empty))

a) 
--Defina a função que remove um elemento de uma árvore binária de procura.



remove :: Ord a => a -> BTree a -> BTree a
remove n Empty = Empty 
remove n (Node x l r) = | n == x = Node l r 
                        | n < x = Node x (remove n l) r 
                        | n > x = Node x l (remove n r)


b) 
--Defina BTree a como uma instância da classe Show de forma a que show a1 produza a string ((* <-3-> *) <-5-> (* <-7-> (* <-9-> *)))

instance Show BTree a where
show :: Show a -> B Tree a -> String 
show Empty = "*"
show (Node x l r) ="(" ++ show x ++ "<-" ++ show l ++ "->" ++ show r ++ ")"




TESTE 2022


Teste 2022

1.
--Apresente uma definicao recursiva da funcao (pre-definida) constroi uma lista de pares a partir de duas listas. 
Por exemplo, zip [1,2,3] [10,20,30,40]
corresponde a [(1,10),(2,20),(3,30)].


zip :: [a] -> [b] -> [(a,b)]
zip _ [] = []
zip [] _ = []
zip (h:t) (h':t') = (h,h') : zip t t'



2.
--Defina a funcao que calcula o maior prefixo crescente de uma lista. 
Por exemplo, preCrescente [3,7,9,6,10,22] corresponde a [3,7,9] e
preCrescente [1,2,7,9,9,1,8] corresponde a [1,2,7,9].

preCrescente :: Ord a => [a] -> [a] 
preCrescente (h:s:t) = if h >= s 
                       then preCrescente h : preCrescente s t 
                       else [h]
3.
--A amplitude de uma lista de inteiros define-se como a diferenca entre o maior e o menor dos elementos da lista 
--(a amplitude de uma lista vazia ´e 0). Defina a funcao que calcula a amplitude de uma lista 
--(idealmente numa ´unica passagem pela lista).

amplitude :: [Int] -> Int
amplitude [] = 0
amplitude (h:t) = go t h h
  where
    go :: [Int] -> Int -> Int -> Int
    go [] minValue maxValue = maxValue - minValue
    go (y:ys) minValue maxValue =
      go ys (min minValue y) (max maxValue y)

4.

--Considere o sequinte tipo type Mat a = [[a]] para representar matrizes. Defina a fun¸c˜ao  que soma 
--duas matrizes da mesma dimens˜ao


soma :: Num a => Mat a -> Mat a -> Mat a
soma (h:t) (h':t') = zipWith h h' : soma t t' 

5.
--Decidiu-se organizar uma agenda telefonica numa arvore binaria de procura (ordenada por ordemalfabetica de nomes). 
--Para isso, declararam-se os seguintes tipos de dados:


type Nome = String

type Telefone = Integer

data Agenda = Vazia | Nodo (Nome,[Telefone]) Agenda Agenda

--Defina Agenda como instancia da classe Show de forma a que a visualizacao da arvore resulte
--numa listagem da informacao ordenada por ordem alfabetica (com um registo por linha) e em
--que os varios telefones associados a um nome se apresentem separados por /

instance Show Agenda where 

show Vazia = ""
show Nodo ((Nome, tele) l r ) = show l ++ "/" ++ nome ++ ++ " " ++ intercalate "/" (map show tlfs) ++ "\n" ++ show r







7.
--Defina uma funcao que, dada uma lista constroiuma lista em que, para cada elemento da lista original 
--se guarda a lista dos ´ındices onde esse elemento ocorre
Por exemplo, organiza "abracadabra" corresponde a [(’a’,[0,3,5,7,10]),
(’b’,[1,8]), (’r’,[2,9]),(c,[4])]


organiza :: Eq a => [a] -> [(a,[Int])]
organiza = foldr (\a -> insere a . map (\(c,is) -> (c,map (+1) is))) []

insere :: Eq a => a -> [(a,[Int])] -> [(a,[Int])]
insere x [] = [(x,[0])]
insere x ((c,is):t)
    | x == c = (c, 0 : is) : t
    | otherwise = (c,is) : insere x t

8.
--Apresente uma definicao alternativa da funcao func, usando recursividade explıcita em vez de funcoes de ordem superior 
--e fazendo uma unica travessia da lista.

func :: [[Int]] -> [Int]
func l = concat (filter (\x -> sum x >10) l)


func' :: [[Int]] -> [Int]
func' (h:t) = if sum h > 10 
             then h ++ func' t 
             else func' t 


9.
Defina a função insere :: String -> String -> Dictionary -> Dictionary que, dadas uma palavra
 e a informação a ela associada, acrescenta essa entrada no dicionário. Se a palavra já existir no dicionário, 
 atualiza a informação a ela associada.
Quando uma palavra está completa, o valor associado à última letra é Just s, sendo s uma string com a descrição da palavra
 em causa (que corresponde ao caminho desde a raiz até aí). Caso contrário é Nothing.
Por exemplo, d1 é um dicionário com as palavras: cara, caras, caro e carro.


data RTree a = R a [RTree a]
type Dictionary = [ RTree (Char, Maybe String) ]

insere :: String -> String -> Dictionary -> Dictionary 
insere [x] desc dict = insereFim x desc dict
insere (h:t) desc [] = [ R (h,Nothing) (insere t desc [])]
insere (h:t) desc (R (a,b) l:d)
    | h == a = R (a,b) (insere t desc l) : d
    | otherwise = R (a,b) l : insere (h:t) desc d

insereFim :: Char -> String -> Dictionary -> Dictionary
insereFim x desc [] = [ R (x,Just desc) [] ]
insereFim x desc (R (a,b) l:t) 
    | x == a = R (a,Just desc) l : t
    | otherwise = R (a,b) l : insereFim x desc t












