#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // Para usar strcmp

#define tamanho 11

typedef struct {
    int chave;
    int valor;
    bool ocupado;
    struct Node* proximo; // Adicionando o ponteiro proximo aqui
} EntradaTabela;

// Variável global para a tabela
EntradaTabela tabela[tamanho];
// Definição da estrutura do nó da lista encadeada
typedef struct Node {
    int chave;
    struct Node* proximo;
} Node;

// Primeira função hash do enunciado
int funcaoHash1(int chave, int slots) {
    return chave % slots;
}

// Segunda função hash do enunciado
int funcaoHash2(int chave, int slots) {
    return abs(chave / slots) % slots;
}

bool verificarExistencia(int chave) {
    for (int i = 0; i < tamanho; i++) {
        if (tabela[i].ocupado && tabela[i].chave == chave) {
            return true;
        }
    }
    return false;
}

int inserir(int chave, EntradaTabela tabela[], int slots, char tipoletra[]) {
    int indice = funcaoHash1(chave, slots);
    // Procura a próxima posição vazia ou uma posição ocupada com a mesma chave
    while (tabela[indice].ocupado) {
        if (tabela[indice].chave == chave) {
            printf(">>> %c %d\n", tipoletra[0], chave);
            printf("%d EXISTS\n", chave);
            return -1; // Chave já existe
        }
        indice = (indice + 1) % tamanho;
        // Verifica se voltou à posição inicial, o que significa que a tabela está cheia
        if (indice == funcaoHash1(chave, slots)) {
            return -1; // Retorna -1 para indicar que a tabela está cheia
        }
    }

    // Insere a chave na posição encontrada
    tabela[indice].chave = chave;
    tabela[indice].ocupado = true;
    return indice; // Retorna o índice onde a chave foi inserida
}

int apagarChave(int chave, EntradaTabela tabela[], int slots) {
    int indice = funcaoHash1(chave, slots);
    // Verifica se a chave está na tabela e a remove se encontrada
    while (tabela[indice].ocupado) {
        if (tabela[indice].chave == chave) {
            tabela[indice].ocupado = false;
            return 1; // Retorna 1 se a chave foi removida com sucesso
        }
        indice = (indice + 1) % tamanho;
    }
    return 0; // Retorna 0 se a chave não foi encontrada na tabela
}

void funcaoopen(int chave, EntradaTabela tabela[], char tipoletra[], int slots) {
    if (tipoletra[0] == 'I') {
        // Se a operação for de i, tenta inserir a chave na tabela
        int indice = inserir(chave, tabela, slots, tipoletra);
        if (indice != -1) {
            printf(">>> %c %d\n", tipoletra[0], chave);
            printf("%d -> %d\n", indice, chave);
            printf("OK\n");
        } else {
            printf("GIVING UP!\n");
        }
    }
    else if (tipoletra[0] == 'C') {
        // Se a operação for de c, verifica se a chave está na tabela
        int indice = inserir(chave, tabela, slots, tipoletra);
        if (indice != -1) {
            printf(">>> %c %d\n", tipoletra[0], chave);
            printf("%d\n", indice);
        } else {
            printf("NO\n");
        }
    } 
    else if (tipoletra[0] == 'D') {
        // Se a operação for de d, remove a chave da tabela
        if (apagarChave(chave, tabela, slots) == 1) {
            printf(">>> %c %d\n", tipoletra[0], chave);
            printf("OK\n");
        } else {
            printf("NO\n");
        }
    } 
    else if (tipoletra[0] == 'P') {
        // Se a operação for de p, imprime as chaves na tabela
        printf(">>> %c\n", tipoletra[0]);
        // Imprime as chaves restantes na tabela
        for (int i = 0; i < tamanho; i++) {
            if (tabela[i].ocupado) {
                printf("%d  %d\n", i, tabela[i].chave);
            }
        }
    }
}

// Função para adicionar um novo nó ao início da lista encadeada
Node* adicionarInicio(Node* cabeca, int chave) {
    // Alocar memória para o novo nó
    Node* novoNo = (Node*)malloc(sizeof(Node));
    if (novoNo != NULL) {
        // Configurar os valores do novo nó
        novoNo->chave = chave;
        novoNo->proximo = cabeca; // O próximo do novo nó aponta para o nó atualmente no início da lista
    }
    // Atualizar o ponteiro de início da lista para apontar para o novo nó
    return novoNo;
}

void funcaolink(int chave, EntradaTabela tabela[], char tipoletra[], int slots) {
    if (tipoletra[0] == 'I') {
        if (verificarExistencia(chave)) {
            printf(">>> %c %d\n", tipoletra[0], chave);
            printf("key EXISTS\n");
        } else {
            // Adicionar a chave ao início da lista encadeada
            int indice = funcaoHash1(chave, slots);
            tabela[indice].ocupado = true; // Marcar o slot como ocupado
            tabela[indice].chave = chave;
            tabela[indice].proximo = adicionarInicio(tabela[indice].proximo, chave); // Adicionar ao início da lista
            printf(">>> %c %d\n", tipoletra[0], chave);
            printf("%d -> %d\n", indice, chave); // Imprime o índice e a chave inserida
            printf("OK\n");
        }
    } else if (tipoletra[0] == 'C') {
        int indice = funcaoHash1(chave, slots);
        Node* listaAtual = tabela[indice].proximo;
        while (listaAtual != NULL) {
            if (listaAtual->chave == chave) {
                printf(">>> %c %d\n", tipoletra[0], chave);
                printf("%d\n", indice); // Imprime o índice
                return;
            }
            listaAtual = listaAtual->proximo;
        }
        printf("NO\n");
    } else if (tipoletra[0] == 'D') {
        int indice = funcaoHash1(chave, slots);
        Node* listaAtual = tabela[indice].proximo;
        Node* listaAnterior = NULL;
        while (listaAtual != NULL) {
            if (listaAtual->chave == chave) {
                printf(">>> %c %d\n", tipoletra[0], chave);
                if (listaAnterior == NULL) {
                    tabela[indice].proximo = listaAtual->proximo;
                } else {
                    listaAnterior->proximo = listaAtual->proximo;
                }
                free(listaAtual); // Liberar memória do nó deletado
                printf("OK\n");
                return;
            }
            listaAnterior = listaAtual;
            listaAtual = listaAtual->proximo;
        }
        printf("NO\n");
    } else if (tipoletra[0] == 'P') {
    printf(">>> %c\n", tipoletra[0]); // Imprime 'P'
    for (int i = 0; i < tamanho; i++) {
        if (tabela[i].ocupado) {
            printf("%d", i); // Imprime o índice
            if (!tabela[i].proximo) { // Se não houver próximo, apenas imprima a chave
                printf("%d\n", tabela[i].chave);
            } else { // Caso contrário, imprima todas as chaves na lista encadeada
                Node* listaAtual = tabela[i].proximo;
                while (listaAtual != NULL) {
                    printf(" %d",listaAtual->chave);
                    listaAtual = listaAtual->proximo;
                }
                printf("\n");
            }
        }
    }
}
}
void cuckoo(int chave, EntradaTabela tabela1[], EntradaTabela tabela2[], char tipoletra[], int slots) {
    if (tipoletra[0] == 'I') {
        // Verificar se a chave já existe
        if (verificarExistencia(chave)) {
            printf(">>> %c %d\n", tipoletra[0], chave);
            printf("%d EXISTS\n",chave);
            return;
        } 
        
        int indice1 = funcaoHash1(chave, slots);
        int indice2 = funcaoHash2(chave, slots);
        
        // Se a primeira posição está vazia
        if (!tabela1[indice1].ocupado) {
            tabela1[indice1].chave = chave;
            tabela1[indice1].ocupado = true;
            printf(">>> %c %d\n", tipoletra[0], chave);
            printf("%d\t%d -> %d\n", 0, indice1, chave); // Imprime o índice e a chave inserida
            printf("OK\n");
            return;
        } else {
            int chaveTemp = tabela1[indice1].chave;
            tabela1[indice1].chave = chave;
            printf(">>> %c %d\n", tipoletra[0], chave);
            printf("%d\t%d -> %d\n", 0, indice1, chave); // Imprime o índice e a chave inserida
            
            // Se a segunda posição está vazia
            if (!tabela2[indice2].ocupado) {
                tabela2[indice2].chave = chaveTemp;
                tabela2[indice2].ocupado = true;
                printf("%d\t%d -> %d\n", 1, indice2, chaveTemp); // Imprime o índice e a chave inserida
                printf("OK\n");
                return;
            } else {
                printf("%d\t%d -> %d\n", 1, indice2, chaveTemp); // Imprime o índice e a chave inserida
                return;
            }
        }
    } 
    else if (tipoletra[0] == 'C') {
        int indice = inserir(chave, tabela1, slots, tipoletra);
        if (indice != -1) {
            printf(">>> %c %d\n", tipoletra[0], chave);
            printf("%d\t%d -> %d\n", 0, indice, chave); // Imprime o índice e a chave inserida
        } else {
            printf("NO\n");
        }
    } 
    else if (tipoletra[0] == 'D') {
        if (apagarChave(chave, tabela1, slots) == 1 || apagarChave(chave, tabela2, slots) == 1) {
            printf(">>> %c %d\n", tipoletra[0], chave);
            printf("OK\n");
        } else {
            printf("NO\n");
        }
    } 
    else if (tipoletra[0] == 'P') {
        printf(">>> %c\n", tipoletra[0]); // Imprime 'P'
        for (int i = 0; i < slots; i++) {
            if (tabela1[i].ocupado) {
                printf("%d\t%d\t%d\n", 0, i, tabela1[i].chave);
            }
            if (tabela2[i].ocupado) {
                printf("%d\t%d\t%d\n", 1, i, tabela2[i].chave);
            }
        }
    }
}

int main() {
    int slots;
   if(scanf("%d", &slots)==1){ // Lê o número de slots na tabela
    getchar(); // Lê o caractere de nova linha após o número de slots

    char tipoconflito[10];
    if (scanf("%9s", tipoconflito)==1){ // Lê o tipo de conflito (com no máximo 9 caracteres)

    int chave;
    char operacao[10];//tipo de letra

    while (scanf("%9s", operacao) == 1) {
        if (strcmp(tipoconflito, "OPEN") == 0) {
               if(scanf("%d", &chave)==1){
                funcaoopen(chave, tabela, operacao, slots);
            }}
         else if (strcmp(tipoconflito, "LINK") == 0) {
                 if(scanf("%d", &chave)==1){;
                funcaolink(chave, tabela, operacao, slots);
                 }
        }  else if (strcmp(tipoconflito, "CUCKOO") == 0) {
                 if(scanf("%d", &chave)==1){;
                cuckoo(chave, tabela, tabela, operacao, slots); 
            }
        }
    }}}
    return 0;
}
