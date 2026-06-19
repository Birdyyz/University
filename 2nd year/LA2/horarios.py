"""
Implemente uma função que calcula o horário de uma turma de alunos.
A função recebe dois dicionários, o primeiro associa a cada UC o
respectivo horário (um triplo com dia da semana, hora de início e
duração) e o segundo associa a cada aluno o conjunto das UCs em
que está inscrito. A função deve devolver uma lista com os alunos que
conseguem frequentar todas as UCs em que estão inscritos, indicando
para cada um desses alunos o respecto número e o número total de horas
semanais de aulas. Esta lista deve estar ordenada por ordem decrescente
de horas e, para horas idênticas, por ordem crescente de número.
"""
def horario(ucs, alunos):
    b = {aluno: 0 for aluno in alunos}
    sobreposicoes = {}

    for chave, (dia, hinicio, duracao) in ucs.items():  # percorrer a ucs
        for aluno, cadeira in alunos.items():  # percorrer os alunos e as suas cadeiras
            if aluno not in sobreposicoes: #adicionar a lista de sobreposicoes
                sobreposicoes[aluno] = []
            for uc in cadeira:  # percorrer as ucs que o aluno esta inscrito
                if uc not in ucs:
                    if aluno in b:
                        del b[aluno]
                        break
                if uc == chave:  # 
                    if aluno in b:
                        sobreposicoes[aluno].append((hinicio,duracao))
                        b[aluno] += duracao  
    removeraluno=set()
    for aluno, aulas in sobreposicoes.items():#percorrer o q ta nas sobreposicoes
        if len(aulas)>1: #se o aluno tive aulas
            for i in range(len(aulas)-1): #percorrer ate o fim
                hinicio1,duracao1 = aulas[i]
                for j in range(i+1,len(aulas)):
                    hinicio2,duracao2 = aulas[j]
                    fim1=hinicio1+duracao1
                    fim2=hinicio2+duracao2
                    if(hinicio1<fim2) and (hinicio2<fim1):#há sobreposicao
                        if aluno in b:
                            removeraluno.add(aluno) #adicionamos ao set para remover o aluno
                            break
    for aluno in removeraluno:
        if aluno in b:
            del b[aluno]
    resultado = [(aluno, b[aluno]) for aluno in b if aluno not in removeraluno]
    #se houver empate de horas organizar pelo numero de aluno
    resultado = sorted(resultado, key=lambda x: (-x[1], x[0]))    
    print(resultado)
    print(b)


ucs = {"la2": ("quarta",16,2), "pi": ("terca",15,1), "cp": ("terca",14,2),"so": ("quinta",9,3)}
alunos = {5000: {"la2","cp"}, 2000: {"la2","cp","pi"},3000: {"cp","poo"}, 1000: {"la2","cp","so"}}
horario(ucs,alunos)

'''
falta ter em conta a duracao da aula
                        if len(sobreposicoes[aluno]) > 1:
                            for i in range(len(sobreposicoes[aluno]) - 1):
                                if abs(sobreposicoes[aluno][i] - sobreposicoes[aluno][-1]) < 2:
                                    del b[aluno] 
                                    print(f"removi {aluno}")
                                    break
'''