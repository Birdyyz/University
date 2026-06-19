'''
Pretende-se que implemente uma função que detecte códigos ISBN inválidos. 
Um código ISBN é constituído por 13 digitos, sendo o último um digito de controlo.
Este digito de controlo é escolhido de tal forma que a soma de todos os digitos, 
cada um multiplicado por um peso que é alternadamente 1 ou 3, seja um múltiplo de 10.
A função recebe um dicionário que associa livros a ISBNs,
e deverá devolver a lista ordenada de todos os livros com ISBNs inválidos.
            livros = {
                "Todos os nomes":"9789720047572",
                "Ensaio sobre a cegueira":"9789896604011",
                "Memorial do convento":"9789720046711",
                "Os cus de Judas":"9789722036757"
            }
            self.assertEqual(isbn(livros),["Memorial do convento","Todos os nomes"])
'''
#livros.values() devolve os numeros. livros.keys() os nomes
#temos de percorrer os numeros somar enquanto multiplicamos por 1 ou 3 alternadamente

def isbn(livros):
    resultado=[]
    resultado = list(livros.keys())
    for chave, codigo in livros.items(): #percorrer
        posicao=0
        contagem=0
        for z in codigo: #percorre os numeros um a um 
            num=int(z)
            if posicao%2==0: #se for divisivel por dois multiplica por 1
                contagem+=num
            else:#se for uma posicao impar multiplica por 3
                contagem+=num*3
            posicao+=1
        if contagem%10==0: # se for multiplo de 10 removemos da lista
            resultado.remove(chave)

        #print(contagem)
    resultado.sort()
    print(resultado)
    return resultado
livros = {
                "Todos os nomes":"9789720047572", #da 131
                "Ensaio sobre a cegueira":"9789896604011",#da 140
                "Memorial do convento":"9789720046711",
                "Os cus de Judas":"9789722036757"
            }
'''livros = {
"Ola mundo":"0000000000001"
 }
 '''
isbn(livros)