
type TabAbrev = [(Palavra,Abreviatura)]
type Palavra = String 
type Abreviatura = String


--recebe uma tabela nao vazia e descobre a plaavra da tabela que mais simplifica)
-- exemplo: difMaior [("muito","mt"),("que","q")] == ("muito",3)

difMaior :: TabAbrev -> (Palavra, Int)
difMaior [(h, s)] = (h, length h - length s)
difMaior ((h, s):t) =
  if length h - length s > dif
    then (h, length h - length s)
    else (palavra, dif)
  where
    (palavra, dif) = difMaior t

--recebe um texto e substitui todas as abreviaturas que aparecam no texto pelas palavras associadas

subst :: [String] -> TabAbrev -> [String]
subst [] _ = []
subst (word:rest) tabela = 
  case filter (\(_, abr) -> abr == word) tabela of
    [] -> word : subst rest tabela
    ((palavra, _):_) -> palavra : subst rest tabela


--dumpLT (Fork (Tip 'a')(Fork(Tip 'b')(Tip 'c')))
data LTree a = Tip a | Fork (LTree a) (LTree a)

dumpLT :: LTree a -> [(a, Int)]
dumpLT (Tip x) = [(x, 1)]
dumpLT (Fork e d) = map (\(x, y) -> (x, y + 1)) (dumpLT e ++ dumpLT d)
  where
    f :: (a, Int) -> (a, Int)
    f (x, y) = (x, y + 1)

dumpLT' :: LTree a -> [(a, Int)]
dumpLT' (Tip x) = [(x, 1)]
dumpLT' (Fork e d) = map (\(x, y) -> (x, y + 1)) (dumpLT e ++ dumpLT d)

instance Show a => Show (LTree a) where
  show (Tip x) = "Tip " ++ show x
  show (Fork l r) = "Fork (" ++ show l ++ ") (" ++ show r ++ ")"

undumpLT :: [(a, Int)] -> LTree a 
undumpLT [(x,1)] = Tip x
undumpLT ((x,n):t) | n == 1 = Tip x
                   | n > 1 = Fork (Tip x) (undumpLT t)