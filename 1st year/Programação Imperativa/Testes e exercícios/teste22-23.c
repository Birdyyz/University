#include <stdio.h>
typedef struct LInt_nodo {
int valor;
struct LInt_nodo *prox;
} *LInt;
/*
dado um array de tamanho N > 0 e um inteiro 0 < i <= N devolve o i-ésimo menor elemento do array.
Por exemplo, se i == 1 a função deve retornar o menor elemento do array
*/
int ordenar(int a[], int N){
    for(int i = 0; i < N ; i++){
        for(int j = i+1; j < N-1 ; j++){
            if(a[i]>a[j]){
                int temp = a[i];
                a[i] = a[j];
                a[j] = temp;
            }
        }
    }
}
 int nesimo(int a[], int N, int i){
    ordenar(a,N);
    return a[i];
 }

 /*
remove de uma lista ordenada l todos os elementos maiores que x, devolvendo a lista resultante.
Considere a definição usual do tipo LInt
*/
LInt removeMaiores(LInt l, int x) {
    if (l == NULL){
         return NULL;
    }
    if (l->valor > x) {
        while (l != NULL) {
            LInt temp = l;
            l = l->prox;
            free(temp);
        }
        return NULL;
    }

    LInt atual = l;
    while (atual->prox != NULL && atual->prox->valor <= x) {
        atual = atual->prox;
    }

    LInt temp = atual->prox;
    atual->prox = NULL;
    while (temp != NULL) {
        LInt next = temp->prox;
        free(temp);
        temp = next;
    }

    return l;
}
typedef struct ABin_nodo {
int valor;
struct ABin_nodo *esq, *dir;
} *ABin;
/*
dada uma árvore binária de procura a e um valor x, devolve uma lista com todos os valores desde a raiz até x
(inclusivé). Se x não existir na árvore, deve devolver NULL. 
*/
LInt caminho(ABin a, int x){
    if(a == NULL){
        return NULL;
    }
    if(a->valor == x){
        LInt l = malloc(sizeof(struct LInt_nodo));
        l -> valor = a ->valor;
        l -> prox = NULL;
        return l;
    }
    if(a -> valor < x){
        LInt dir = caminho(a->dir,x);
        if (dir != NULL){
            LInt l = malloc(sizeof(struct LInt_nodo));
            l -> valor = a -> valor;
            l -> prox = dir;
            return l;
        }
    }
    if(a->valor > x){
        LInt esq = caminho(a->esq,x);
        if(esq!=NULL){
            LInt l = malloc(sizeof(struct LInt_nodo));
            l -> valor = a->valor;
            l -> prox = esq;
            return l;
        }
    }
    return NULL;
}
/*
dada uma uma string s com um número em decimal, incrementa esse número numa unidade. Assuma que a string tem
espaço suficiente para armazenar o número resultante. Por exemplo, se a string for
"123" deverá ser modificada para "124". Se for "199" deverá ser modificada para
"200".
*/
#include <string.h>
#include <stdio.h>

void inc(char s[]) {
    int tamanho = strlen(s);
    int carry = 1;  

    for (int i = tamanho - 1; i >= 0 && carry > 0; i--) {
        int digito = s[i] - '0';
        digito += carry;
        carry = digito / 10; 
        s[i] = (digito % 10) + '0';  
    }

    if (carry > 0) {
        for (int i = tamanho; i >= 0; i--) {
            s[i + 1] = s[i];
        }
        s[0] = '1';  
    }
}

/*
dado um array com os pesos de N produtos que se pretende comprar num supermercado, e a capacidade
C dos sacos desse supermercado, determine o número mínimo de sacos necessários
para transportar todos os produtos. Por exemplo, se os pesos dos produtos forem
{3,6,2,1,5,7,2,4,1} e C == 10, então bastam 4 sacos. Se os pesos forem
{3,3,3,3,5,5,11} e C == 11, então bastam 3 sacos. Em geral, para descobrir este
mínimo teria que testar todas as possíveis maneiras de ensacar os produtos. Se não
conseguir implementar essa estratégia óptima, implemente outra que devolva uma
aproximação razoável.
*/
int sacos(int p[], int N, int C){
    int numeroSacos = 0;
    int capacidadeAtual = C;
    for(int i = 0; i < N ; i++){
        if(capacidadeAtual < p[i]){
            numeroSacos++;
            capacidadeAtual = C - p[i];
        }else{
            capacidadeAtual = capacidadeAtual - p[i];
        }
    }
    if (capacidadeAtual != C) {
        numeroSacos++;
    }
    return numeroSacos;
}