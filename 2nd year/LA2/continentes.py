def maior(vizinhos):
    grafo = {}
    for i in vizinhos:  #percorrer as listas (fronteiras)
        for x in i:  #percorrer os paises dentro das listas(fronteiras)
            if x not in grafo:
                grafo[x] = []
        # juntar os vizinhos
        for y in range(len(i)):
            for z in range(y + 1, len(i)): 
                if i[z] not in grafo[i[y]]:
                    grafo[i[y]].append(i[z])
                if i[y] not in grafo[i[z]]:
                    grafo[i[z]].append(i[y])

    #Travessia em profundidade adaptada
    def dfs(adj, o, vis):
        vis.append(o) 
        tamanho = 1  
        for d in adj[o]:
            if d not in vis:  
                tamanho += dfs(adj, d, vis)  
        return tamanho

    vis = []  
    resultado = 0  

    for p in grafo:
        if p not in vis:
            tamanho_continente = dfs(grafo, p, vis)
            resultado = max(resultado, tamanho_continente)  

    print(resultado)  
    return resultado  

vizinhos = [["Portugal","Espanha"],["Espanha","França"],["França","Bélgica","Alemanha","Luxemburgo"],["Canada","Estados Unidos"]]
maior(vizinhos)