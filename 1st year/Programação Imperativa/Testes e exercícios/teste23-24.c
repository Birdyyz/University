#include <stdio.h>

/*
Adapte a função fizzbuzz definida abaixo por forma a devolver quantos números são
impressos entre a primeira linha do tipo FizzBuzz e a primeira linha do tipo Buzz que se
lhe segue? Se não aparecer nenhuma linha do tipo Buzz depois de uma linha do tipo
FizzBuzz deve devolver -1.


int fizz(int n) {...}
int buzz(int n) {...}
int fizzbuzz(int n) {
for (int i = 0; i < n; i++) {
if (fizz(i) && buzz(i))
printf("FizzBuzz\n");
else if (fizz(i))
printf("Fizz\n");
else if (buzz(i))
printf("Buzz\n");
else
printf("%d\n", i);
}
return 0;
}
*/

//int fizz(int n) {...}
//int buzz(int n) {...}
int fizzbuzz(int n) {
    int Fizzbuzz = 0;
    int impressos = 0;
for (int i = 0; i < n; i++) {
if (fizz(i) && buzz(i) ){
    printf("FizzBuzz\n");
    if(!Fizzbuzz){
        Fizzbuzz++;
        impressos = 0;
    }else{
        impressos++;
    }
}
else if (fizz(i)){
    printf("Fizz\n");
    if(Fizzbuzz){
        impressos++;
    }

}
else if (buzz(i)){
    printf("Buzz\n");
    if(Fizzbuzz){
        return impressos;
    }
}
else{
    printf("%d\n", i);
    if(Fizzbuzz){
        impressos++;
    }
}
}
return -1;
}
/*
por forma a rodar os elementos de um array com N inteiros r posições para a esquerda (assuma que r < N).
Por exemplo, se o array tiver o conteúdo {1,2,3,4,5,6} e se r == 2 então o array deverá
ficar com os valores {3,4,5,6,1,2}. Tente minimizar o número de escritas no array.
*/
void reverter(int a[], int inicio, int fim){
    while(inicio < fim){
        int temp = a[inicio];
        a[inicio] = a[fim];
        a[fim] = temp;
        inicio++;
        fim--;
    }
}
void rodaEsq(int a[], int N, int r){
    if(r == 0 || r == N){
        return;
    }
    reverter(a,0,r-1); // reverte as primeiras r posicoes
    reverter(a,r,N-1); // as posicoes dps de r
    reverter(a,0,N-1); // reverte tudo
}

typedef struct lint_nodo {
int valor;
struct lint_nodo *prox;
} *LInt;

/*
que apaga o n-ésimo elemento de uma lista ligada (para n == 0 a função deverá remover o primeiro
elemento). Se tal não for possível a função deverá devolver um código de erro.
Forma iterativa
*/

int delete(int n, LInt *l) {
    if (*l == NULL){ 
        return -1; 
    }
    LInt atual = *l;
    
    if (n == 0) {
        *l = atual->prox; 
        free(atual);
        return 1;
    }

    LInt anterior = NULL;
    for (int i = 0; i < n; i++) {
        anterior = atual;
        if (atual == NULL || atual->prox == NULL) {
            return -1; 
        }
        atual = atual->prox;
    }

    anterior->prox = atual->prox;
    free(atual);
    return 1;
}

/*
que calcula o comprimento da maior
sequência crescente de elementos consecutivos numa lista. Por exemplo, se a lista for [ 1,
2, 3, 2, 1, 4, 10, 12, 5, 4], a função deverá retornar 4. Serão desvalorizadas soluções que
consultem cada nodo da lista mais do que uma vez
*/

int maxCresc(LInt l){
    if(l == NULL){
        return 0;
    }
    int atual = 1;
    int max = 1;
    while (l -> prox != NULL){
        if(l->valor < l->prox -> valor){
            atual++;
        }else {
            if(atual > max){
            max = atual;
        }
            atual = 1;
        }
        l = l->prox;
    }
    if(atual > max){
        max = atual;
    }
    return max;
}

typedef struct abin_nodo {
int valor;
struct abin_nodo *esq, *dir;
} *ABin;

/*
que devolve a folha mais à esquerda de uma árvore (ou NULL se não tem nenhuma folha). Uma folha é um nodo em
que ambas as sub-árvores são vazias.
*/
ABin folhaEsq(ABin a){
    if(a == NULL){
        return a;
    }
    if(a -> esq == NULL && a -> dir == NULL){
        return a;
    }
    ABin folha = folhaEsq(a->esq);
    if (folha != NULL){
        return folha;
    }
    return folhaEsq(a -> dir);
}
int calcula(char s[]) {
    int stack[100]; 
    int top = -1;  

    for (int i = 0; s[i] != '\0'; i++) {
        char c = s[i];

        if (c >= '0' && c <= '9') {
            stack[++top] = c - '0';
        } else if (c == '+' || c == '*') {
            int b = stack[top--];
            int a = stack[top--];

            int res;
            if (c == '+'){
                res = a + b;
            }
            else {
                res = a * b;
            }
            stack[++top] = res;
        }
    }
    return stack[top];
}

/*
que, dada uma string onde está
armazenada uma expressão aritmética com vários tipos de parêntesis, testa se os
parêntesis estão corretos. Por exemplo, se a expressão for "3 + [2 - (3 - x)] + 4" a
função deve retornar verdadeiro, enquanto que para a expressão "3 + [2 - (3 - x]) +
4" deve retornar falso. Considere 3 tipos de parêntesis: '(',')','[',']', e '{','}'
*/

int parentesisOk(char exp[]){
    int stack[100];
    int top = 0;
    for(int i = 0; exp[i] != '\0'; i++){
        char c = exp[i];
        if(c == '(' ||c == '[' || c == '{'){
            stack[top++] = c;
        }
        else if(c == ')' || c == ']' || c == '}') {
            if(top == 0){
                return 0;
            }
            char aberto = stack[--top];
            if(c == '(' && aberto != ')'
            || c == '[' && aberto != ']'
            || c == '{' && aberto != '}'){
                return 0;
            }
        }
    }
    return top == 0;
}