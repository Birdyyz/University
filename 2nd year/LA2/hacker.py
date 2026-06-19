"""
Um hacker teve acesso a um log de transações com cartões de
crédito. O log é uma lista de tuplos, cada um com os dados de uma transação,
nomedamente o cartão que foi usado, podendo alguns dos números estar
ocultados com um *, e o email do dono do cartão.

Pretende-se que implemente uma função que ajude o hacker a 
reconstruir os cartões de crédito, combinando os números que estão
visíveis em diferentes transações. Caso haja uma contradição nos números 
visíveis deve ser dada prioridade à transção mais recente, i.é, a que
aparece mais tarde no log.

A função deve devolver uma lista de tuplos, cada um com um cartão e um email,
dando prioridade aos cartões com mais digitos descobertos e, em caso de igualdade
neste critério, aos emails menores (em ordem lexicográfica).
"""
def hacker(log):
    transacoes = {}
    for numero, email in log:
        # Colocar o email nas transações
        if email not in transacoes:
            transacoes[email] = []
        # Colocar o cartão de crédito
        transacoes[email].append(numero)

    # Até aqui temos os emails e os respetivos números juntos agora temos de os reconstruir

    def objetivodohacker(codigos):
        tamanho = 16
        # Iniciar a lista com '*' para os q nao sabemos
        codigoqohackerquer = ['*' for _ in range(tamanho)]
        #percorrer os numeros
        for codigo in codigos:
            #print(codigo)
            for i in range(tamanho):#para ver do 1-16
                if codigo[i] != '*': #quer dizer que temos um digito
                    codigoqohackerquer[i] = codigo[i]

        return ''.join(codigoqohackerquer)

    conseguiu = []

    # percorrer os emails e os numeros
    for emaildavitima, hackerquersaber in transacoes.items():
        codigoqohackerquer = objetivodohacker(hackerquersaber)
        #para saber quantos q sabemos para prioridade
        digitos = sum(1 for c in codigoqohackerquer if c != '*')
        #juntar a lista
        conseguiu.append((codigoqohackerquer, emaildavitima, digitos))

    # Ordena primeiro pela quantidade de numeros q o hacker vai saber, depois pelo abc
    conseguiu.sort(key=lambda x: (-x[2], x[1]))
    #print(conseguiu)
    return [(codigo, email) for codigo, email, _ in conseguiu]

    #print(primeirachave)
    #print(resultado)
    #resultado=transacoes.values()
    #print(resultado)
    #print(transacoes)



log =( [("****1234********","maria@mail.pt"),("0000************","ze@gmail.com"),("****1111****3333","ze@gmail.com")])
hacker(log)
#[("00001111****3333","ze@gmail.com"),("****1234********","maria@mail.pt")]) resultado