def viagem(rotas, o, d):
    grafo = {}
    if d == o:
        return 0
    for lista in rotas:
        for i in range(0, len(lista) - 2, 2):
            cidade = lista[i]
            custo = lista[i + 1]
            destino = lista[i + 2]
            
            if cidade not in grafo:
                grafo[cidade] = {}
            if destino not in grafo:
                grafo[destino] = {}
            
            grafo[cidade][destino] = custo
            grafo[destino][cidade] = custo
    
    if o not in grafo or d not in grafo:
        return float("inf")

    dist = {cidade: float("inf") for cidade in grafo}
    dist[o] = 0

    orla = set(grafo.keys())

    while orla:
        localatual = min(orla, key=lambda cidade: dist[cidade])
        orla.remove(localatual)

        if localatual == d:
            print(dist[localatual])
            return dist[localatual]

        for vizinho, custo in grafo[localatual].items():
            if vizinho in orla:
                novo_custo = dist[localatual] + custo
                if novo_custo < dist[vizinho]:
                    dist[vizinho] = novo_custo

rotas = [["Porto",20,"Lisboa"],
                     ["Braga",3,"Barcelos",4,"Viana",3,"Caminha"],
                     ["Braga",3,"Famalicao",3,"Porto"],
                     ["Viana",4,"Povoa",3,"Porto"],
                     ["Lisboa",10,"Evora",8,"Beja",8,"Faro"]]
viagem(rotas,"Caminha","Lisboa")