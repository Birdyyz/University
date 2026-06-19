#include <stdio.h>

typedef struct lligada {
int valor;
struct lligada *prox;
} *LInt;

LInt reverseL (LInt l){
    if(l == NULL){ 
        return l;
    }
    LInt anterior = NULL;
    LInt atual = l;
    while(atual != NULL){
        LInt proximo = atual ->prox;
        atual -> prox = anterior;
        anterior = atual;
        atual = proximo;
    }    
    return anterior;
}

int removeOneOrd(LInt *l, int x) {
    while (*l != NULL && (*l)->valor != x) {
        l = &(*l)->prox;
    }

    if (*l == NULL) {
        return 1; 
    }

    LInt temp = *l;        
    *l = (*l)->prox;       
    free(temp);           

    return 0; 
}

int removeMaiorL (LInt *l){
    int remover = (*l) -> valor;
    LInt temp = *l;
    while(temp != NULL){
        if(temp->valor > remover){
            remover = temp->valor;
        }
        temp = temp -> prox;
    }
    while(*l != NULL && (*l)->valor != remover){
        l = &(*l)->prox;
    }
    if(*l != NULL){
        LInt apagar = *l;
        *l = (*l) -> prox;
        free(apagar);
    }
    return remover;
} 

int drop (int n, LInt *l){
    int removidos = 0;
    if(*l == NULL){
        return 0;
    }

    for(int i = 0; i < n; i++){
        if(*l !=NULL){
        LInt temp = *l;
        *l = (*l) -> prox;
        free(temp);
        removidos++;
    }else{
        return removidos;
    }}
    return removidos;
}

int listToArray (LInt l, int v[], int N){
    for(int i = 0; i< N ; i++){
        if(l!=NULL){
            v[i] = l ->valor;
            l = l-> prox;
        }
        else{
            return i;
        }
    }
    return N;
}

LInt rotateL (LInt l){
    if(l == NULL || l->prox == NULL){
        return l;
    }
    LInt primeiro = l;
    LInt penultimo = NULL;
    while(l -> prox!=NULL){
        penultimo = l;
        l = l-> prox;
    }
    l -> prox = primeiro;
    penultimo -> prox = NULL;
    l = primeiro -> prox;
    primeiro -> prox = NULL;
    return l;
}

LInt rotatefiminicio(LInt l){
    if(l == NULL || l->prox == NULL){
        return l;
    }
    LInt primeiro = l;
    LInt penultimo = NULL;
    LInt ultimo = l;
    while(l!=NULL){
        ultimo = l;
        l = l->prox;
    }
    if(penultimo == primeiro){
        ultimo -> prox = primeiro;
        primeiro -> prox = NULL;
        return ultimo;
    }
    penultimo -> prox = primeiro;
    ultimo -> prox = primeiro -> prox;
    primeiro -> prox = NULL;
    return ultimo;
}

typedef struct nodo {
int valor;
struct nodo *esq, *dir;
} *ABin;

int altura (ABin a){
    if(a == NULL){
        return 0;
    }
    int altesq = altura(a->esq);
    int altdir = altura(a->dir);
    if(altesq > altdir){
        return 1+altesq;
    }else{
        return 1+altdir;
    }
    return 1;
}

int iguaisAB (ABin a, ABin b){
    if (a == NULL || b == NULL)
    return (a == b);

    return (a->valor == b->valor &&
            iguaisAB(a->esq, b->esq) &&
            iguaisAB(a->dir, b->dir));
}

int contaFolhas (ABin a) {
    if(a == NULL){
        return 0;
    }
    if(a -> dir == NULL && a -> esq == NULL){
        return 1;
    }
    int folhasdir = contaFolhas(a->dir);
    int folhasesq = contaFolhas(a->esq);
    return folhasdir+folhasesq;
}
// so funciona se estiver ordenado :)
int removeDups (LInt *l){
    if(*l == NULL){
        return 0;
    }
    int count = 0;
    LInt atual = *l;
    while(atual-> prox != NULL){
        if(atual -> valor == atual -> prox -> valor){
            LInt temp = atual -> prox;
            atual -> prox = temp -> prox;
            free(temp);
            count++;
        }else{
            atual = atual -> prox;
        }
    }
    return count;
}