'''def cruzamentos(ruas):
    tupla=[] #inicializar tupla
    r=0 #contador
    for x in ruas: #percorre as palavras da rua
    t=len(x) #tamanho da palavra
    u=x[t]       #ultima letra da palavra
    p=x[0]       #primeira letra da palavra
      if p in tupla:
         r+=1
         tupla.update(p,r) #atualizar o valor r 
         else:
        tupla.append(p,r) #colocar o valor 
print(tupla)
# primeiro verificar quantas ruas interliga
def cruzamentos(ruas):
    dic={}
    tupla=[]
    r=0
    for x in ruas: #percorre as palavras da rua
    t=len(x) #tamanho da palavra
    u=x[t-1]       #ultima letra da palavra
    p=x[0]       #primeira letra da palavra
    if p in dic: #verificar se p existe no dicionario 
        r+=1   #contador´
    else:
            dic.update({p}) # se existir nao faz nada se nao existir adiciona ao dicionario
'''

def cruzamentos(ruas):
    fim = {}
    r = 0  # contador
    
    for x in ruas:  # percorre as palavras da rua
        t = len(x)  # tamanho da palavra
        u = x[t - 1]  # última letra da palavra
        p = x[0]  # primeira letra da palavra

        if p in fim:
            fim[p] += 1  # atualizar a contagem da primeira letra
        else:
            r = 1
            fim[p] = r  # inicia a contagem da primeira letra

        if u in fim:
            if u != p:  #  para n contar duas x se a primeira e ultima forem iguais
                fim[u] += 1
        else:
            if u != p:
                r = 1
                fim[u] = r  #
    # Ordena por número crescente por numeros , empate -> ordem alfabética
    '''for f in sorted(fim, key=lambda x: (fim[x], x)):
        print((f, fim[f]), end=" ")'''
    resultado = sorted(fim.items(), key=lambda x: (x[1], x[0]))
    return resultado

#ruzamentos(["raio","central","liberdade","chaos","saovictor","saovicente","saodomingos","souto","capelistas","anjo","taxa"])
#[('t',1),('a',2),('e',2),('l',2),('r',2),('c',3),('o',3),('s',6)])
#cruzamentos(["ab","bc","bd","cd"])
'''
r=1
c=3 
l=1
s=4  
a=1
t=1  

def cruzamentos(ruas):
    fim = {}

    for x in ruas:  # percorre as palavras 
        u = x[-1]  # última letra 
        p = x[0]   # primeira letra 

        fim[p] = fim.get(p, 0) + 1  # atualiza a contagem da primeira letra
        if u != p:  # para nao contar duas vezes
            fim[u] = fim.get(u, 0) + 1  # atualiza a contagem da última letra

    # ordenar1-> numeros crescente, empate-> ordem alfabetica
    for f in sorted(fim, key=lambda x: (fim[x], x)):
        print((f, fim[f]), end=" ")

#cruzamentos(["raio","central","liberdade","chaos","saovictor","saovicente","saodomingos","souto","capelistas","anjo","taxa"])
cruzamentos(["ab","bc","bd","cd"])
'''