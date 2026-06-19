'''

Os sacos de um supermercado tem um limite de peso que conseguem levar. 
Implemente uma função que o ajude a determinar o número mínimo de sacos que 
necessita para levar todas as compras. A função recebe o peso máximo que os
sacos conseguem levar e uma lista com os pesos de todos os items que pretende 
comprar. Deverá devolver o número mínimo de sacos que necessita para levar 
todas as compras.

'''
#se houver um item q é mais pesado q a capacidade do saco ja nao da
def valida(peso,compras):
    return all(itempeso <= peso for itempeso in compras)

def pesquisa_exaustiva(peso, compras, i, sacos):
    if i == len(compras):
        if valida(peso, sacos):
            return len(sacos)
        return float('inf') 

    minsacos= float('inf')
    
    for j in range(len(sacos)):
        sacos[j] += compras[i]
        minsacos = min(minsacos, pesquisa_exaustiva(peso, compras, i + 1, sacos))
        sacos[j] -= compras[i] 

    sacos.append(compras[i])
    minsacos = min(minsacos, pesquisa_exaustiva(peso, compras,i + 1, sacos))
    sacos.pop()  

    return minsacos

def sacos(peso, compras):
    return pesquisa_exaustiva(peso, compras, 0, [])
