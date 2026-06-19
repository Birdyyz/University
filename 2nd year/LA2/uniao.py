'''

Implemente uma função que dada uma lista de conjuntos de inteiros determine qual
o menor número desses conjuntos cuja união é idêntica à união de todos os 
conjuntos recebidos.

'''
def gerar_combinacoes(sets, k):
    resultado = []

    def backtrack(inicio, atual):
        if len(atual) == k:
            resultado.append(atual[:])
            return
        for i in range(inicio, len(sets)):
            atual.append(sets[i])
            backtrack(i + 1, atual)
            atual.pop()

    backtrack(0, [])
    return resultado

def uniao(sets):
    uniao = set()
    for a in sets:
        for b in a:
            if b not in uniao:
                uniao.add(b)
    
    for k in range(1, len(sets) + 1):
        combinacoes = gerar_combinacoes(sets, k)
        for comb in combinacoes:
            uniao_atual = set()
            for s in comb:
                uniao_atual.update(s)  
            if uniao_atual == uniao:
                return k  
    return len(sets)  

uniao([{1,2,3},{2,4},{3,4},{4,5}])