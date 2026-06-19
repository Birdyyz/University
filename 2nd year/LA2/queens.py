from itertools import product,combinations, permutations

#def posicoes(n):
    #return list(product(range(n),range(n)))
#print(posicoes(3))

def candidatos(n):
    #return list(map(list,combinations(posicoes(n),n)))
    return list(map(list,permutations(range(n))))

def valido(n, candidatos):
    #for i in range(n):
        #for j in range(i + 1, n):
    for x0 in range(n):
        for x1 in range(x0+1,n):
            #x0, y0 = candidatos[i]
            y0= candidatos[x0]
            y1 = candidatos[x1]
            #x1, y1 = candidatos[j]
            if x0 == x1 or y0 == y1 or x0 + y0 == x1 + y1 or y0 - x0 == y1 - x1:
                return False
    return True

#print(valido(4,[(0,0),(0,2),(1,3),(3,1)]))
#print(valido(4, [(0, 1), (2, 0), (1, 3), (3, 2)]))
#print(candidatos(2))

def rainhas(n):
    for candidato in candidatos(n):
        if valido(n,candidato):
            return candidato

#print(rainhas(4))
#print(rainhas(3))
#print(rainhas(5))
print(rainhas(10))



# versao com backtracking
def ext_valido(candidato,y):
    for x0 in range(len(candidato)):
        x = len(candidato)
        y0 = candidato(x0)
        if x0 == x or y0 == y or x0 + y0 == x + y or y0 - x0 == y - x:
                return False
    return True

def extensions(n,candidato):
    return list(i for i in range(n) if i not in candidato and ext_valido(candidato,i))

def pesquisa(n,candidato):
    if len(candidato) == n:
        return (valido(n,candidato))
    for y in extensions(n,candidato):
        candidato.append(y)
        if pesquisa(n,candidato):
            return True 
        candidato.pop() # e falso ent experimentamos com outro
    return False

def rainhas(n):
    candidato = []
    if pesquisa(n,candidato):
        return candidato