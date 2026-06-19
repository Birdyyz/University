--replicate 3 10 corresponde a [10,10,10]
multiplicar :: Int -> a -> [a]
multiplicar 0 _ = []
multiplicar x y = y : multiplicar (x-1) y


--intersect [1,1,2,3,4] [1,3,5] corresponde a [1,1,3]
intersect :: Eq a => [a] -> [a] -> [a]
intersect l [] = []
intersect [] l = []
intersect (h:t) l = if  h `elem` l 
                    then h : intersect t l 
                    else intersect t l 
                        


bingo :: IO ()
bingo = bingoAux [1..90]

bingoAux :: [Int] -> IO ()
bingoAux [] = return ()
bingoAux prev_ns = do
    putStr "Prime ENTER para gerar um novo número."
    getChar
    random_index <- uniformRM (1, length prev_ns) globalStdGen
    let n = prev_ns !! (random_index - 1)
    print n
    bingoAux (delete n prev_ns)