
sinalOposto :: (Num a, Ord a) => a -> a
sinalOposto x
  | x < 0     = -x
  | x == 0    = 0
  | x > 0     = -x



dobro :: Num a => a -> a 
dobro x = 2 * x

-- fazer uma função onde receba dois inteiros e intercale numero positivo e numero negativo

intercalarNum :: (Num a, Ord a)  => a -> a -> [a]
intercalarNum 0 y = []
intercalarNum x y = y : (intercalarNum (x-1) (-y))



type MSet a = [(a,Int)] 
--converteMSet [(’b’,2), (’a’,4), (’c’,1)] corresponde a "bbaaaac".
converteMSet :: MSet a -> [a]
converteMSet [] = []
converteMSet ((h,s):t) = if s == 0 
                        then converteMSet t 
                        else h : converteMSet ((h,(s-1)) : t)

--removeMSet ’c’ [(’b’,2), (’a’,4), (’c’,1)] = [(’b’,2),(’a’,4)]
--removeMSet ’a’ [(’b’,2), (’a’,4), (’c’,1)]= [(’b’,2),(’a’,3), (’c’,1)]
--verificar se e igual
--se for igual tira 1 
--se tiver o valor 1 desaparece
removeMSet :: Eq a => a -> MSet a -> MSet a
removeMSet n [] = []
removeMSet n ((h,1):t) = if n == h 
                         then removeMSet n t 
                         else ((h,1)) : removeMSet n t 
removeMSet n ((h,s):t) = if n == h 
                        then ((h, s-1):t)
                        else ((h,s)) : removeMSet n t 


--caso for igual soma os valores
uniaoMSet :: Eq a => MSet a -> MSet a -> MSet a
uniaoMSet l [] = l
uniaoMSet [] l = l
uniaoMSet ((h,s):t) ((h',s'):t')
  | h == h' = (h, s + s') : uniaoMSet t t'
  | (h, s) : uniaoMSet t ((h',s'):t')
   otherwise = (h', s') : uniaoMSet ((h,s):t) t'
                              
        




