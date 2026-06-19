3.
data Contacto = Casa Integer
| Trab Integer
| Tlm Integer
| Email String
deriving Show
type Nome = String
type Agenda = [(Nome, [Contacto])]


a)
 que,
dado um nome, um email e uma agenda, acrescenta essa informacao a agenda
 acrescEmail :: Nome -> String -> Agenda -> Agenda
 acrescEmail n e [] = [(n,[e])]
 acrescEmail n e (()) 


 4.
 type Dia = Int
type Mes = Int
type Ano = Int
type Nome = String
data Data = D Dia Mes Ano
deriving Show
type TabDN = [(Nome,Data)]


a)  que indica a data de nascimento de uma dada pessoa, caso o seu nome exista na tabela
 procura :: Nome -> TabDN -> Maybe data 
 procura _ [] = Nothing 
 procura n ((ns,d):t) = if n == ns 
                       then d 
                       else procura n t 

b)que calcula a idade de uma pessoa numa dada data.
idade :: Data -> Nome -> TabDN -> Maybe Int
idade 


c) que testa se uma data é anterior a outra data.
 
anterior :: Data -> Data -> Bool
anterior (D d1 m1 a1) (D d2 m2 a2) = a1 < a2 || a1 == a2 (m1 < m2) || a1 == a2 (m1 == m2 && d1 < d2) 

d)
--que ordena uma tabela de datas de nascimento, por ordem crescente das datas de nascimento.
ordena :: TabDN -> TabDN
ordena [] = []
ordena ((n,d):t) = ordenaAux (n,d) : orderna t 


ordenaAux :: (Nome,Data) -> TabDN -> TabDN

ordernaAux (n,d) [] = [(n,d)]
ordenaAux (n,d) ((nh,dh):t) | anterior d dh = (n,d) : (nh,dh) : t
                            | otherwise = (nh,dh) : ordenaAux (n,d) t


e)
--que apresenta o nome e a idade das pessoas, numa dada data, por ordem crescente da idade das pessoas.
 porIdade:: Data -> TabDN -> [(Nome,Int)]
 porIdade (D d m a) 




 porIdadeAux 