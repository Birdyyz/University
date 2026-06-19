data Frac = F Integer Integer

1.

--que dada uma fraccao calcula uma fraccao equivalente, irredutıvel, e com o denominador positivo
-- ex : normaliza (F (-33) (-51)) deve retornar F 11 17 e normaliza (F 50 (-5)) deve retornar F (-10) 1.
Sugere-se que comece por definir primeiro a funcao
mdc :: Integer -> Integer -> Integer que calcula o maximo divisor comum
entre dois numeros, baseada na seguinte propriedade (atribuida a Euclides):
mdc x y == mdc (x+y) y == mdc x (y+x)


mdc :: Integer -> Integer -> Integer
mdc x y = | x > y = mdc (x - y)
          | x < y = mdc (y - x)
          otherwise x 


normaliza :: Frac -> Frac
normaliza ( F x y) ( F w z) = F ( x 'div' mdc) ( y 'div' mdc)

                where 'div' = mdc x y 


b)
--Defina Frac como instancia da classe Eq

instance Eq Frac where 
    (==) Frac -> Frac -> Bool 
    (==) (F x y) (F w z) = x * y == w * z 



c) 
--Defina Frac como instancia da classe Ord

instance Ord Frac where 
compare ( F x y) ( F w z) = | x * y > w * z = GT 
                          | x * y < w * z = LT 
                          | x * y == w * z = Eq 


d) 
--Defina Frac como instancia da classe Show, de forma a que cada fracao seja apresentada por (numerador/denominador).

instance Show Frac where 
    show ( F x y) = show x ++ "/" ++ show y

e) 
--Defina Frac como instancia da classe Num. Relembre que a classe Num tem a seguinte definicao
class (Eq a, Show a) => Num a where
(+), (*), (-) :: a -> a -> a
negate, abs, signum :: a -> a
fromInteger :: Integer -> a

instance Num Frac where 
    (+) (F x y) ( F w z) = F ((x*z) + (w*y)) (y *z)

    (-) (F x y) ( F w z) =  F ((x*z) - (w*y)) (y *z)
    (*) ( F x y) ( F w z) = F ((x*z) (w*y)) 

negate :: a -> a 
negate ( F x y) = if x < 0 
                then (F x y) 
                else (F -x y)
abs :: a -> a 
abs ( F x y) = F (abs x) ( abs y)

signum :: a -> a 
signum ( F x y) = | x < 0 = F ( -1 y)
                  | x > 0 = F ( 1 y)
                  | x == 0 = 0

fromInteger :: Integer -> a

fromInteger x = F x 1 

f) 
--Defina uma funcao que, dada uma fracao f e uma lista de fracoes l, selecciona de l os elementos que sao maiores do que o dobro de f.
-- vai a lista (l) e pega os elementos que sao >*2 dos elem de f
maiorDobro :: Frac -> [Frac] -> [Frac]
maiorDobro f l = filter ( >*2 'elem' f) l


2.
data Exp a = Const a
| Simetrico (Exp a)
| Mais (Exp a) (Exp a)
| Menos (Exp a) (Exp a)
| Mult (Exp a) (Exp a)

calcula :: Num a => Exp a -> a
calcula (Const x) = x
calcula (Simetrico x) = - calcula x
calcula (Mais x y) = calcula x + calcula y
calcula (Menos x y) = calcula x - calcula y
calcula (Mult x y) = calcula x * calcula y


infixa :: Show a => Exp a -> String
infixa (Const x) = show x
infixa (Simetrico x) = '-' : '(' :  infixa x ++ ")"
infixa (Mais x y) = '(' : infixa x ++ " + " ++ infixa y ++ ")"
infixa (Menos x y) = '(' : infixa x ++ " - " ++ infixa y ++ ")"
infixa (Mult x y) = '(' : infixa x ++ " * " ++ infixa y ++ ")"

a) 
--Declare Exp a como uma instância de Show.

instance Show a=>Show (Exp a) where
    show e = infixa e

b) 
--Declare Exp a como uma instância de Eq.

instance (Eq a,Num a)=>Eq (Exp a) where

    (==) e1 e2 = calcula e1 == calcula e2

c) 
--Declare Exp a como instância da classe Num.

instance Num a=>Num (Exp a) where

    (+) e1 e2 = Const (calcula e1 + calcula e2)
    (-) e1 e2 = Const (calcula e1 - calcula e2)
    (*) e1 e2 = Const (calcula e1 * calcula e2)
    abs e = Const (abs (calcula e))
    negate e = Const (negate (calcula e))
    signum e = Const (signum (calcula e))
    fromInteger n = Const (fromInteger n)


3.
data Movimento = Credito Float | Debito Float
data Data = D Int Int Int
-- data = D d m a -> dia mes ano
-- ex : 2010/4/5 
data Extracto = Ext Float [(Data, String, Movimento)]

a) 
--Defina Data como instancia da classe Ord.
instance Ord Data where

compare ( D d1 m1 a1 ) (D d2 m2 a2) = | (a1 m1 d1) > (a2 m2 d2) = GT
                                      | (a1 m1 d1) < (a2 m2 d2) = LT 
                                      | (a1 m1 d1) = (a2 m2 d2) = Eq


b)
--Defina Data como instancia da classe Show

instance Show Data where 
show ( D d m a) = show a ++ "/" ++ show m ++ "/" ++ show d 


c) 
--  que transforma um extracto de modo a que a lista de movimentos apare¸ca ordenada por ordem crescente de data.
-- data Extracto = Ext Float [(Data, String, Movimento)] 

ordena :: Extracto -> Extracto
orderna ( Ext n l) = Ext n ( compare Data1 Data2) l






data Data = D Int Int Int
Defina Data como instancia da classe Ord.
instance Ord Data where 
 
    compare (D1 a b c) (D2 x y z) = (a b c) > (x y z) = GT
                                    (a b c) > (x y z) = LT
                                     (a b c) > (x y z) = EQ


