#include <stdio.h>
typedef struct lligada {
int valor;
struct lligada *prox;
} *LInt;

typedef struct nodo {
int valor;
struct nodo *esq, *dir;
} * ABin;
// Dado um array ordenado de tamanho N calcula em que índice desse array se encontra o elemento x. Se x não existir devolve -1
int pesquisa(int z, int a[], int N){
    int r = 0;
    while ( r < N){
        if (a[r] == z){
            return r;
        }else if(z < a[r]){
                return -1;
        }
        r++;
    }
    return -1;
}
/*
de forma iterativa, que duplica todos os elementos de uma lista
se a lista tiver os valores [1,2,3] deverá ficar com os valores [1,1,2,2,3,3]
 */
void duplicaTodos(LInt l){
    while(l!=NULL){
        LInt temp = malloc(sizeof(struct lligada));
        temp -> valor = l -> valor;
        temp -> prox = l ->prox;
        l -> prox = temp;
        l = temp->prox;
    }
}
/* 
dada uma string num formato compacto onde caracter é seguido de um dígito, expande essa string repetindo cada caracter
o numero de vezes indicado pelo digito que o segue. A funcao deve devolver o tamanho da string expandida
Por ex: a string "x3y1z4 a funcao deve expandi-la para "xxxzzzz"
Assuma que a string s tem espaço suficiente para armazenar a string expandida
*/
int expande(char s[]){
    int tamanho = strlen(s);
    int tamanhoFinal = 0;
    for(int i = tamanho -2 ; i >= 0 ; i-=2){
        tamanhoFinal += s[i + 1] - '0';
    }
    int j = tamanhoFinal - 1;
    for(int i = tamanho-1; i > 0 ; i-=2){
        int repeticoes = s[i] - '0';
        char letra = s[i-1];
        while(repeticoes > 0){
            s[j--] = letra;
            repeticoes--;
        }
    }
    s[tamanhoFinal] = '\0';
    return tamanhoFinal;
}

//testa se todos os valores no nivel n de uma árvore sao iguais(retorna V se n tiver nenhum nodo)
int valorRef(ABin a, int n) {
    if (a == NULL) return -1; 

    if (n == 0) return a->valor;

    int esq = valorRef(a->esq, n - 1);
    if (esq != -1) return esq;

    return valorRef(a->dir, n - 1);
}

int verificaNivel(ABin a, int n, int ref) {
    if (a == NULL) return 1;

    if (n == 0) return (a->valor == ref);

    return verificaNivel(a->esq, n - 1, ref) &&
           verificaNivel(a->dir, n - 1, ref);
}

int todosIguais(ABin a, int n) {
    int ref = valorRef(a, n);
    if (ref == -1) return 1;
    return verificaNivel(a, n, ref);
}
// + eficiente
int iguaisNoNivel(ABin a, int n, int *ref) {
    if (a == NULL) return 1;

    if (n == 0) {
        if (*ref == -1) {
            *ref = a->valor;
            return 1;
        } else {
            return (a->valor ==*ref);
        }
    }

    return iguaisNoNivel(a->esq, n - 1,ref) &&
           iguaisNoNivel(a->dir, n - 1, ref);
}

int todosIguais(ABin a, int n) {
    int ref = -1; 
    return iguaisNoNivel(a, n, &ref);
}

/*
Uma expressão aritmétrica pode ser escrita em notação reverse polish passando os operadores para depois dos operandos.
Nesse caso também já não são necessários parênteses para controlar a prioridade das operações. Por exemplo, a expressão
"(3+4)*(2+1)" seria escrita como "34+21+*". Implemente uma função que dada uma string com uma expressão na notação
reverse polish(apenas com digitos e os operadores + e *) calcula o seu valor. Por exemplo, calcula("34+21+*") == 21
*/
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
