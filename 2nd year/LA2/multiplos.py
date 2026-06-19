'''

Implemente uma função que determina quantas permutações dos n primeiros digitos 
são múltiplas de um dado número d. Por exemplo se n for 3 temos as seguintes 
permutações: 123, 132, 213, 231, 312, 321. Se neste caso d for 3 então todas 
as 6 permutações são múltiplas.

'''
def valida(d, digitos):
    contador = 0
    for p in permutacoes(digitos):
        numero = int(p)
        if numero % d == 0:
            contador += 1
    return contador

def permutacoes(string, inicio=0):
    resultados = []

    if inicio == len(string) - 1:
        resultados.append(''.join(string))
        return resultados

    for i in range(inicio, len(string)):
        string[inicio], string[i] = string[i], string[inicio]
        resultados += permutacoes(string, inicio + 1)
        string[inicio], string[i] = string[i], string[inicio]

    return resultados

def multiplos(n,d):
    digitos = [str(i) for i in range(1, n + 1)]
    return valida(d,digitos)
print(multiplos(3,3)) #tem de dar 6
print(multiplos(5,12)) # tem de dar 24