#include <stdio.h>
#include <stdlib.h>
#include "tipos.h"

void libertaLista (Palavras l){
    Palavras temp;
    while (l!=NULL){
        temp = l;
        l = l-> prox;
        free(temp->palavra);
        free(temp);
    }
}

int quantasP (Palavras l){
    int count = 0;
    while (l != NULL){
        count++;
        l = l-> prox;
    }
    return count;
}

void listaPal (Palavras l){
    while ( l != NULL){
        printf("Palavra: %s (ocorrências: %d)\n", l->palavra, l->ocorr);
        l = l->prox;
    }
}
char *ultima(Palavras l) {
    if (l == NULL) return NULL;  

    while (l->prox != NULL) {
        l = l->prox;
    }
    return l->palavra;
}

Palavras acrescentaInicio (Palavras l, char *p){
    Palavras nova = malloc(sizeof(struct celula));
    nova->palavra = p;
    nova->ocorr = 1;
    nova->prox = l;
    return nova;
}
Palavras acrescentaFim (Palavras l, char *p){
    Palavras nova = malloc(sizeof(struct celula));
    nova-> palavra = p;
    nova->ocorr = 1;
    nova->prox = NULL;
        if (l == NULL){
        return nova;
    }
    Palavras atual = l;
    while(atual->prox != NULL){
        atual = atual ->prox;
    }
    atual->prox = nova;
    return l;
}
Palavras acrescenta(Palavras l, char *p) {
    Palavras atual = l;
    Palavras anterior = NULL;
    
    while (atual != NULL && strcmp(atual->palavra, p) < 0) {
        anterior = atual;
        atual = atual->prox;
    }

    if (atual != NULL && strcmp(atual->palavra, p) == 0) {
        atual->ocorr++;
        return l;
    }

    Palavras nova = malloc(sizeof(struct celula));
    nova->palavra = p;
    nova->ocorr = 1;

    if (anterior == NULL) {
        nova->prox = l;
        return nova;
    }
    nova->prox = atual;
    anterior->prox = nova;
    
    return l;
}

struct celula *maisFreq(Palavras l) {
    if (l == NULL) return NULL;

    Palavras maisFrequente = l;

    while (l != NULL) {
        if (l->ocorr > maisFrequente->ocorr) {
            maisFrequente = l;
        }
        l = l->prox;
    }

    return maisFrequente;
}
