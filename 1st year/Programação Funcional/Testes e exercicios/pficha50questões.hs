Ficha


1) 
enumFromTo :: Int -> Int -> [Int] 
enumFromTo x y = [x..y]

2)
enumFromThenTo :: Int -> Int -> Int -> [Int]
enumFromThenTo x y z | x==z = [x]
                      | x<z = x:enumFromThenTo (x+(y-1)) y z 
                      | otherwise = []

3)
(++) :: [a] -> [a] -> [a]
(++) [] l =l 
(++) (h:t) l = h: ((++) t l)

4) 
 (!!) :: [a] -> Int -> a
 (!!) (h:t) 0 = h 
 (!!) (h:t) x = (!!) t (x-1)

5) 
reverse :: [a] -> [a]
reverse [] = []
reverse (h:t) = reverse t ++ [h]

6)
take :: Int -> [a] -> [a] 
take n [] = []
take n (h:t) = if n > 1+ length t 
               then h : take (n-1) t
               else (h:t)



7) 
drop :: Int -> [a] -> [a]
drop n [] = []
drop n (h:t) = if n <= 1 + length t 
               then []
               else drop (n-1) t 








