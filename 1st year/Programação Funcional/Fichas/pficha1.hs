O import tem que estar sempre no inicio do ficheiro

Ficha 1
1. 
a)
perimetro :: Double -> Double
perimetro r: 2*pi*r

b)
dist :: (Double,Double)->(Double,Double)->Double
dist (x^1,y^1)(x^2,y^2)=sqrt(x^2)
primUlt::
primUlt l=(head l, last l)

d)
multiplo::Int->Int->Bool
multiplo m n |mod m n ==0=True
             |otherwise=False
ou 
multiplo = \x y -> (x `mod` y) == 0
e)
truncalmpar::
truncalmparl|mod(lengthl)2
ou
truncalmpar (h:t)|mod(lenght(h:t))2==1=+
                 |otherwise=(h:t)

f)
max2==Int->Int->Int
max2 ab| a>b=a
       |otherwise b
max2 ab = \ a b -> if a > b then a else b 

g)
max3 :: Int->Int->Int->Int
max3 abc=max2(max2 ab)c

2.

 ax^2+bx+c=0
 delta= b^2-4ac
 delta<0---- 0 soluções
 delta=0----1 solução
 delta>0------ 2 solucões
 
 delta :: float->float->float->float
 delta a b c =b^2-4*a*c

a)
nRaizes :: Float-> Float-> Float-> Int
nRaizes a b c|delta a b c <0=0
             |delta a b c == 0 = 1
             |otherwise = 2
ou
nRaizes :: (Float, Float, Float) -> Integer
nRaizes (a, b, c) | b == 0 = 1
                  | b > 0 = 2
                  | b < 0 = 0
                  where b = binomio (a, b, c)
ou
nRaizes :: Float -> Float -> Float ->Int
nRaizes a b c = let d = delta a b c 
                in if d<0
                   then 0
                   else (if d == 0 then 1 else 2)
ou 
nRaizes = \a b c ->
    case compare (b^2 - 4*a*c) 0 of
        GT -> 2
        EQ -> 1
        LT -> 0
        
definir variáveis reais---- where;let
condicionais--------------- if then else; guardas


5.
data Semaforo = Verde | Amarelo | Vermelho deriving (Show,Eq)

(a) Defina a fun¸c˜ao next :: Semaforo -> Semaforo que calcula o pr´oximo estado
de um sem´aforo.
next :: Semaforo -> Semaforo
next x =   | x === Verde = Amarelo
        | x== Amarelo = Vermelho
        | x == Vermelho = Verde




(b) Defina a funcao stop :: Semaforo -> Bool que determina se ´e obrigat´orio parar
num semaforo.
stop :: Semaforo -> Bool
stop x = if x == Vermelho 
         then True
         else False

  



(c) Defina a funcao safe :: Semaforo -> Semaforo -> Bool que testa se o estado
de dois semaforos num cruzamento e seguro.

safe :: Semaforo -> Semaforo -> Bool
safe x y = x == Vermelho || y == Vermelho
















8) tabela ascii

a) isLower :: Char -> Bool 
isLower c = if (ord c >= 97 && ord<= 122)
            then True
            else False
ou 
isMinuscula :: Char -> Bool
isMinuscula carater = elem (ord carater) [97..122]

b) 
isDigito :: Char -> Bool
isDigito carater = elem (ord carater) [48..57]

c)
isLetra :: Char -> Bool
isLetra carater = elem (ord carater) [65..90] || isMinuscula carater

d)
paraMaiuscula :: Char -> Char
paraMaiuscula letra = if isMinuscula letra
    then chr (ord letra - 32)
    else error "Insira uma letra minuscula"

ou
toUpper :: Char -> Char
toUpper c = if (is lower c)then chr (ord c - 32)
                           else c


e) 
inteiroParaDigito :: Int -> Char
inteiroParaDigito numero = if elem numero [0..9]
    then chr (numero + 48)
    else error "Insira um numero"

f) 
digitoParaInteiro :: Char -> Int
digitoParaInteiro digito = if isDigito digito
    then ord digito - 48
    else error "Insira um digito"


                                               

