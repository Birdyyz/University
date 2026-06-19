#include <stdio.h>

typedef struct lligada {
    int valor;
    struct lligada *prox;
    } *LInt;

int length (LInt l){
    int count = 0;
    while(l != NULL){
        count++;
        l=l->prox;
    }
    return count;
}

void freeL (LInt l){
    while ( l != NULL){
        LInt temp = l-> prox;
        free(l);
        l = temp;
    }
}

void imprimeL (LInt l){
    while(l != NULL){
        printf("%d \n", l-> valor);
        l = l-> prox;
    }
}

LInt reverseL (LInt l){
    LInt ant = NULL;
    LInt atual = l;
    while (atual != NULL){
        LInt prox = atual->prox;
        atual -> prox = ant;
        ant = atual;
        atual = prox;
    }
    return ant;
}

void insertOrd(LInt *l, int a) {
    LInt novo = malloc(sizeof(struct lligada));  
    novo->valor = a;
    novo->prox = NULL;
    if (*l == NULL || (*l)->valor >= a) {
        novo->prox = *l;  
        *l = novo;        
    } else {
        LInt temp = *l;
        while (temp->prox != NULL && temp->prox->valor < a) {
            temp = temp->prox;  
        }
        novo->prox = temp->prox;  
        temp->prox = novo;        
    }
}

int removeOneOrd(LInt *l, int a) {
    if (*l == NULL) return 1;
    LInt temp = *l;
    if (temp->valor == a) {
        *l = temp->prox;
        free(temp);
        return 0;
    }
    while (temp->prox != NULL && temp->prox->valor != a) {
        temp = temp->prox;
    }
    if (temp->prox != NULL) {
        LInt proxi = temp->prox;
        temp->prox = proxi->prox;
        free(proxi);
        return 0;
    }
    return 1;
}

void merge (LInt *l, LInt a, LInt b){
    while(a !=NULL || b!=NULL){
        if (a!=NULL && b !=NULL && a->valor < b-> valor || b == NULL){  
            *l = a;
            a = a->prox;
        }
        else{
            *l = b;
            b = b->prox;
        }
        l = &((*l)->prox);
    }
    *l = NULL; // ultimo no, sempre null
}

void splitQS (LInt l, int x, LInt *mx, LInt *Mx){
    while(l != NULL){
        if(l->valor < x){
            *mx = l;
            mx = &((*mx)->prox);
        }
        else{
            *Mx = l;
            Mx = &((*Mx)->prox);
        }
        l = l->prox;
    }
    *Mx = NULL;
    *mx = NULL;
}

int calculalength(LInt l) {
    int count = 0;
    while (l != NULL) {
        count++;
        l = l->prox;
    }
    return count;
}


LInt parteAmeio (LInt *l){
    if (*l == NULL || (*l)->prox == NULL) return NULL;
    LInt ant = NULL;
    LInt agr = *l;
    int length = calculalength(*l);
    int atual = 0;
    int meio = length / 2;
    while (atual < meio && agr!=NULL){
        atual++;
        ant = agr;
        agr = agr -> prox;
    }
    ant -> prox = NULL;
    LInt res = *l;
    *l = agr;
    return res;
}

int removeAll (LInt *l, int x){
    if (*l == NULL) return 0;
    LInt ant = NULL;
    LInt atual = *l;
    int count = 0;
    while (atual != NULL){
        if (atual -> valor == x){
            if (ant == NULL){
                *l = atual -> prox;
            }
            else{
            ant->prox = atual ->prox;
        }
        count++;
        atual = atual -> prox;
    }
        else{
            ant = atual;
            atual = atual -> prox;
        }
    }
    
    return count;
}
// so funciona para 2 testes
int removeDups (LInt *l){
    int count = 0;
    LInt ant = NULL;
    LInt atual = *l;
    while(atual!=NULL){
        if(ant == NULL){
            ant = atual;
            atual = atual->prox;
        }
        else if(atual->valor == ant -> valor){
            ant -> prox = atual ->prox;
            atual = atual ->prox;
            count ++;
        }
        else{
            ant = atual;
            atual = atual ->prox;
        }
    }
    return count;
}

int removeDups(LInt *l) {
    int count = 0;
    LInt atual = *l;
    LInt ant = NULL;
    LInt seg = NULL;

    while (atual != NULL) {
        ant = atual;  
        seg = atual->prox;  

        while (seg != NULL) {
            if (seg->valor == atual->valor) {
                count++;  
                ant->prox = seg->prox;  
                seg = ant->prox;  
            } else {
                ant = seg;
                seg = seg->prox;
            }
        }

        atual = atual->prox;  
    }

    return count;
}

int removeMaiorL(LInt *l) {

    LInt atual = *l;
    LInt ant = NULL;
    LInt maior = *l;
    LInt antmaior = NULL;

    while (atual != NULL) {
        if (atual->valor > maior->valor) {
            maior = atual;
            antmaior = ant;
        }
        ant = atual;
        atual = atual->prox;
    }
    if (antmaior == NULL) {
        *l = maior->prox;
    } else {
        antmaior->prox = maior->prox;
    }
    int valorMaior = maior->valor;
    return valorMaior;
}


void init (LInt *l){
    LInt atual = *l;
    LInt ant = NULL;
    while(atual -> prox != NULL){
        ant = atual;
        atual = atual -> prox;
    }
    if(ant == NULL){
        free(atual);
        *l = NULL;
    }
    else{
        free(atual);
        ant ->prox = NULL;
    }
}

void appendL (LInt *l, int x){
    LInt add = malloc(sizeof(struct lligada));
    add -> valor = x;
    add -> prox = NULL;
    LInt atual = *l;
    if (*l == NULL){
        *l = add;
    }else{
    while(atual ->prox !=NULL){
        atual = atual -> prox;
    }
    atual -> prox = add;
}
}

void concatL (LInt *a, LInt b){
    if (*a == NULL) {
        *a = b;
    }
    else{
    LInt atual = *a;
    while (atual->prox != NULL) {
        atual = atual->prox;
    }

    atual->prox = b;
    }
}

LInt cloneL (LInt l) {
    if (l == NULL){
         return NULL; 
    }
    LInt novo = malloc(sizeof(struct lligada));
    novo->valor = l->valor;
    LInt head = novo; 
    l = l->prox;

    while (l != NULL) {
        novo->prox = malloc(sizeof(struct lligada));
        novo = novo->prox;
        novo->valor = l->valor;
        l = l->prox;
    }
    novo->prox = NULL;

    return head;
}

LInt cloneRev (LInt l) {
    LInt head = NULL;
    while (l != NULL) {
        LInt novo = malloc(sizeof(struct lligada));
        novo->valor = l->valor;
        novo->prox = head; 
        head = novo;       
        l = l->prox;
    }
    return head;
}

int maximo (LInt l){
    int max = 0;
    while (l !=NULL){
        if (l -> valor > max){
            max = l-> valor;
        }
        l = l->prox;
    }
    return max;
}

int length (LInt l){
    int count = 0;
    while(l != NULL){
        count++;
        l=l->prox;
    }
    return count;
}

int take (int n, LInt *l){
    LInt atual = *l;
    int tamanho = length(*l);
    if (tamanho <= n){
        return tamanho;
    }
    int i;
    for(i = 0; i < n; i++){
        atual = atual -> prox;
    }
    while (atual != NULL) {
        LInt temp = atual->prox;
        free(atual);
        atual = temp;
}

    return n;
}

int drop (int n, LInt *l){
    int count = 0;
    LInt atual = *l;
    if(l == NULL || n == 0){
        return 0;
    }
    while(count != n && atual != NULL){
        count++;
        LInt temp = atual;
        atual = atual -> prox;
        free(temp);
    }
    *l = atual;
    return count;
}

LInt NForward (LInt l, int N){
    int i;
    for(i = 0; i!= N; i++){
        l = l->prox;
    }
    return l;
}

int listToArray (LInt l, int v[], int N){
    int i;
    for(i = 0; i < N ; i++){
        if(l != NULL){
            v[i] = l->valor;
            l = l->prox;
        }
        else{return i;}
    }
    return i;
}

LInt arrayToList (int v[], int N){
    if(N== 0){
        return NULL;
    }
    int i;
    LInt l = malloc(sizeof(struct lligada));
    l -> valor = v[0];
    l -> prox = NULL;
    LInt head = l;

    for(i = 1; i < N; i++){
        LInt atual = malloc(sizeof(struct lligada));
        atual -> valor = v[i];
        atual -> prox = NULL; 
        l -> prox = atual;
        l = l-> prox;
    }
    return head;
}

LInt somasAcL (LInt l) {
    if (l == NULL){
        return NULL;
    }  
    int soma = 0;
    soma += l -> valor;
    LInt novo = malloc(sizeof(struct lligada));
    novo -> valor = soma;
    novo -> prox = NULL;
    l = l->prox;
    LInt head = novo;
    LInt atual = novo;
    while (l!=NULL){
        soma += l-> valor;
        LInt novo = malloc(sizeof(struct lligada));
        novo -> valor = soma;
        novo -> prox = NULL;
        atual -> prox = novo;
        atual = novo;
        l = l->prox;
    }
    return head;
}

void remreps (LInt l){
    LInt atual = l;
    while ( atual != NULL && atual -> prox != NULL){
        if(atual-> valor == atual -> prox -> valor){
            LInt temp = atual->prox;
            atual -> prox = temp -> prox;
            free(temp);
        }
        else{
            atual = atual-> prox;
        }
    }
}

LInt rotateL (LInt l){
    if(l == NULL || l -> prox == NULL){
        return l;
    }
    LInt first = l;
    LInt atual = l;
    while (atual -> prox != NULL){
        atual = atual -> prox;
    }
    atual -> prox = first;
    l = l->prox;
    first -> prox = NULL;
    return l;
}

LInt parte (LInt l) {
    if (l == NULL || l->prox == NULL){
        return NULL;
    }
    LInt nova = NULL, tail = NULL, atual = l, ant = NULL;

    int i = 0;
    while (atual != NULL) {
        if (i % 2 != 0) {
            // Remove atual da lista l
            LInt temp = atual;
            if (ant != NULL){
                ant->prox = atual->prox;
            }
            atual = atual->prox;

            // Adiciona temp à lista nova
            temp->prox = NULL;
            if (nova == NULL) {
                nova = temp;
                tail = temp;
            } else {
                tail->prox = temp;
                tail = temp;
            }
        } else {
            ant = atual;
            atual = atual->prox;
        }
        i++;
    }
    return nova;
}

typedef struct nodo {
    int valor;
    struct nodo *esq, *dir;
    } *ABin;

int altura (ABin a){
    int r = 0;
    if (a == NULL){
        return 0;
    }
    else{
        int alturaesq = altura(a->esq);
        int alturadir = altura(a->dir);
        if (alturaesq > alturadir){
            r = 1+ alturaesq;
        }
        else{
            r = 1 + alturadir;
        }
    }
    return r;
}

ABin cloneAB (ABin a){
    if(a == NULL){
        return NULL;
    }
    ABin aux = malloc(sizeof(struct nodo));
    aux -> valor = a -> valor;
    aux -> esq = cloneAB(a->esq);
    aux -> dir = cloneAB(a->dir);
    return aux;
}

void mirror (ABin *a) {
    if (*a == NULL) return; 

    ABin temp = (*a)->esq;
    (*a)->esq = (*a)->dir;
    (*a)->dir = temp;

    mirror(&((*a)->esq));
    mirror(&((*a)->dir));
}

void inorder(ABin a, LInt *l) {
    if (a == NULL) return;

    inorder(a->esq, l);

    while (*l) l = &((*l)->prox);

    *l = malloc(sizeof(struct lligada));
    (*l)->valor = a->valor;
    (*l)->prox = NULL;

    inorder(a->dir, l);
}

void preorder (ABin a, LInt * l) {
    if(a == NULL)return;

    * l = malloc (sizeof(struct lligada));
    (*l)-> valor = a -> valor;
    (*l)-> prox = NULL;
    preorder(a->esq,&((*l)->prox));

    while (*l) l = &((*l)->prox);
    preorder(a->dir,l);
}
// nao funciona
void posorder (ABin a, LInt * l) {
    if(a == NULL)return;
    posorder(a->esq, &((*l)->prox));
    
    while (*l) l = &((*l)->prox);

    posorder(a->dir,&((*l)->prox));

    while (*l) l = &((*l)->prox);

    *l = malloc(sizeof(struct lligada));
    (*l)-> valor = a->valor;
    (*l) -> prox = NULL;
}

int depth(ABin a, int x) {
    int r = -1;
    if (a == NULL) {
        return -1; 
    }
    if (a->valor == x) {
        return 1; 
    }
    int esq = depth(a->esq, x);
    int dir = depth(a->dir, x);

    if (esq == -1 && dir == -1) {
        r= -1;
    }
    else if (esq == -1){
        r= dir+1;
    }
    else if(dir == -1){
        r= esq+1;
    }
    else if (dir < esq){
        r= 1+dir;
    }
    else{
        r= 1+esq;
    }
    return r;
}

int freeAB (ABin a) {
    int count = 0;
    if (a == NULL){
        return 0;
    }
    count ++;
    count += freeAB(a->esq);
    count += freeAB(a->dir);
    free(a);
    return count;
}

int pruneAB (ABin *a, int l) {
    if(*a == NULL)return 0;
    int r = 0;
    if (l == 0) {
        ABin temp = *a;
        *a = NULL;
        r += freeAB(temp);
    } else {
        r += pruneAB(&((*a)->dir), l - 1);
        r += pruneAB(&((*a)->esq), l - 1);
    }
    return r;
}

int iguaisAB (ABin a, ABin b) {
    if (a == NULL && b == NULL){
        return 1;
    }
    if(a == NULL || b == NULL){
        return 0;
    }
    if(a -> valor != b-> valor){
        return 0;
    }
    return iguaisAB(a->esq,b->esq) && iguaisAB(a->dir,b->dir);
}

LInt nivelL(ABin a, int n) {
    if (a == NULL) return NULL;

    if (n == 1) {
        LInt novo = malloc(sizeof(struct lligada));
        novo->valor = a->valor;
        novo->prox = NULL;
        return novo;
    } else {
        LInt esq = nivelL(a->esq, n - 1);
        LInt dir = nivelL(a->dir, n - 1);

        if (esq == NULL) return dir;

        LInt temp = esq;
        while (temp->prox != NULL)
            temp = temp->prox;
        temp->prox = dir;

        return esq;
    }
}

int nivelV (ABin a, int n, int v[]) {
    int count = 0;
    if (a == NULL || n == 0){
        return 0;
    }
    if ( n == 1){
        v[0] = a->valor;
        count++;
    }
    else{
        int esq = nivelV(a->esq, n - 1, v);
        int dir = nivelV(a->dir, n - 1, v + esq);
        count += esq + dir;
    }
    return count;
}
// esq -> raiz -> dir
int dumpAbin (ABin a, int v[], int N) {
    if(a == NULL || N == 0){
        return 0;
    }
    int esq = dumpAbin(a->esq,v,N);
    if(esq < N){
        v[esq++] = a-> valor;
    }else{
        return esq;
    }
    esq += dumpAbin(a->dir, v + esq, N - esq);
    return esq;
}

ABin somasAcA (ABin a) {
    if (a == NULL) return NULL;

    ABin aux = malloc(sizeof(struct nodo));
    aux->esq = somasAcA(a->esq);
    aux->dir = somasAcA(a->dir);

    aux->valor = a->valor;
    if (aux->esq != NULL) aux->valor += aux->esq->valor;
    if (aux->dir != NULL) aux->valor += aux->dir->valor;

    return aux;
}

int contaFolhas (ABin a) {
    if(a == NULL){
        return 0;
    }
    if(a -> esq == NULL && a-> dir == NULL){
        return 1;
    }
    int esq = contaFolhas(a->esq);
    int dir = contaFolhas(a->dir);
    return esq + dir;;
}

ABin cloneMirror (ABin a) {
    if(a == NULL){
        return NULL;
    }
    ABin aux = malloc(sizeof(struct nodo));
    aux -> valor = a ->valor;
    aux -> esq = cloneMirror(a->dir);
    aux -> dir = cloneMirror(a->esq);
    return aux;
}

int addOrd (ABin *a, int x) {
    if (*a == NULL) {
        *a = malloc(sizeof(struct nodo)); 
        if (*a == NULL){
             return -1; 
             }
        (*a)->valor = x;
        (*a)->esq = NULL;
        (*a)->dir = NULL;
        return 0;
    }
    else if ((*a)->valor == x) {
        return 1; 
    }
    else if ((*a)->valor > x) {
        return addOrd(&((*a)->esq), x);  
    }
    else {
        return addOrd(&((*a)->dir), x);  
    }
}

int lookupAB (ABin a, int x) {
    while (a != NULL){
        if(a -> valor == x){
            return 1;
        }
        if (a -> valor > x){
            a = a-> esq;
        }
        else{
            a = a->dir;
        }
    }
    return 0;
}

int depthOrd (ABin a, int x) {
    int count = 1;
    while(a!=NULL){
        if(a-> valor == x){
            return count;
        }
        else if (a->valor > x){
            a = a-> esq;
            count++;
        }
        else{
            a = a-> dir;
            count++; 
        }
    }
    return -1;
}

int maiorAB (ABin a) {
    while(a->dir!=NULL){
        a = a-> dir;
    }
    return a->valor;
}

void removeMaiorA (ABin *a) {
    if(*a == NULL){
        return;
    }
    while((*a)->dir !=NULL){
        a = &(*a)->dir;
    }
    ABin temp = *a;
    *a = (*a)->esq;
    free(temp);
}

int quantosMaiores (ABin a, int x) {
    int count=0;
    if(a==NULL){
        return 0;
    }
    if(a->valor <= x){
        count += quantosMaiores(a-> dir,x);
    }else{
        count+=1+ quantosMaiores(a->dir,x)+quantosMaiores(a->esq,x);
    }
    return count;
}

ABin buildTree(int n, LInt *l) {
    if (n <= 0) return NULL;

    ABin aux = malloc(sizeof(struct nodo));

    aux->esq = buildTree(n / 2, l); 

    aux->valor = (*l)->valor;
    *l = (*l)->prox; 

    aux->dir = buildTree(n - n / 2 - 1, l); 

    return aux;
}

void listToBTree(LInt l, ABin *a) {
    int len = 0;
    LInt aux = l;
    while (aux) {
        len++;
        aux = aux->prox;
    }
    *a = buildTree(len, &l);
}

int maxValor(ABin a) {
    while (a->dir != NULL){
        a = a->dir;
    }
    return a->valor;
}

int minValor(ABin a) {
    while (a->esq != NULL){
        a = a->esq;
    }
    return a->valor;
}

int deProcura(ABin a) {
    if (a == NULL){ 
        return 1;
    }

    if (a->esq != NULL && maxValor(a->esq) >= a->valor){
        return 0;
    }

    if (a->dir != NULL && minValor(a->dir) <= a->valor){
        return 0;
    }
    return deProcura(a->esq) && deProcura(a->dir);
}
