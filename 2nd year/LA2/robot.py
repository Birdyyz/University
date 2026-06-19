'''
Neste problema prentede-se que implemente uma função que calcula o rectângulo onde se movimenta um robot.

Inicialmente o robot encontra-se na posição (0,0) virado para cima e irá receber uma sequência de comandos numa string.
Existem quatro tipos de comandos que o robot reconhece:
  'A' - avançar na direcção para o qual está virado
  'E' - virar-se 90º para a esquerda
  'D' - virar-se 90º para a direita 
  'H' - parar e regressar à posição inicial virado para cima
  
Quando o robot recebe o comando 'H' devem ser guardadas as 4 coordenadas (minímo no eixo dos X, mínimo no eixo dos Y, máximo no eixo dos X, máximo no eixo dos Y) que definem o rectângulo 
onde se movimentou desde o início da sequência de comandos ou desde o último comando 'H'.

A função deve retornar a lista de todas os rectangulos (tuplos com 4 inteiros)
'''
def robot(comandos):
    direcoes = [(0, 1), (-1, 0), (0, -1), (1, 0)]  # subir, descer, esquerda, direita , pensar nos eixos xy
    x=0
    y=0  
    direcao=0  
    minx=0
    miny=0
    maxx=0
    maxy=0
    resultado=[]
    for c in comandos:
        if c=='A':#'A' - avançar na direcção para o qual está virado
            dx,dy=direcoes[direcao] # avança (0,1)
            #print(dx)
            x+=dx
            y+=dy
            minx=min(minx, x)
            miny=min(miny, y)
            maxx=max(maxx, x)
            maxy=max(maxy, y)
            #print(minx)
            #print(maxx)
        elif c=='E':# 'E' - virar-se 90º para a esquerda
            direcao=(direcao+ 1)%4  
        elif c == 'D':#'D' - virar-se 90º para a direita 
            direcao=(direcao- 1)%4  
        elif c=='H':#'H' - parar e regressar à posição inicial virado para cima
            resultado.append((minx, miny, maxx, maxy)) #quando é H guardamos as 4 coordenadas
            x=0
            y=0
            direcao=0 
            minx=0
            miny=0
            maxx=0
            maxy=0  
    return resultado
robot("EEAADAAAAAADAAAADDDAAAHAAAH")
