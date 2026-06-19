#include <stdio.h>
#include <stdlib.h>
typedef struct ABin_nodo {
int valor;
struct ABin_nodo *esq, *dir;
} *ABin;
typedef struct LInt_nodo {
int valor;
struct LInt_nodo *prox;
} *LInt;

int find_sum(ABin a){
    int r=0;
    if (a==NULL){
        r=0;
    }
    else{
        r+=a->valor+find_sum(a->esq)+find_sum(a->dir);
    }
    return r;
}

int countLInt (LInt l){
    int r=0;
    if (l==NULL){
        r=0;
            }
    while (l!=NULL){
        r++;
        l=l->prox;
    }
    return r;
}

ABin Search (ABin a, int x){
    ABin r;
    if (a==NULL){
        return NULL;
    }
    if (a->valor ==x){
        r=a;
    }
    if (a->valor<x){
        Search(a->esq,x);
    }
    if (a->valor > x){
        Search(a->dir,x);
    }
    return r;
}
int makeNegative(int num)
{
  if (num>0){
    return -num;
  }
  return num;
}

void neutralize(const char *s1, const char *s2, char *s3) {
    for (int i = 0; s1[i] != '\0'; i++) {
        if (s1[i] == s2[i])
            s3[i] = s1[i];  
        else
            s3[i] = '0';   
    }
    s3[strlen(s1)] = '\0';
}

void neutralize (const char *s1, const char *s2, char *s3)
{
  int a = strlen(s1);
  int b = strlen(s2);
  
  if (a != b){
    return;
  }


for(int i = 0; i < a; i++) {
  if ( s1[i] == '+' && s2[i] == '+'){
    s3[i] = '+';
  } else if ( s1[i] == '-' && s2[i] == '-'){
    s3[i] = '-';
} else {
    s3[i] = '0';
  }
}
  
  s3[a] = '\0';
}  

int same_case(char a, char b) {
    if ((isupper(a) && isupper(b)) || (islower(a) && islower(b))) {
        return 1; 
    } else if ((isupper(a) && islower(b)) || (islower(a) && isupper(b))) {
        return 0; 
    } else {
        return -1; 
    }
}
int somaelem(int v[],int N){
  int soma=0;
      for (int i = 0; i < N; i++) {
        soma+=v[i];

}
return soma;
}

int maior(int v[],int N){
  int atual=0;
      for (int i = 0; i < N; i++) {
if (v[i]>atual){
  atual=v[i];
}
}
return atual;
}
int menor(int v[],int N){
  int min=v[0];
      for (int i = 1; i < N; i++) {
if (v[i]<min){
  min=v[i];
}
}
return min;
}
void aux (int v[], int i, int j){
  int temp =v[i];
  v[i]=v[j];
  v[j]=temp;
}
void inverteArray(int v[],int N){
  int i,j;
  for ( i=0, j = N-1; i<j; i++,j--){
  aux(v,i,j);
}

}

int segmaior(int v[],int N){
  int seg=v[0];
  int maior = v[0];
      for (int i = 1; i < N; i++) {
if (v[i]>maior){
  maior=v[i];
}
if (v[i]!=maior && v[i]>seg){
  seg=v[i];
}
}
return seg;
}

int maxind(int a[], int N){
  int max=0;
  int valormax=a[0];
  for(int i=1;i<N;i++){
    if (a[i]>valormax){
      valormax=a[i];
      max=i;
    }
  }
  return max;
}

int eVogal(char c){
  char *Vogais= "AEIOUaeiou";
  while (*Vogais!='\0'){
    if (*Vogais==c){
      return 1;
    }
    Vogais++;
  }
  return 0;
}

int contaVogais (char *s){
  inr r=0;
  for (int i=0; s[i]!='\0';i++){
    if (eVogal(s[i])==1){
      r++;
    }
  }
  return r;
}


int retiravogaisRep(char *s){
  int r=0;
  for (int i=1; s[i]!='\0';i++){
    if (s[i-1]==s[i]){
      s[i]=s[i+1];
      r++
    }
  }
  return r;
}


int length(LInt l){
  int tamanho=0;
  while (l!=NULL){
    tamanho++;
    l=l->prox;
  }
  return tamanho;
}


LInt clone (LInt l){
  LInt r= malloc(sizeof(struct lligada));
  if (l==NULL){
    return NULL;
  }
  else{
    r->valor = l->valor;
     r->prox=clone (l->prox);
  }
  return r;
}

int contarOcorrencias(LInt l, int x){
  int atual=0;
  while (l!=NULL){
    if(l->valor==x){
      atual++;
    }
    l=l->prox;
  }
  return atual;
}

void removerelemento(LInt *l, int x) {
    LInt atual = *l;
    LInt anterior = NULL;
int ocorrencia=0;
    while (atual != NULL) {
        if (atual->valor == x && ocorrencia==0){
            if (anterior == NULL) { // O nó a ser removido é o primeiro nó
                atual = atual->prox;
                ocorrencia=1;
            } else {
                anterior->prox = atual->prox;
                ocorrencia=1;
            }
        }
        anterior = atual;
        atual = atual->prox;
    }
}

LInt removeMaiores(LInt l, int x) {
    LInt atual = l;
    while (atual->prox != NULL) {
        if (atual->prox->valor > x) {
            atual->prox = NULL;
        } else {
            atual = atual->prox;
        }
    }
    return l;
}



int quantosMaior(LInt l, int x) {
int conta =0;
if (l==NULL){
  return conta;
}
else{
  while(l!=NULL){
    if(l->valor>x){
      conta++;
    }
    l=l->prox;
  }
}
return conta;
}


int quantosMenos(LInt l,int x){
  int conta=0;
 if (l==NULL){
  return conta;
}
else{
  while(l!=NULL){
    if(l->valor<x){
      conta++;
    }
    l=l->prox;
  }
}
return conta;
}


int encontrarmaior(LInt *l){
  LInt atual=*l;
  if (*l==NULL){
    return 0;
  }
  int max =atual->valor;
  atual=atual->prox;
  while(atual!=NULL){
    if(atual->valor>max){
      max=atual->valor;
    }
    atual=atual->prox;
  }
return max;
}


int encontrarmenor(LInt *l){
  LInt atual=*l;
  if (*l==NULL){
    return 0;
  }
  int min =atual->valor;
  atual=atual->prox;
  while(atual!=NULL){
    if(atual->valor<min){
      min=atual->valor;
    }
    atual=atual->prox;
  }
return min;
}


int contarNodos(LInt *l){
  LInt atual=*l;
  int nodos=0;
  if(*l==NULL){
    nodos=0;
  }
  else{
    while(atual!=NULL){
      nodos++;
      atual=atual->prox;
    }
  }
  return nodos;
}


int quantosMenor(LInt *l,int x){
  LInt atual = *l;
  int menores =0;
  if (*l==NULL){
  return 0;
}
else{
   while (atual !=NULL){
    if(atual->valor<x){
    menores++;
  }
      atual=atual->prox;
}}
return menores;
}

int quantosMaior(LInt *l,int x){
  LInt atual = *l;
  int maiores =0;
  if (*l==NULL){
  return 0;
}
else{
while (atual!=NULL){
  if(atual->valor>x){
    maiores++;
  }
      atual=atual->prox;
}}
return maiores;
}


int delete(LInt *l,int n){
  LInt atual=*l;
  LInt prev = NULL;
  if(n==0){
    *l=(*l)->prox;
  }
  else{
    while(atual!=NULL && n>0){
      prev = atual;
      atual=atual->prox;
      n--;
    }
    if (n>=1){
      return -1;
    }
    else{
 prev->prox = atual->prox;   
 }
  }
  return 0;
}

void inserirFim(LInt *l, int x) {
    LInt novo = (LInt)malloc(sizeof(struct lligada));
    novo->valor = x;
    novo->prox = NULL;

    if (*l == NULL) {
        *l = novo;
    } else {
        LInt atual = *l;
        while (atual->prox != NULL) {
            atual = atual->prox;
        }
        atual->prox = novo;
    }
}

int buscarValor(LInt l, int x) {
    LInt atual = l;
    while (atual != NULL) {
        if (atual->valor == x) {
            return 1; 
        }
        atual = atual->prox;
    }
    return 0; 
}


LInt inverterLista(LInt l) {
    LInt prev = NULL;
    LInt atual = l;
    LInt prox = NULL;
    
    while (atual != NULL) {
        prox = atual->prox;
        atual->prox = prev;
        prev = atual;
        atual = prox;
    }
    
    return prev;
}

LInt inserirInicio(LInt l, int valor) {
    LInt novo = malloc(sizeof(struct lligada));
    novo->valor = valor;
    novo->prox = NULL;
    novo->prox = l; // O próximo do novo nó aponta para a lista atual
    return novo;   // O novo nó se torna a nova cabeça da lista
}

// Função para inserir um novo valor em uma lista encadeada ordenada
LInt inserirOrdenado(LInt l, int x) {
    LInt novo = malloc(sizeof(struct lligada));
    novo->x = valor;
    novo->prox = NULL;
    if (l == NULL || x < l->x) {
        novo->prox = l;
        return novo;
    }
    while (l->prox != NULL && x > l->prox->x) {
        l = l->prox;
    }

    novo->prox = l->prox;
    l->prox = novo;

    return l;
}

LInt saltapx(LInt l, int x) {
    if (l == NULL) {
        return NULL;
    }

    LInt atual = l;
    if (x == 0) {
       atual = atual->prox;
        return l;
    }
    while (atual != NULL && x > 1) {
        atual = atual->prox;
        x--;
    }
    if (x == 1 && atual != NULL && atual->prox != NULL) {
        atual->prox = atual->prox->prox;
    }

    return l;
}

int delete(LInt *l,int n){
  LInt atual=*l;
  if(n==0){
    *l=(*l)->prox;
    return 0;
  }
  
    while(atual->prox!=NULL && n>1){
      atual=atual->prox;
      n--;
    }
    if (atual == NULL || atual->prox == NULL) {
        return -1;
    }
 atual->prox = atual->prox->prox;   
 
  
  return 0;
}

LInt removeultimo(LInt *l){
  LInt anterior=NULL;
  LInt atual=*l;
  if (*l==NULL){
    return NULL;
  }
  while (atual->prox!=NULL){
    anterior=atual;
    atual=atual->prox;
  }
  if (anterior==NULL){
    return NULL;
  }
  else{
    anterior->prox=NULL;
  }
  return atual;
}

LInt removeprimeiro(LInt *l){
  if (*l==NULL){
    return NULL;
  }
  else{
    *l=(*l)->prox;
  }
}

LInt insereFinal(LInt *l,int x){
  LInt novo=malloc(sizeof(struct lligada));
  novo->valor=x;
  novo->prox=NULL;
  LInt atual=*l;
  if (*l==NULL){
    *l=novo;
    return *l;
  }
  while(atual->prox!=NULL){
    atual=atual->prox;
  }
  atual->prox=novo;
  return *l;
}


LInt insereInicio(LInt *l, int x) {
    LInt novo = malloc(sizeof(struct lligada));
    novo->valor = x;
    novo->prox = *l;
    *l = novo;
    return *l;
}


ABin minValueNode(ABin a) {
    ABin atual = a;
    while (atual && atual->esq != NULL) {
        atual = atual->esq;
    }
    return atual;
}
ABin removeNo(ABin a, int valor) {
    if (a == NULL) return a;

    if (valor < a->valor) {
        a->esq = removeNo(a->esq, valor);
    } else if (valor > a->valor) {
        a->dir = removeNo(a->dir, valor);
    } else {
        if (a->esq == NULL) {
            ABin temp = a->dir;
            free(a);
            return temp;
        } else if (a->dir == NULL) {
            ABin temp = a->esq;
            free(a);
            return temp;
        }

        ABin temp = minValueNode(a->dir);
        a->valor = temp->valor;
        a->dir = removeNo(a->dir, temp->valor);
    }
    return a;
}

int contaFolhas (ABin a) {
  int r=0;
  if (a==NULL){
    return r;
  }
  if (a->dir==NULL && a->esq ==NULL){
    r+= 1+ contaFolhas(a->esq)+ contaFolhas(a->dir);
  }
  else{
      r+=contaFolhas(a->esq)+ contaFolhas(a->dir);
  }
return r;
}

void removeMaiorA(ABin *A) {
    ABin b = *A;
    
    if (b == NULL) {
        return;
    }

    if (b->dir == NULL) {
        *A = b->esq; 
    } else {
        removeMaiorA(&(b->dir));
    }
}

int search(ABin a, int x){
  int r;
  if(a==NULL){
    return 0;
  }
  if (a->valor==x){
    r=1;
    return 1;
  }
  if (a->valor>x){
    r=search(a->esq,x);
  }
  else{
    r=search(a->dir,x);
  }
  return 0;
}


int main() {

  int number = 7;

  switch(number) {
    case 1:
      printf("Bulbasaur\n");
      break;
    case 2:
      printf("Ivysaur\n");
      break;
    case 3:
      printf("Venusaur\n");
      break;
    case 4:
      printf("Charmander\n");
      break;
    case 5:
      printf("Charmeleon\n");
      break;
    case 6:
      printf("Charizard\n");
      break;
      case 7:
      printf("Squirtle");
      break;
      case 8:
      printf("Wartortle");
      break;
      case 9:
      printf("Blastoise");
      break;
    default:
      printf("Unknown\n");
      break;
  }
}

void neutralize (const char *s1, const char *s2, char *s3)
{
  int i=0;
  while(s1[i] != '\0'){
    if(s1[i] == s2[i])
      s3[i] = s1[i];
    else
      s3[i] = '0';
    
    i++;
  }
  s3[i] = '\0';
}

int soma(int a[], int N){
  int r=0;
  for (int i=0; i<N;i++){
r+= a[i];
  }
  return r;
}
double media(int a[], int N){
  int r= soma(a,N);
  int m=(double)r/N;
  return m;
}
void aux(int a[], int start, int end){
  while (start<end){
    int temp=a[start];
    a[start]=a[end];
    a[end]=temp;
    start++;
    end--;
  }
}
void inverte(int a[], int N){
  aux(a,0,N-1);
}

int busca(int a[], int N, int x){
  for (int i=0;i<N;i++){
    if (a[i]==x){
      return i;
    }
  }
  return -1;
}

void ordena(int a[], int N) {
    int temp;
    for (int i = 0; i < N - 1; i++) {
        for (int j = 0; j < N - 1 - i; j++) {
            if (a[j] > a[j + 1]) {
                temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;
            }
        }
    }
}

int comuns(int a[], int N, int b[], int M) {
    int count = 0;
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            if (a[i] == b[j]) {
                count++;
                break; 
            }
        }
    }
    return count;
}