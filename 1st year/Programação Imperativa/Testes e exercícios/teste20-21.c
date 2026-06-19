#include <stdio.h>
typedef struct lligada {
int valor;
struct lligada *prox;
} *LInt;

int sumhtpo_100parcela(int n) {
    int parcelas[8000000000];  
    int count = 0;
    
    while (n != 1) {
        parcelas[count++] = n;
        if (n % 2 == 0) n = n / 2;
        else n = 1 + 3 * n;
    }
    
    if (count < 100)
        return -1;
    
    sort(parcelas, count); 
    
    return parcelas[99];   
}

int procura (LInt *l, int x){
    LInt anterior = NULL;
    LInt atual = *l;
    while(atual != NULL){
        if(atual -> valor == x){
            if(anterior == NULL){
                return 1;
            }
            anterior -> prox = atual -> prox;
            atual -> prox = *l;
            *l = atual;
            return 1;
        }
        anterior = atual;
        atual = atual -> prox;
    }
    return 0;
}

typedef struct nodo {
int valor;
struct nodo *pai, *esq, *dir;
} *ABin;

int freeAB(ABin a){
    int count = 0;
    if(a == NULL){
        return 0;
    }
    int nesq = freeAB(a->esq);
    int ndir = freeAB(a->dir);
    free(a);
    return 1 + nesq + ndir;
}

void caminho(ABin a) {
    if (a == NULL) return;

    char *direcoes[40000];
    int tamanho = 0;

    ABin atual = a;

    while (atual->pai != NULL) {
        if (atual->pai->esq == atual)
            direcoes[tamanho++] = "esq";
        else if (atual->pai->dir == atual)
            direcoes[tamanho++] = "dir";
        atual = atual->pai;
    }

    for (int i = tamanho - 1; i >= 0; i--) {
        printf("%s\n", direcoes[i]);
    }
}