'''

O número de Erdos é uma homenagem ao matemático húngaro Paul Erdos,
que durante a sua vida escreveu cerca de 1500 artigos, grande parte deles em 
pareceria com outros autores. O número de Erdos de Paul Erdos é 0. 
Para qualquer outro autor, o seu número de Erdos é igual ao menor 
número de Erdos de todos os seus co-autores mais 1. Dado um dicionário que
associa artigos aos respectivos autores, implemente uma função que
calcula uma lista com os autores com número de Erdos menores que um determinado 
valor. 

A lista de resultado deve ser ordenada pelo número de Erdos, e, para
autores com o mesmo número, lexicograficamente.


Os coautores diretos de Erdős têm número 1.
Ou seja, qualquer autor que escreveu um artigo com Erdős recebe número 1.
Os coautores dos coautores de Erdős têm número 2.
Se um autor escreveu um artigo com alguém que tem número 1, ele recebe número 2.
'''

def erdos(artigos, n):
    dic = {}
    for listaaut in artigos.values():
        listaaut = list(listaaut)  # Converte o conjunto para lista

        for autores in listaaut:
            if autores not in dic:
                dic[autores] = []

        for i in range(len(listaaut)):
            for z in range(i + 1, len(listaaut)):
                if listaaut[z] not in dic[listaaut[i]]:  
                    dic[listaaut[i]].append(listaaut[z])
                if listaaut[i] not in dic[listaaut[z]]:  
                    dic[listaaut[z]].append(listaaut[i])
    print(dic)
   
artigos = {"Adaptive register allocation with a linear number of registers": {"Carole Delporte-Gallet","Hugues Fauconnier","Eli Gafni","Leslie Lamport"},
                       "Oblivious collaboration": {"Yehuda Afek","Yakov Babichenko","Uriel Feige","Eli Gafni","Nati Linial","Benny Sudakov"},
                       "Optima of dual integer linear programs": {"Ron Aharoni","Paul Erdos","Nati Linial"}
                      }
erdos(artigos,2)