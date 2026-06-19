[a]------guarda []
    -----não vazia (h :t) h--- cabeça -1 elemento
                                       :: a (é do tipo)
                        t-----cauda - 1,2,3---infinto
                                    :: [a]
vazia :: [a] -> Bool
vazia [x] = False
vazia [x,y] = False
vazia [x,y,z] = False

vazia [] = True
vazia l = False
l ou (h:t)
(vazia l = 
nao sabemos os elementos (nem quantiidade nem quais, pode ser vazia como pode ter 4 elementos por ex) desta lista)

atencao entre colocar parenteses retos e nao os por
com []estamos a ver o que tem dentro
sem parentes nao conseguimos ver
a ordem que colocamos importa

