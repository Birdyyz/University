
def formata(codigo):
    resultado = ""
    direita=0 #quando tiver { e suposot a partir dai tdos ter +2 espacos
    posicao=-1
    tamanhoc=len(codigo)-1
    #print(tamanhoc)
    anterior=""
    for x in codigo:
        posicao+=1
        if not (x == " " and anterior in ['{',';','}']):
            if posicao == tamanhoc: #para ver se estamos no ultimo ou nao, se for x== codigo[-1] nao e a posicao mas sim o caracter
                resultado+=x
                break
            elif x in [';', '{', '}'] and posicao!=tamanhoc:
                if x == '{':  # para { adiciona dois espaços e \n
                    #print(direita)
                    resultado += "  " * direita +x+ "\n"
                    direita+=1
                    resultado+="  "*direita
                elif x== ';':
                    resultado+=x +"\n"
                elif x=='}': # Para ; e } adiciona apenas uma nova linha\n
                    direita-=1 
                    #print("estou no elif x in")
                    resultado+= "  " * direita + x +"\n"
            #elif x == codigo[-1]:  # Se for o último , não adiciona \n
            else:
                if anterior==";":
                    resultado+="  "*direita+x
                #print("estou no else")
                else:
                    resultado +=x 
            anterior=x
    #print(posicao)
    print(resultado)    

# Exemplo de uso:
codigo = "int main() {int x;x=0;     x=x+1;}"
#codigo = "int x;x=0;x=x+1;"
formata(codigo)  # Chama a função para ver a saída
