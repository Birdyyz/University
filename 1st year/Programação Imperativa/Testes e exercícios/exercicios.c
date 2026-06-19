#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
typedef struct lint_nodo {
int valor;
struct lint_nodo *prox;
} *LInt;
typedef struct abin_nodo {
    int valor;
    struct abin_nodo *esq, *dir;
} *ABin;
int fizzbuzz(int n) {
    int count = 0;
    int foundFizzBuzz = 0;
    int i;

    for (i = 0; i < n; i++) {
        if (fizz(i) && buzz(i)) {
            printf("FizzBuzz\n");
            foundFizzBuzz = 1;
            count = 0; // reset count after finding FizzBuzz
        } else if (fizz(i)) {
            printf("Fizz\n");
            if (foundFizzBuzz) {
                count++;
            }
        } else if (buzz(i)) {
            printf("Buzz\n");
            if (foundFizzBuzz) {
                return count; // return count on first Buzz after FizzBuzz
            }
        } else {
            printf("%d\n", i);
            if (foundFizzBuzz) {
                count++;
            }
        }
    }

    return -1; // No Buzz found after FizzBuzz
}


// Função auxiliar para inverter uma parte do array
void reverse(int a[], int start, int end) {
    while (start < end) {
        int temp = a[start];
        a[start] = a[end];
        a[end] = temp;
        start++;
        end--;
    }
}

// Função para rodar o array r posições para a esquerda
void rodaEsq(int a[], int N, int r) {
    // Inverter os primeiros r elementos
    reverse(a, 0, r - 1);
        reverse(a, r, N - 1);
            reverse(a, 0, N - 1);


}


// Função para remover o n-ésimo elemento de uma lista ligada
int delete(int n, LInt *l) {
    if (n < 0 || l == NULL || *l == NULL) return -1; // Verificação de parâmetros inválidos

    LInt current = *l;
    if (n == 0) { // Caso especial: remover o primeiro elemento
        *l = current->prox;
        free(current);
    }

    LInt prev = NULL;
    // Percorre a lista até encontrar o n-ésimo elemento
    while (current != NULL && n>0) {
        prev = current;
        current = current->prox;
        n--;
    }

    if (current == NULL) return -1; // n é maior que o tamanho da lista

    // Remove o n-ésimo elemento
    prev->prox = current->prox;
    free(current);

    return 0; // Sucesso
}

int delete (LInt *l,int n){
LInt atual=*l;
      if (*l==NULL){
      return -1;
}
        if (n==0){
    *l=(*l)->prox;
    return 0;
}
        else{
        while(atual->prox!=NULL && n>1){
        atual=atual->prox;
        n--;
    }
    if (atual->prox==NULL || atual==NULL){
    return -1;     
    }
}
atual->prox=atual->prox->prox;
return 0;
}


int maxCresc(LInt l) {
    if (l == NULL) return 0;

    int maxLength = 1; // Comprimento máximo encontrado
    int currentLength = 1; // Comprimento da sequência atual

    LInt prev = l;
    l = l->prox;

    while (l != NULL) {
        if (l->valor > prev->valor) {
            currentLength++;
        } else if (currentLength > maxLength) {
                maxLength = currentLength;
                currentLength = 1;
                    }
        prev = l;
        l = l->prox;
    }
    return maxLength;
}

ABin folhaEsq(ABin a) {
    // Se a árvore está vazia, retorna NULL
    if (a == NULL) return NULL;

    // Se o nodo atual é uma folha (ambas as sub-árvores são NULL), retorna o nodo atual
    if (a->esq == NULL && a->dir == NULL) return a;

    // Recursivamente busca a folha mais à esquerda na sub-árvore esquerda
    ABin leftLeaf = folhaEsq(a->esq);
    if (leftLeaf != NULL) return leftLeaf;

    // Se não encontrou uma folha na sub-árvore esquerda, busca na sub-árvore direita
    return folhaEsq(a->dir);
}



typedef struct {
    char items[MAX];
    int top;
} Stack;

void init(Stack *s) {
    s->top = -1;
}

int isEmpty(Stack *s) {
    return s->top == -1;
}

int isFull(Stack *s) {
    return s->top == MAX - 1;
}

void push(Stack *s, char item) {
    if (!isFull(s)) {
        s->items[++s->top] = item;
    }
}

char pop(Stack *s) {
    if (!isEmpty(s)) {
        return s->items[s->top--];
    }
    return '\0';
}

char peek(Stack *s) {
    if (!isEmpty(s)) {
        return s->items[s->top];
    }
    return '\0';
}

int isMatchingPair(char left, char right) {
    return (left == '(' && right == ')') ||
           (left == '[' && right == ']') ||
           (left == '{' && right == '}');
}

int parentesisOk(char exp[]) {
    Stack s;
    init(&s);

    for (int i = 0; exp[i] != '\0'; i++) {
        if (exp[i] == '(' || exp[i] == '[' || exp[i] == '{') {
            push(&s, exp[i]);
        } else if (exp[i] == ')' || exp[i] == ']' || exp[i] == '}') {
            if (isEmpty(&s) || !isMatchingPair(pop(&s), exp[i])) {
                return 0; // Parênteses não balanceados
            }
        }
    }

    return isEmpty(&s); // Verifica se todos os parênteses foram fechados
}
typedef struct {
    int valores[100];
    int sp; // Índice do topo da pilha
} STACK;

// Função para esvaziar a pilha
void empty(STACK *s) {
    s->sp = 0;
}

// Função para verificar se a pilha está vazia
int isEmpty(STACK *s) {
    return (s->sp == 0);
}

// Função para empilhar um valor na pilha
int push(STACK *s, int x) {
    if (s->sp == 100) {
        return 1; // Pilha cheia
    }
    s->valores[s->sp] = x;
    s->sp++;
    return 0; // Sucesso
}

// Função para obter o topo da pilha sem remover
int top(STACK *s, int *x) {
    if (s->sp == 0) {
        return 1; // Pilha vazia
    }
    *x = s->valores[s->sp - 1];
    return 0; // Sucesso
}

// Função para remover o elemento do topo da pilha
int pop(STACK *s, int *x) {
    if (s->sp == 0) {
        return 1; // Pilha vazia
    }
    s->sp--;
    *x = s->valores[s->sp];
    return 0; // Sucesso
}

// Função para verificar se os parênteses estão balanceados
int isMatchingPair(char left, char right) {
    return (left == '(' && right == ')') ||
           (left == '[' && right == ']') ||
           (left == '{' && right == '}');
}

int parentesisOk(char exp[]) {
    STACK s;
    empty(&s);

    for (int i = 0; exp[i] != '\0'; i++) {
        if (exp[i] == '(' || exp[i] == '[' || exp[i] == '{') {
            push(&s, exp[i]);
        } else if (exp[i] == ')' || exp[i] == ']' || exp[i] == '}') {
            if (isEmpty(&s)) {
                return 0; // Parênteses não balanceados
            }
            int topValue;
            pop(&s, &topValue);
            if (!isMatchingPair(topValue, exp[i])) {
                return 0; // Parênteses não balanceados
            }
        }
    }

    return isEmpty(&s); // Verifica se todos os parênteses foram fechados
}
