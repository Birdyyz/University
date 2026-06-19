--Faça uma função que recebe um numero e retorna verdadeiro se o numero for par.
par :: Int -> Bool 
par h = if mod h 2 == 0 
        then True 
        else False



--5. Faça uma função que recebe dois valores e retorna o menor.

menor :: Int -> Int -> Int
menor x y = if x < y 
            then x 
            else y

--6. Faça uma função que recebe três valores e retorna o menor.

menor3 :: Int -> Int -> Int -> Int 
menor3 x y z | x < y && x < z = x 
             | x > y && y < z = y 
             | otherwise = z 
             
--7.Escreva uma função recursiva para calcular o fatorial de um numero natural

fatorial :: Int -> Int
fatorial 0 = 1
fatorial n = n * fatorial (n - 1)

-- nro-elementos: recebe uma lista qualquer e retorna o número de elementos na lista.
nroelementos :: [a] -> Int 
nroelementos [x] = 1 
nroelementos [] = 0 
nroelementos (h:t) = 1 + length t 


-- maior: recebe uma lista de números e retorna o maior 

maior :: Ord a => [a] -> a
maior [x] = x
maior (h:t) = if h > maior t
               then h
               else maior t

--conta-ocorrencias: recebe um elemento e uma lista qualquer e retorna o número de ocorrências do elemento na lista.
contaocorrencias :: Eq a => a -> [a] -> Int 
contaocorrencias n [] = 0 
contaocorrencias n (h:t) = if n == h 
                          then 1 + contaocorrencias n t 
                          else contaocorrencias n t 


--unica-ocorrencia: recebe um elemento e uma lista e verifica se existe uma única ocorrência do elemento na lista
unicaOcorrencia::Int -> [Int] -> Bool
unicaOcorrencia a lista =
 if (contaocorrencias a lista == 1) then True else False