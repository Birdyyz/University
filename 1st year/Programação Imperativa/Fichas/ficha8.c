#include <stdio.h>

typedef struct slist {
    int valor;
    struct slist * prox;
    } * LInt;
LInt newLInt (int x, LInt xs) {
    LInt r = malloc (sizeof(struct slist));
    if (r!=NULL) {
    r->valor = x; r->prox = xs;
    }
    return r;
}
typedef LInt Stack;

void initStack (Stack *s){
    *s = NULL;
}
int SisEmpty (Stack s){
    return s == NULL;
}
int top (Stack s, int *x){
    if(SisEmpty(s)){
        return 1;
    }
    *x = (*s)->valor;
    return 0;
}
int push (Stack *s, int x){
    LInt aux = malloc(sizeof(struct slist));
    if(aux == NULL){
        return 1;
    }
    aux -> valor = x;
    aux -> prox = *s;
    *s = aux;
    return 0;
}
int pop (Stack *s, int *x){
    if(SisEmpty(*s)){
        return 1;
    }
    *x = (*s) -> valor;
    *s = (*s) -> prox;
    return 0;
}

typedef struct {
    LInt inicio,fim;
    } Queue;

void initQueue (Queue *q){
    q -> fim = NULL;
    q -> inicio = NULL;
}

int QisEmpty (Queue q){
    return q.inicio == NULL;
}

int enqueue(Queue *q, int x) {
    LInt aux = malloc(sizeof(struct slist));
    if (aux == NULL) {
        return 1; 
    }
    aux->valor = x;
    aux->prox = NULL;
    if (q->fim == NULL) {  
        q->inicio = aux;  
    } else {
        q->fim->prox = aux; 
    }
    q->fim = aux; 
    return 0;  
}
int dequeue (Queue *q, int *x){
    if(QisEmpty(*q)){
        return 1;
    }
    *x = q -> inicio -> valor;
    q -> inicio = q -> inicio -> prox;
    return 0;
}

int frontQ (Queue q, int *x){
    if(QisEmpty(q)){
        return 1;
    }
    *x = q.inicio -> valor;
    return 0;
}
