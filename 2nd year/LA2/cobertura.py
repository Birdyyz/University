'''
Implemente uma função que calcula o número mínimo de nós de um grafo 
não orientado que cobrem todas as arestas, ou seja, o tamanho do menor 
conjunto de nós que contém pelo menos um extremo de cada aresta. 
A função recebe a lista de todas as arestas do grafo, sendo cada aresta um 
par de nós.
'''
from itertools import combinations
def lista(arestas):
    nos = set()
    for a,b in arestas:
        nos.add(a)
        nos.add(b)
    return nos 
def verifica(comb,arestas):
    for a,b in arestas:
        if not(a in comb or b in comb):
            return False
    return True

def cobertura(arestas):
    nos=lista(arestas)
    for s in range(1, len(nos)+1):
        for comb in combinations(nos,s):
            if verifica(comb,arestas):
                return s


arestas = [('a','b'),('b','c'),('c','d'),('d','e'),('e','f'),('f','g'),('g','h')]
print(cobertura(arestas))