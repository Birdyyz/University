'''

Implemente um função que calcula a menor string que contém todas as palavras 
recebidas na lista de input. Assuma que todas as palavras são disjuntas entre si, 
ou seja, nunca haverá inputs onde uma das palavras está contida noutra.

'''
def valida(strings, candidata):
    for palavra in strings:
        if palavra not in candidata:
            return False
    return True
def permutacoes(strings, inicio, resultado):
    if inicio == len(strings):
        resultado.append(strings[:]) 
        return
    for i in range(inicio, len(strings)):
        strings[inicio], strings[i] = strings[i], strings[inicio]
        permutacoes(strings, inicio + 1, resultado)

def sobreposicao(a, b):
    max= 0
    for i in range(1, min(len(a), len(b)) + 1):
        if a[-i:] == b[:i]:
            max = i
    return max

def juntasobreposicao(perm):
    resultado = perm[0]
    for i in range(1, len(perm)):
        sobre = sobreposicao(resultado, perm[i])
        resultado += perm[i][sobre:]
    return resultado

def superstring(strings):
    todas_perms = []
    permutacoes(strings, 0, todas_perms)

    menor = None
    for perm in todas_perms:
        candidata = juntasobreposicao(perm)
        if menor is None or len(candidata) < len(menor):
            menor = candidata
    return menor
