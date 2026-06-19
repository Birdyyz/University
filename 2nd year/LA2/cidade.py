def tamanho(ruas):
    grafo = {}
    for rua in ruas:
        nomefirst, nomesec = rua[0], rua[-1]  
        comprimento = len(rua)  

        if nomefirst not in grafo:
            grafo[nomefirst] = {}
        if nomesec not in grafo:
            grafo[nomesec] = {}

        grafo[nomefirst][nomesec] = comprimento
        grafo[nomesec][nomefirst] = comprimento
    # Algoritmo de Dijkstra
    def dijkstra(adj,o):
        dist = {v: float("inf") for v in adj}
        dist[o] = 0
        orla = set(adj.keys())
        while orla:
            v = min(orla,key=lambda x:dist[x])
            orla.remove(v)

            for d in adj[v]:
                if d in orla:
                    if dist[v] + adj[v][d] < dist[d]:
                        dist[d] = dist[v] + adj[v][d]
        return max(dist.values())
    resultado = max(dijkstra(grafo, nome) for nome in grafo)
    print(resultado)

ruas = ["raio","central","liberdade","chaos","saovictor","saovicente","saodomingos","souto","capelistas","anjo","taxa"]
tamanho(ruas)