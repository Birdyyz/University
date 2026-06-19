'''
Implemente uma função que calcula a área de um mapa que é acessível por
um robot a partir de um determinado ponto.
O mapa é quadrado e representado por uma lista de strings, onde um '.' representa
um espaço vazio e um '*' um obstáculo.
O ponto inicial consistirá nas coordenadas horizontal e vertical, medidas a 
partir do canto superior esquerdo.
O robot só consegue movimentar-se na horizontal ou na vertical. 
'''

def area(p,mapa):
    linha, coluna = p
    posicao = mapa[linha][coluna]
    if posicao == "*": 
        return 0
    tamanho = len(mapa)
    #movimentos possiveis horizontais e vertical
    movimentos = [(-1, 0), (1, 0), (0, -1), (0, 1)] #cima, cima, esquerda, direita
    area = 1
    vis = {(linha,coluna)}
    queue = [(linha,coluna)]
    while queue:
        linha, coluna = queue.pop(0)        
        for mlinha, mcoluna in movimentos:
            #atualizar as linhas
            proxlinha = linha + mlinha
            proxcoluna = coluna + mcoluna

            if (0 <= proxlinha < tamanho and 0 <= proxcoluna < tamanho): 
                char= mapa[proxlinha][proxcoluna]
                #verificar se o robot pode ir para ela
                if char == "." and (proxlinha,proxcoluna) not in vis:
                    area+=1
                    vis.add ((proxlinha,proxcoluna))
                    queue.append((proxlinha,proxcoluna))
    #print(area)
    return area


    

mapa = ["..*..",
         ".*.*.",
        "*...*",
        ".*.*.",
        "..*.."]
area((3,2),mapa)
mapa2 = ["..*..",
        ".*.*.",
         "*....",
         ".*.*.",
         "..*.."]
area((3,2),mapa2)
