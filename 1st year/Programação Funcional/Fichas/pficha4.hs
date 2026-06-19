import Data.char


-- Que dada uma string,
devolve um par de strings: uma apenas com as letras presentes nessa string, e a outra
apenas com os numeros presentes na string. Implemente a funcao de modo a fazer uma
unica travessia da string.
-- Relembre que as funcoes isDigit,isAlpha :: Char -> Bool
estao ja definidas no modulo Data.Char.
-- "ola3x2" = ("olar", "32")
-- isDigit 'q' = True
-- isAlpha 'l' = False
                           usar first e second como e uma string 
digitAlpha :: String -> (String,String)
digitAlpha [] = [[],[]]
digitAlpha (h:t) | isAlpha h = (h: first (digitAlpha t) second (snd) (digitAlpha t) )
                 | isDigit h = ( first (digitAlpha t), h : snd (digitAlpha t) )
                 | otherwise = digitAlpha t 
ou 
digitAlpha :: String -> (String,String)
digitAlpha (h:t) | isAlpha h = (h:a,b)
                 | isDigit h = (a,h:b)
                 |otherwise (a,b) = digitAlpha t 
ou
digitAlpha :: String -> (String,String) 
digitAlpha l = (filter isAlpha l, filter isDigit l) (duas travessias nao daria para usar se a pergunta diz uma travessia)
ou 
digitAlpha :: String -> (String,String) 
digitAlpha l = foldl func ( " ", " ") l
                    where func (a,b) x = if (isAlpha x ) then (x:a,b)
                    else if (isDigit x) then (a, x:b)
                    else (a,b)
ou 
 digitAlpha l =foldl 
               (\ (a,b) x -> if (isAlpha x) then (x:a,b))
               (" ", " ")
                l
  


--que dada uma string, devolve um par de strings: uma apenas com as letras presentes nessa string, e a outra
apenas com os numeros presentes na string. Implemente a funcao de modo a fazer uma
unica travessia da string. Relembre que as funcoes isDigit,isAlpha :: Char -> Bool
estao ja definidas no modulo Data.Char.

--casos: apenas com letras e outro apenas com numeros 
digitAlpha :: String -> (String,String)
digitAlpha [] = []
digitAlpha (h:t)= 
                  |isAlpha h = (h: letras , numeros)
                  | isDigit h = (letras, h:numeros)
                  |otherwise (letras,numeros)
                  where (letras,numeros) = digitAlpha t 
                  
                  
           
2.
-- dada uma lista de inteiros,
conta o numero de valores nagativos, o numero de zeros e o numero de valores positivos,
devolvendo um triplo com essa informacao. Certifique-se que a funcao que definiu
percorre a lista apenas uma vez.
                  <0  0  >0
nzp :: [Int] -> (Int,Int,Int) 
nzp [] = [ ]
nzp l = foldl (\(a,b,c) x -> if (x<0) then (a+1,b,c))
              else if (x>0) then (a,b,c+1)
              else (a,b+1,c)

nzp :: [Int] -> (Int,Int,Int) 
nzp (h:t) = 
            | h < 0 = (n+1 , z, p)
            | h > 0 = (n , z, p+1)
            | h == 0 = (n, z+1, p)
            where (n, z, p) = nzp t 

3.
que calcula simultaneamente a divisao e o resto da divisao inteira por subtraccoes sucessivas

 divMod :: Integral a => a -> a -> (a, a) 
 divMod x y=
            | x - y < 0 = (0,x)
            | otherwise = (q+1,r)
            where (q,r) = divMod (x - y) y

4.
Utilizando uma funcao auxiliar com um acumulador, optimize seguinte definicao recursiva que determina qual o numero que corresponde 
a uma lista de digitos

fromDigits :: [Int] -> Int
fromDigits [] = 0
fromDigits (h:t) = h*10^(length t) + fromDigits t

Note que
fromDigits [1,2,3,4] = 1 × 103 + 2 × 102 + 3 × 101 + 4 × 100
= 4 + 10 × (3 + 10 × (2 + 10 × (1 + 10 × 0)))

fromDigits :: [Int] -> Int
fromDigits l = fromDigitsAux l 0
fromDigits 

fromDigitsAux :: [Int] -> Int -> Int 
fromDigitsAux [] ac = ac 
fromDigitsAux (h:t) ac = fromDigitsAux t (h+10 *ac)


5. 
--utilizando uma funcao auxiliar com acumuladores, optimize a seguinte definicao que
determina a soma do segmento inicial de uma lista com soma maxima.

maxSumInit :: (Num a, Ord a) => [a] -> a
maxSumInit l = maximum [sum m | m <- inits l]

maxSumInit :: (Num a, Ord a) => [a] -> a
maxSumInit l = maxSumInitAux l (sum l)

maxSumInitAux :: (Num a, Ord a) => [a] -> a -> a
maxSumInitAux [] acc = acc
maxSumInitAux l acc = if si > acc 
                       then maxSumInitAux il si 
                       else maxSumInitAux il acc
    where il = init l
          si = sum il

ou

maxSumInit :: (Num a, Ord a) => [a] -> a
maxSumInit l = maximum [sum m | m <- inits l]

maxSumInit'' :: (Num a, Ord a) => [a] -> a
maxSumInit'' l = foldl (\ acc x -> max(sum x) acc) (sum l) (inits l)

6.
--Optimize a seguinte definição recursiva da função que calcula o n-ésimo número da
sequência de Fibonacci, usando uma função auxiliar com 2 acumuladores que representam, respectivamente, 
o n-ésimo e o n+1-ésimo números dessa sequência.

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

fib :: Int -> Int
fib n = aux (0,1) n
         where aux :: (Int,Int) -> Int -> Int
               aux (a,b) 0 = a
               aux (a,b) 1 = b
               aux (a,b) x | x>1 = aux (a,a+b) (x-1)


7.
--que converte um inteiro numa string. Utilize uma funcao auxiliar com um acumulador onde vai construindo a string
que vai devolver no final.

intToStr :: Integer -> String 
intToStr 0 = "zero"
intToStr n = intToStrAux n ""


intToStrAux :: Integer -> String -> String
intToStrAux 0 ('-':acc) = acc
intToStrAux n acc = intToStrAux nn ((case r of 
        0 -> "-zero"
        1 -> "-um"
        2 -> "-dois"
        3 -> "-três"
        4 -> "-quatro"
        5 -> "-cinco"
        6 -> "-seis"
        7 -> "-sete"
        8 -> "-oito"
        9 -> "-nove") ++ acc)
    where (nn,r) = n `divMod` 10




8.
--Para cada uma das expressoes seguintes, exprima por enumeracao a lista correspondente. 
--Tente ainda, para cada caso, descobrir uma outra forma de obter o mesmo
resultado.

a) [x | x <- [1..20], mod x 2 == 0, mod x 3 == 0] -- lista por compreensao
  |     gerador     |         restricao          |
= [6,12,18]
[x | x <- [1..20], mod x 6 == 0]
 b) [x | x <- [y | y <- [1..20], mod y 2 == 0], mod x 3 == 0]
               |               pares de 1 a 20              |  
[6,12,18]            
[x | x <- [1..20], mod x 6 == 0]
 c)[(x,y) | x <- [0..20], y <- [0..20], x+y == 30]

[(x, 30 - x) | x <- [10..20]]

d) [sum [y | y <- [1..x], odd y] | x <- [1..10]]


[ x^2 | x <- [1..5], y <- [1..2]]

9.
a) [1,2,4,8,16,32,64,128,256,512,1024]

[ 2^x | x <- [0..10]]

b) [(1,5),(2,4),(3,3),(4,2),(5,1)]

[(x,y) | x <- [1..5], y <- [1..5], x + y == 6]

c) [[1],[1,2],[1,2,3],[1,2,3,4],[1,2,3,4,5]]

[[1..x] | x <- [1..5]]

d) [[1],[1,1],[1,1,1],[1,1,1,1],[1,1,1,1,1]]

[ replicate x 1 | x <- [1..5]]

e) [1,2,6,24,120,720]

[ product [y | y <- [1..x]] | x <- [1..6]]