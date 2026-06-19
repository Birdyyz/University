#include <stdio.h>
#include <stdlib.h> // Para atoi


1.
//para ter 5
int pesquisa(int x, int a[], int N) {
    int left = 0;
    int right = N - 1;
    
    while (left <= right) {
        int mid = left + (right - left) / 2;
        
            if (a[mid] == x) {
            return mid;
        }
        
        if (a[mid] < x) {
            left = mid + 1;
        }

        else {
            right = mid - 1;
        }
    }
        return -1;
}

2.
void duplicatodos(LInt *l) {
    while (l != NULL) {
        LInt *novo = malloc(sizeof(struct LInt));
        novo->valor = l->valor;
        novo->prox = l->prox;
        l->prox = novo;
        l = novo->prox;
    }
}

3.
int expande(char s[]){
    int tamanho = strlen(s);
    int contagem=0;
    int aux[10000];
    for (int i=0;i<tamanho-1;i++){
        if (isDigit s[i]){
            while(s[i]>0){
                aux[j]=s[i-1];
                j++;
                i--;
            }
        }
    }
    for (int m=0;m<strlen(aux)-1;m++){
        s[m]=aux[m];
        contagem++;
    }
    return contagem;
}


int expande(char s[]) {
    int tamanho = strlen(s);
    int j = 0;
    int aux[10000]; // Array auxiliar para armazenar a string expandida

    for (int i = 0; i < tamanho; i++) {
        if (isdigit(s[i])) {
            int repeticoes = s[i] - '0'; // Converter o dígito de caractere para inteiro
            char caractere = s[i - 1];

            // Repetir o caractere o número de vezes indicado
            for (int k = 0; k < repeticoes; k++) {
                aux[j++] = caractere;
            }
        }
    }

    // Copiar a string expandida de volta para s
    for (int m = 0; m < j; m++) {
        s[m] = aux[m];
    }
    s[j] = '\0'; // Terminar a string expandida

    return j; // Retornar o tamanho da string expandida
}


5.
// Função para verificar se todos os nós no nível n da árvore binária são iguais
int todosiguais(ABin a, int n) {
    // Função auxiliar para percorrer a árvore até o nível n
    return todos_nivel(a, n, 1);
}

// Função auxiliar para verificar se todos os nós no nível n são iguais
int todos_nivel(ABin a, int nivel_desejado, int nivel_atual) {
    if (a == NULL) {
        return 1;  // Nó vazio é considerado igual ao nível desejado
    }

    if (nivel_atual == nivel_desejado) {
        // Se chegamos ao nível desejado, retorna verdadeiro
        return 1;
    }

    // Recursivamente chama para os nós da subárvore esquerda e direita
    int esquerda = todos_nivel(a->esq, nivel_desejado, nivel_atual + 1);
    int direita = todos_nivel(a->dir, nivel_desejado, nivel_atual + 1);

    // Verifica se ambos os lados são iguais ao nível atual
    return esquerda && direita && (a->esq == NULL || a->dir == NULL || a->esq->valor == a->dir->valor);
}

6.

// Estrutura da Pilha
typedef struct {
    int topo;
    int capacidade;
    int *valores;
} Pilha;

// Função para criar uma nova Pilha
Pilha* criaPilha(int capacidade) {
    Pilha *pilha = (Pilha *) malloc(sizeof(Pilha));
    pilha->capacidade = capacidade;
    pilha->topo = -1;  // Pilha vazia
    pilha->valores = (int *) malloc(capacidade * sizeof(int));
    return pilha;
}

// Função para verificar se a Pilha está vazia
int pilhaVazia(Pilha *pilha) {
    return pilha->topo == -1;
}

// Função para empilhar um valor na Pilha
void empilha(Pilha *pilha, int valor) {
    pilha->valores[++pilha->topo] = valor;
}

// Função para desempilhar um valor da Pilha
int desempilha(Pilha *pilha) {
    if (!pilhaVazia(pilha)) {
        return pilha->valores[pilha->topo--];
    }
    return -1; // Pilha vazia, retorno inválido
}

// Função para liberar a memória da Pilha
void liberaPilha(Pilha *pilha) {
    free(pilha->valores);
    free(pilha);
}

// Função para calcular o valor da expressão em notação polonesa reversa (RPN)
int calcula(char s[]) {
    Pilha *pilha = criaPilha(100);  // Tamanho arbitrário da pilha
    int i = 0;

    while (s[i] != '\0') {
        if (s[i] >= '0' && s[i] <= '9') {
            // Se for um dígito, converte para inteiro e empilha na pilha
            int operando = s[i] - '0';  // Converte caractere para número
            empilha(pilha, operando);
        } else if (s[i] == '+') {
            // Operação de soma
            int operando2 = desempilha(pilha);
            int operando1 = desempilha(pilha);
            int resultado = operando1 + operando2;
            empilha(pilha, resultado);
        } else if (s[i] == '*') {
            // Operação de multiplicação
            int operando2 = desempilha(pilha);
            int operando1 = desempilha(pilha);
            int resultado = operando1 * operando2;
            empilha(pilha, resultado);
        }
        i++;
    }

    // O resultado final estará no topo da pilha
    int resultado_final = desempilha(pilha);

    // Liberar a memória da pilha
    liberaPilha(pilha);

    return resultado_final;
}

#include <stdio.h>
#include <stdlib.h> // Para atoi

// Definição da estrutura STACK
typedef struct {
    int valores[100];
    int sp; // Índice do topo da pilha
} STACK;

// Função para criar uma nova pilha
STACK criaPilha() {
    STACK pilha;
    pilha.sp = -1; // Pilha vazia inicialmente
    return pilha;
}

// Função para verificar se a pilha está vazia
int pilhaVazia(STACK *pilha) {
    return pilha->sp == -1;
}
// Função para empilhar um valor na pilha
void empilha(STACK *pilha, int valor) {
    pilha->sp++;
    pilha->valores[pilha->sp] = valor;
}

// Função para desempilhar um valor da pilha
int desempilha(STACK *pilha) {
    if (!pilhaVazia(pilha)) {
        return pilha->valores[pilha->sp--];
    }
    return -1; // Pilha vazia, retorno inválido
}

// Função para calcular o valor da expressão em notação polonesa reversa (RPN)
int calcula(char s[]) {
    STACK pilha = criaPilha();
    int i = 0;

    while (s[i] != '\0') {
        if (s[i] >= '0' && s[i] <= '9') {
            // Se for um dígito, converte para inteiro e empilha na pilha
            int operando = s[i] - '0';  // Converte caractere para número
            empilha(&pilha, operando);
        } else if (s[i] == '+') {
            // Operação de soma
            int operando2 = desempilha(&pilha);
            int operando1 = desempilha(&pilha);
            int resultado = operando1 + operando2;
            empilha(&pilha, resultado);
        } else if (s[i] == '*') {
            // Operação de multiplicação
            int operando2 = desempilha(&pilha);
            int operando1 = desempilha(&pilha);
            int resultado = operando1 * operando2;
            empilha(&pilha, resultado);
        }
        i++;
    }

    // O resultado final estará no topo da pilha
    int resultado_final = desempilha(&pilha);

    return resultado_final;
}

// Definição da estrutura STACK
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

// Função para calcular o valor da expressão em notação polonesa reversa (RPN)
int calcula(char s[]) {
    STACK pilha;
    empty(&pilha); // Inicializa a pilha como vazia

    int i = 0;
    while (s[i] != '\0') {
        if (s[i] >= '0' && s[i] <= '9') {
            // Se for um dígito, converte para inteiro e empilha na pilha
            int operando = s[i] - '0';  // Converte caractere para número
            push(&pilha, operando);
        } else if (s[i] == '+') {
            // Operação de soma
            int operando2, operando1;
            if (pop(&pilha, &operando2) || pop(&pilha, &operando1)) {
                return -1; // Operação inválida (não há operandos suficientes)
            }
            int resultado = operando1 + operando2;
            push(&pilha, resultado);
        } else if (s[i] == '*') {
            // Operação de multiplicação
            int operando2, operando1;
            if (pop(&pilha, &operando2) || pop(&pilha, &operando1)) {
                return -1; // Operação inválida (não há operandos suficientes)
            }
            int resultado = operando1 * operando2;
            push(&pilha, resultado);
        }
        i++;
    }

    // O resultado final estará no topo da pilha
    int resultado_final;
    if (pop(&pilha, &resultado_final) || !isEmpty(&pilha)) {
        return -1; // Pilha não está vazia ou operação inválida
    }

    return resultado_final;
}

