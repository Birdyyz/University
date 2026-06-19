Ficha 2---------------------------------------

1)
a)
funA :: [Double] -> Double
funA [] = 0
funA (y:ys) = y^2 + (funA ys)
funA [2,3,5,1] =??-------- funA (2:[3,5,1]) = 2^2 + funA [3,5,1]=4+ funA (3:[5,1])= 4+3^2+ funA (5:[1])=13+5^2 + funA (1: [])
                                                                                                       =38+ 1^2 + funA [] = 39+0=39
                                 y    ys

                                
listas podem ser representadas por: ( : ) ; [] ; & (variavel)

b)
funB :: [Int] -> [Int]
funB [] = []
funB (h:t) = if (mod h 2)==0 then h : (funB t)
                          else (funB t)
 funB [8,5,12]=??------------- funB (8:[5,12])= 8 : funB [5:12] = 8 : 0 : funB [12] = 8:12: funB [] = [8,12]


c) 
funC (x:y:t) = funC t
funC [x] = [x]
funC [] = []

funC [1,2,3,4,5] = [1,2,3,4,5]
{devolve a lista que recebe}







d)
funD l = g [] l
g acc [] = acc
g acc (h:t) = g (h:acc) t
funD "otrec" =??

tecnina de usar acumuladores
 (pegar a letra do inicio e colocar no inicio do outro)
" " "otrec"
"o" "trec"
"to" "rec"
"rto" "ec"
"erto" "c"
"certo" " "
 
f) 
tresUlt :: [a] -> [a]
if

2)
a)
a cada elemento da lista fazer o dobro ex: [1,2,3] -> [2,4,6] dobro n-> 2*n
dobros :: [Float] -> [Float]
dobros [] = []
dobros (h:t) = 2*h : dobros t 

f)

tresUlt :: [a] -> [a]
tresUlt [] = []
tresUlt [x] = [x]
tresUlt [x,y] = [x,y]
tresUlt [x,y,z] = [x,y,z]
tresUlt (h:t) = tresUl t 

 ou

tresUlt [] = []
           if (length (h:t)) <= 3 then (h:t)
           else tresUlt t

g)
segundos :: [(a,b)] -> [b]

    
i)
sumTriplos :: (Num a, Num b, Num c) => [(a,b,c)] -> (a,b,c)
sumTriplos [] = (0,0,0)
sumTriplos [] l l = 



2.
a)
--que recebe uma lista e produz a lista em que cada elemento e o dobro do valor correspondente na lista de entrada.
dobros :: [Float] -> [Float]
dobros [] = []
dobros (h:t) = 2* h : dobros t 

b)
--que calcula o numero de vezes que um caracter ocorre numa string.
numOcorre :: Char -> String -> Int
numOcorre _ " " = 0
numOcorre n (h:t) = if n == h 
                   then 1+ numOcorre n t 
                   else numOcorre n t 

c)
--que testa se uma lista so tem elementos positivos
positivos :: [Int] -> Bool
positivos [] = True 
positivos (h:t) = if h <=0 
                  then False
                  else positivos t 


d)
--que retira todos os elementos nao positivos de uma lista de inteiros
soPos :: [Int] -> [Int]
soPos [] = 0 
soPos (h:t) = if h<0 
               then soPos t 
               otherwise h: soPos t 


e) 
que soma todos os numeros negativos da lista de entrada
somaNeg :: [Int] -> Int

somaNeg (h:t) = if h<0 
                 then h + somaNeg t 
                 else somaNeg t 

f) 
devolve os ultimos tres elementos de uma lista. Se a lista de entrada tiver menos de tres elementos, devolve a propria lista
tresUlt :: [a] -> [a] 
tresUlt [] = []
tresUlt (h:t) = if length t < 3
              then (h:t)
              else tresUlt t 


g) 
--que calcula a lista das segundas componentes dos pares
segundos :: [(a,b)] -> [b] 
segundos []= []
segundos [(x,a):t] = a : segundos t 

h)
--que testa se um elemento aparece na lista como primeira componente de algum dos pares
nosPrimeiros :: (Eq a) => a -> [(a,b)] -> Bool 
nosPrimeiros _ [] = False 
nosPrimeiros x ((h1,_):t) = x == h1 || nosPrimeiros x t

i)
--soma umalista de triplos componente a componente.
--Por exemplo, sumTriplos [(2,4,11), (3,1,-5), (10,-3,6)] = (15,2,12)  

sumTriplos :: (Num a, Num b, Num c) => [(a,b,c)] -> (a,b,c) 
sumTriplos [] = (0,0,0)
sumTriplos ((a,b,c):t) = (a+ sumTriplos t , b +sumTriplos t , c + sumTriplos t)

3.
a)
--que recebe uma lista de caracteres, e selecciona dessa lista os caracteres que sao algarismos
soDigitos :: [Char] -> [Char]
soDigitos [] = []
soDigitos (h:t) = if h isDigit 
                 then h: soDigitos t
                 else soDigitos t 


b)
--que recebe uma lista de caracteres, e conta quantos desses caracteres sao letras minusculas
minusculas :: [Char] -> Int 
minusculas [] = 0
minusculas (h:t) = if h isLower
                 then 1+ minusculas t 
                 otherwise minusculas t 


c)
--que recebe uma string e devolve uma lista com os algarismos que ocorrem nessa string, pela mesma ordem
nums :: String -> [Int]
nums "" = []
nums (h:t)
    | isDigit h = digitToInt h : nums t
    | otherwise = nums t

4.
type Polinomio = [Monomio]
type Monomio = (Float,Int)
a) 
--de forma a que (conta n p) indica quantos monomios de grau n existem em p.
conta :: Int -> Polinomio -> Int 
conta n [] = 0
conta n ((c,g):t) = if n == g
                               then 1+ conta n t 
                               else conta n t 

b)
--que indica o grau de um polinomio.
 grau :: Polinomio -> Int 
 grau [] = 0
 grau ((c,g):t) = if g > grau t 
                  then g 
                  else grau t 
 c)
 --que selecciona os monomios com um dado grau de um polinomio.
 selgrau :: Int -> Polinomio -> Polinomio
 selgrau n [] = []
 selgrau n ((c:g):t) = if n == g 
                     then (c,g) : selgrau n t 
                     else selgrau n t 

d)
--que calcula a derivada de um polinomio
deriv :: Polinomio -> Polinomio 
deriv ((c,g)t) = if g == 0 
                then deriv t 
                else (c * g, (g-1)) : deriv t 


e) 
--que calcula o valor de um polinomio para uma dado valor de x
calcula :: Float -> Polinomio -> Float 
calcula x [] = 0
calcula x ((c,g):t) = c * (x ^ g) + calcula x t

f)
 --que retira de um polinomio os monomios de coeficiente zero
simp :: Polinomio -> Polinomio
simp [] = []
simp ((c,g):t) = if g == 0 
                 then simp t 
                 else (c,g) : simp t 

g) 
--  que calcula o resultado da multiplicacao de um monomio por um polinomio
mult :: Monomio -> Polinomio -> Polinomio
mult _ [] = []
mult (cm,gm) ((c,g):t) = (cm * c, gm + g) : mult (cm,gm) t

h)
--que dado um polinomio constroi um polinomio equivalente em que nao podem aparecer varios monomios com o mesmo grau.
normaliza :: Polinomio -> Polinomio 
normaliza [] = []
normaliza ((c,g):t) = normalizaAux (c,g) (normaliza t)

normalizaAux :: Monomio -> Polinomio -> Polinomio
normalizaAux m [] = [m]
normalizaAux (cm,gm) ((c,g):t)
    | gm == g = (cm + c,g) : t
    | otherwise = (c,g) : normalizaAux (cm,gm) t


i) 
--que soma dois polinomios de forma a que se os polinomios que recebe estiverem normalizados produz tambem um polinomio normalizado.
soma :: Polinomio -> Polinomio -> Polinomio 
soma :: Polinomio -> Polinomio -> Polinomio
soma p [] = p
soma [] p = p
soma ((c,g):t) p = somaAux (c,g) (soma t p)

somaAux :: Monomio -> Polinomio -> Polinomio
somaAux m [] = [m]
somaAux (cm,gm) ((c,g):t)
    | gm == g = (cm + c,g) : t
    | otherwise = (c,g) : somaAux (cm,gm) t


j) produto :: Polinomio -> Polinomio -> Polinomio que calcula o produto de
dois polin´omios

produto :: Polinomio -> Polinomio -> Polinomio
produto [] _ = []
produto (m:t) p = (mult m p) ++ produto t p

k) ordena :: Polinomio -> Polinomio que ordena um polin´omio por ordem crescente dos graus dos seus mon´omios.

ordena :: Polinomio -> Polinomio
ordena [] = []
ordena (m:t) = insere m (ordena t)

insere :: Monomio -> Polinomio -> Polinomio
insere m [] = [m]
insere (cm,gm) ((c,g):t)
    | g > gm = (cm,gm) : (c,g) : t
    | otherwise = (c,g) : insere (cm,gm) t


l) equiv :: Polinomio -> Polinomio -> Bool que testa se dois polin´omios s˜ao
equivalentes

equiv :: Polinomio -> Polinomio -> Bool
equiv p1 p2 = ordena (normaliza p1) == ordena (normaliza p2)