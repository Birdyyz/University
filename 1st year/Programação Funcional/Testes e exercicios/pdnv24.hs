--Defina a função , que dado um numero n e um valor v , constroi uma lissta com n elementos alternadamente 
--v -v.
--Exemplo : alterna 5 2 = [2,-2,2,-2,2]
alterna :: Num a => Int -> a -> [a]
alterna 0 t = []
alterna n t = t : alterna (n-1) (-t) 

-- binaria de procura 

data Turma = Empty | Node (Integer,String) Turma Turma

instance Show Turma where 
    show Empty = []
    show (Node(num,nom)l r) = show l ++ "\n" ++ show num ++ "\n" ++ show r 

    
limites :: Turma -> (Integer, Integer)
limites Empty = (0, 0)
limites (Node (h, s) l r) = (min (fst (limites l)) (fst (limites r)), max (snd (limites l)) (snd (limites r)))

type TabAbrev = [(Palavra,Abreviatura)]
type Palavra = String 
type Abreviatura = String


-- difMaior [("muito", "mt"), ("que", "q")] == ("muito",3)

difMaior :: TabAbrev -> (Palavra,Int)
difMaior [(h,s)] = (h, length h - length s)
difMaior ((h,s):t) = if length h - length s > dif 
                      then (h, length h - length s)
                      else (pal,dif)
    where (pal,dif) = difMaior t 


--recebe um texto e substitui todas as abreviaturas que aparecam no texto pelas palavras associadas

subst :: [String] -> TabAbrev -> [String]
subst [] _ = []
subst (w:r) t =
    if w `elem` (map fst t)
        then fst (head (filter (\(x, _) -> x == w) t)) : subst r t
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
