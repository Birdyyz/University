def tabela(jogos):
    a={}
    for equipa1, golos1, equipa2,golos2 in jogos:
        if equipa1 not in a:
            a[equipa1] = {'pontos': 0, 'golos': 0, 'golossf': 0}
        if equipa2 not in a:
            a[equipa2] = {'pontos': 0, 'golos': 0, 'golossf': 0}
        a[equipa1]['golos'] += golos1
        a[equipa1]['golossf'] += golos2
        a[equipa2]['golos'] += golos2
        a[equipa2]['golossf'] += golos1
        if golos1>golos2: #se a equipa1 ganhou
            a[equipa1]['pontos']+=3
        elif golos1<golos2:#se a equipa2 ganhou
            a[equipa2]['pontos']+=3
        else:#se empataram
            a[equipa1]['pontos']+=1
            a[equipa2]['pontos']+=1

    #print(a)
    b = sorted(a.items(), key=lambda item: (-item[1]['pontos'],  # por pontuacao
        -(item[1]['golos'] - item[1]['golossf']),  # por diferenca de golos
    ))
    #print(b)
    resultado = [(equipa, dados['pontos']) for equipa, dados in b]

    '''
    for a,ag,b,bg in resultado:
        if (ag==bg):
            resultado.remove(ag)
            resultado.remove(bg)
    
    for chave, item in b[1:]:
        if item[1]['pontos'] == itemant[1]['pontos']:
            resultado.append((chave, item[1]['pontos']))
        '''

    print(resultado)
    return resultado


tabela([("Benfica",3,"Porto",2),("Benfica",0,"Sporting",0),("Porto",2,"Benfica",1),("Sporting",2,"Porto",2)])
#vitoria-> +3 pontos empate->+1
#[('Porto', 4), ('Benfica', 4), ('Sporting', 2)]