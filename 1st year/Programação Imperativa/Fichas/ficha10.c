#include <stdio.h>
// "Woohoo I found you, get ready to be deleted"
typedef struct nodo {
int valor;
struct nodo *esq, *dir;
} * ABin;

// casos-> n ter arvore
// ter um filho (direito)
// ser uma folha
void removeMenor(ABin *a) {
    if (*a == NULL) return;

    while ((*a)->esq != NULL) {
        a = &(*a)->esq;
    }

    ABin temp = *a;
    *a = (*a)->dir; 
    free(temp);     
}


void removeRaiz(ABin *a) {
    if (*a == NULL) return;

    ABin temp;

    if ((*a)->esq == NULL) {
        temp = *a;
        *a = (*a)->dir;
        free(temp);
    }
    else if ((*a)->dir == NULL) {
        temp = *a;
        *a = (*a)->esq;
        free(temp);
    }
    else {
        ABin *min = &(*a)->dir;
        while ((*min)->esq != NULL) {
            min = &(*min)->esq;
        }

        (*a)->valor = (*min)->valor;

        temp = *min;
        *min = (*min)->dir;  
        free(temp);
    }
}

int removeElem (ABin *a, int x){
    if(*a == NULL){
        return 1;
    }

    if ((*a)->valor > x){
        return removeElem(&(*a)->esq,x);
    }
    if((*a)->valor < x){
        return removeElem(&(*a)->dir,x);
    }
    if((*a)->valor == x){
        // é uma folha
        if((*a)->dir == NULL && (*a)-> esq == NULL){
            free(*a);
            *a = NULL;
            return 0;
        }
        if((*a)->dir == NULL){
            ABin temp = ((*a)->esq);
            free(*a);
            *a = temp;
            return 0;
        }
        else if((*a)->esq == NULL){
            ABin temp = (*a)->dir;
            free(*a);
            *a = temp;
            return 0; 
        }else{
            ABin temp = (*a)->dir;
            while(temp->esq != NULL){
                temp = temp ->esq;
            }
            (*a) -> valor = temp->valor;
            removeElem(&(*a)->dir, temp->valor);
            return 0;
        }
    }
    return 1;
}
void rodaEsquerda (ABin *a){
ABin b = (*a)->dir;
(*a)->dir = b->esq;
b->esq = (*a);
*a = b;
}
void rodaDireita (ABin *a){
ABin b = (*a)->esq;
(*a)->esq = b->dir;
b->dir = *a;
*a = b;
}

void promoveMenor (ABin *a){
    while((*a)->esq != NULL){
        rodaDireita(a);
    }
}

void promoveMaior (ABin *a){
    while((*a)->dir != NULL){
        rodaEsquerda(a);
    }
}

void removeMenorv2(ABin *a) {
     if (*a == NULL) return;
    promoveMenor(a);
    removeRaiz(a);
}

ABin removeMenorAlt (ABin *a){
    if (*a == NULL) return NULL;
    promoveMenor(a);
    ABin temp = malloc(sizeof(struct nodo));
    temp -> dir = NULL;
    temp -> esq = NULL;
    temp -> valor = (*a) -> valor;
    removeRaiz(a);
    return temp;
}

int constroiEspinhaAux(ABin *a, ABin *ult) {
    if (*a == NULL) {
        *ult = NULL;
        return 0;
    }

    int nosEsq = constroiEspinhaAux(&(*a)->esq, ult);

    if (nosEsq > 0) {
        (*ult)->dir = (*a)->dir;  
        (*a)->dir = (*a)->esq;    
        (*a)->esq = NULL;         
    }

    int nosDir = constroiEspinhaAux(&(*a)->dir, ult);

    if (nosDir == 0) {
        *ult = *a;
    }

    return 1 + nosEsq + nosDir;
}

int constroiEspinha(ABin *a) {
    ABin ult;
    return constroiEspinhaAux(a, &ult);
}

ABin equilibraEspinha(ABin *a, int n) {
    if (n == 0) return *a; 

    ABin raiz = *a;

    raiz->esq = equilibraEspinha(&raiz->dir, n / 2);

    *a = raiz->dir;

    raiz->dir = equilibraEspinha(a, n - n / 2 - 1);

    return raiz;  
}
void equilibra (ABin *a){
    int r = constroiEspinha(a);
    equilibraEspinha(a,r);
}
