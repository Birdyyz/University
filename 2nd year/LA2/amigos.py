'''
Implemente uma função que descubra o maior conjunto de pessoas que se conhece 
mutuamente. A função recebe receber uma sequências de pares de pessoas que se 
conhecem e deverá devolver o tamanho do maior conjunto de pessoas em que todos 
conhecem todos os outros.
'''

from itertools import combinations

def lista(conhecidos):
    pessoas = set()
    for p1, p2 in conhecidos:
        pessoas.add(p1)
        pessoas.add(p2)
    return pessoas

def aux(grupo, conhecidos):
    for p, b in combinations(grupo, 2):
        if (p, b) not in conhecidos or (b, p) not in conhecidos:
            return False
    return True

def tornar_simetrico(conhecidos):
    simetricos = set()
    for a, b in conhecidos:
        simetricos.add((a, b))
        simetricos.add((b, a))
    return simetricos

def amigos(conhecidos):
    if conhecidos == {}:
        return 0
    pessoas = lista(conhecidos)
    conhecidos = tornar_simetrico(conhecidos)

    for s in range(len(pessoas), 1, -1):
        for grupo in combinations(pessoas, s):
            #print(grupo)
            if aux(grupo, conhecidos):
                return s  
    return 1

conhecidos = {('pedro','maria'),('pedro','jose'),('pedro','manuel'),('maria','jose'),('maria','francisca'),('jose','francisca'),('francisca','manuel')}
print(amigos(conhecidos))

# com backtracking
def amigos(conhecidos):
    grafo = dict()
    for a, b in conhecidos:
        grafo.setdefault(a, set()).add(b)
        grafo.setdefault(b, set()).add(a)

    pessoas = list(grafo.keys())
    n = len(pessoas)
    melhor = [0]  

    def backtrack(grupo, index):
        melhor[0] = max(melhor[0], len(grupo))
        
        for i in range(index, n):
            pessoa = pessoas[i]
            if all(pessoa in grafo[outra] for outra in grupo):
                backtrack(grupo + [pessoa], i + 1)

    backtrack([], 0)
    return melhor[0]
