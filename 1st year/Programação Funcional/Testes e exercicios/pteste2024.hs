--Defina a função , que dado um numero n e um valor v , constroi uma lissta com n elementos alternadamente 
--v -v.
--Exemplo : alterna 5 2 = [2,-2,2,-2,2]

alterna :: Num a => Int -> a -> [a]
alterna 0 _ = []
alterna x y = y : alterna (x-1) (-y)


--Considere o seguinte tipo de dados para guardar os numeros e nomes dos alunos numa arvore
--binaria de procura ordenada por numero de aluno

data Turma = Empty | Node (Integer,String) Turma Turma

--Declare Turma como instancia da classe Show de forma a que a visualização da turma seja uma listagem da turma por ordem crescente de 
--numero de aluno, com um registo por linha


--binaria de procura
instance Show Turma where
  show Empty = ""
  show (Node (h,s)l r) = show l ++ "\n" ++ show h ++ "\n" ++ show r 




limites :: Turma -> (Integer, Integer)
limites Empty = (0, 0)
limites (Node (h, s) l r) = (min (fst (limites l)) (fst (limites r)), max (snd (limites l)) (snd (limites r)))

type TabAbrev = [(Palavra,Abreviatura)]
type Palavra = String 
type Abreviatura = String


-- difMaior [("muito", "mt"), ("que", "q")] == ("muito",3)
difMaior :: TabAbrev -> (Palavra,Int)
difMaior [(h,s)] = (h, length h ´-length s) 
difMaior ((h,s):t) = if length h - length s > dif
                    then (h,length h-length s)
                    else (palavra,dif)
     where 
      (palavra,dif) = difMaior t 
                

--recebe um texto e substitui todas as abreviaturas que aparecam no texto pelas palavras associadas

subst :: [String] -> TabAbrev -> [String]
subst [] _ = []
subst (w:r) t = if w `elem` (map fst t)
                     then subst r t
                     else w : subst r t

--dumpLT (Fork (Tip 'a')(Fork(Tip 'b')(Tip 'c')))
data LTree a = Tip a | Fork (LTree a) (LTree a)

dumpLT :: LTree a -> [(a, Int)]
dumpLT (Tip x) = [(x, 1)]
dumpLT (Fork e d) = map (\(x, y) -> (x, y + 1)) (dumpLT e ++ dumpLT d)
  where
    f :: (a, Int) -> (a, Int)
    f (x, y) = (x, y + 1)



dumpLTt :: LTree a -> [(a, Int)]
dumpLTt tree = dumpLT' tree 1
  where
    dumpLT' :: LTree a -> Int -> [(a, Int)]
    dumpLT' (Tip x) level = [(x, level)]
    dumpLT' (Fork left right) level = dumpLT' left (level + 1) ++ dumpLT' right (level + 1)



instance Show a => Show (LTree a) where
  show (Tip x) = show x
  show (Fork left right) = "Fork (" ++ show left ++ ") (" ++ show right ++ ")"




undumpLT :: [(a, Int)] -> LTree a 
undumpLT lista = undumpLT' 0 lista

undumpLT' :: Int -> [(a, Int)] -> LTree a
undumpLT' level ((x, n) : t)
  | n > 0 = Fork (Tip x) (undumpLT' (x,n-1):t)
  | otherwise = Tip x
  where
    t' = replicate n (Tip x)