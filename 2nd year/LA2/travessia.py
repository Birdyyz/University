'''
Implemente uma função que calcula o menor custo de atravessar uma região de
Norte para Sul. O mapa da região é rectangular, dado por uma lista de strings,
onde cada digito representa a altura de cada ponto. Só é possível efectuar 
movimentos na horizontal ou na vertical, e só é possível passar de um ponto
para outro se a diferença de alturas for inferior ou igual a 2, sendo o custo 
desse movimento 1 mais a diferença de alturas. O ponto de partida (na linha
mais a Norte) e o ponto de chegada (na linha mais a Sul) não estão fixados à
partida, devendo a função devolver a coordenada horizontal do melhor
ponto para iniciar a travessia e o respectivo custo. No caso de haver dois pontos
com igual custo, deve devolver a coordenada mais a Oeste.
'''

def travessia(mapa):
    from heapq import heappop, heappush  # Usamos heap para otimizar Dijkstra

    movimentos = [(0, 1), (-1, 0), (0, -1), (1, 0)]  # Direções: direita, cima, esquerda, baixo

    # Calcula o custo de movimentação entre dois pontos
    def custo(cor1, cor2):
        r = abs(int(cor1) - int(cor2))
        return r + 1 if r <= 2 else float("inf")  # float("inf") representa movimento impossível

    linhas = len(mapa)
    colunas = len(mapa[0])
    adj = {}

    # Construção do grafo de adjacências
    for i in range(linhas):
        for j in range(colunas):
            adj[(i, j)] = {}

            for mov1, mov2 in movimentos:
                m1, m2 = i + mov1, j + mov2
                if 0 <= m1 < linhas and 0 <= m2 < colunas:  # Garante que está dentro dos limites do mapa
                    c = custo(mapa[i][j], mapa[m1][m2])
                    if c > 0:  # Se for possível se mover
                        adj[(i, j)][(m1, m2)] = c

    # Aplica Dijkstra a partir de todos os pontos da primeira linha
    menor_custo = float("inf")
    melhor_inicio = None

    for j in range(colunas):  # Testa todos os pontos da primeira linha como partida
        dist = dijkstra(adj, (0, j))

        for k in range(colunas):  # Percorre a última linha para ver o melhor destino
            destino = (linhas - 1, k)
            if destino in dist and dist[destino] < menor_custo:
                menor_custo = dist[destino]
                melhor_inicio = j
            elif destino in dist and dist[destino] == menor_custo and j < melhor_inicio:
                melhor_inicio = j

    return melhor_inicio, menor_custo


# Implementação do algoritmo de Dijkstra
def dijkstra(adj, origem):
    from heapq import heappop, heappush  # Usamos heap para eficiência

    dist = {v: float("inf") for v in adj}
    dist[origem] = 0
    heap = [(0, origem)]

    while heap:
        custo_atual, v = heappop(heap)

        if custo_atual > dist[v]:
            continue

        for vizinho in adj[v]:
            novo_custo = custo_atual + adj[v][vizinho]
            if novo_custo < dist[vizinho]:
                dist[vizinho] = novo_custo
                heappush(heap, (novo_custo, vizinho))

    return dist

mapa =  ["90999",
                    "00000",
                    "92909",
                    "94909"]
travessia(mapa)