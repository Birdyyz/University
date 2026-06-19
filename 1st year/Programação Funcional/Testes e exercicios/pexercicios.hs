







--calcula numero de elementos que uma árvore binaria tem
elementos :: Btree a -> [a]
elementos Empty = []
elementos ( N x l r) = 1 + elementos l + elementos r 


--comparar elementos iguais
elem :: Eq a -> a -> [a] -> Bool
elem n [] = False
elem n (h:t) = if n == h then True 
              else elem n t 


--Defina uma instância de Eq para o seguinte tipo de dados:







--Defina uma instância de Show para o seguinte tipo de dados:

data Cor = Vermelho | Verde | Azul
--A instância deve converter uma cor para uma representação em string.

instance Show Cor where
    show Vermelho = "Vermelho"
    show Verde = "Verde"
    show Azul = "Azul"


--Defina uma instância de Ord para o seguinte tipo de dados


data DiaDaSemana = Segunda | Terca | Quarta | Quinta | Sexta | Sabado | Domingo
--A ordem deve seguir a sequência usual dos dias da semana.


instance Ord DiaDaSemana where 
    compare Segunda Terça = LT
    compare Terça Quarta = LT 
    compare Quarta Quinta = LT
    compare Quinta Sexta = LT 
    compare Sexta Sabado = LT 
    compare Sabado Domingo = LT 
    compare Domingo _ = GT 



-- Exemplo de uso: dobrarLista (\x -> x * 2) [1, 2, 3] deve retornar [2, 4, 6]


dobrarLista :: (a -> b) -> [a] -> [b]
dobrarLista f l = map f l 



-- Exemplo de uso: filtrarPares [1, 2, 3, 4, 5] deve retornar [2, 4]

filtrarPares :: [Int] -> [Int]
filtrarPares lista = filter (\x -> x `mod` 2 == 0) lista


randomSel :: Int -> [a] -> IO [a] 


type Nome = String
type Telefone = Integer
data Agenda = Vazia | Nodo (Nome,[Telefone]) Agenda Agenda
 
instance Show Agenda where 
    Show vazia = []
    Show (Nodo(n,[t]) l r) = Show l ++ "\n" ++ Show n ++ intercalte "/" (map Show t ) ++ "\n" ++ Show r 



