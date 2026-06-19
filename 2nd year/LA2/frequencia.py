def frequencia(texto):
    lista=[]
    texto=texto.split()
    a={}
    for x in texto: #percorrer as palavras da string
        if x in a: #se estiver no dicionario
            a[x]+=1 #somamos a contagem que esta na palavra
        else: #se nao estiver no dicionario
            a[x]=1 #adicionamos ao dicionario a palavra e a contagem
    print(a)
    lista_ordenada = sorted(a.items(), key=lambda item: (-item[1], item[0]))    
    palavras = []
    print(lista_ordenada)
    for chave, _ in lista_ordenada: 
        palavras.append(chave)

    print(palavras)
    return palavras

frequencia("o tempo perguntou ao tempo quanto tempo o tempo tem")
#frequencia("Ola")