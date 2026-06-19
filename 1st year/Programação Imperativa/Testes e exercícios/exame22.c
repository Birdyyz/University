#include <stdio.h>
/*
dado um array ordenado de tamanho N > 0, devolve um índice onde se
encontra o valor x. Caso x não exista no array a função deverá devolver -1
*/
int pesquisa (int a[], int N, int x){
    for(int i = 0; i < N ; i++){
        if(a[i] == x){
            return i;
        }
        if(x > a[i]){
            return -1;
        }
    }
    return -1;
}

typedef struct LInt_nodo {
int valor;
struct LInt_nodo *prox;
} *LInt;
/*
que move o último elemento da lista para a cabeça da mesma (sem alocar nova memória).
*/
void roda (LInt *l){
    if(*l == NULL ||(*l)-> prox == NULL){
        return;
    }
    LInt ultimo = *l;
    LInt penultimo = NULL;
    while(ultimo != NULL) {
        penultimo = ultimo;
        ultimo = ultimo -> prox;
    }
    penultimo -> prox = NULL;
    ultimo -> prox = *l;
    *l = ultimo;
}

typedef struct ABin_nodo {
int valor;
struct ABin_nodo *esq, *dir;
} *ABin;

/*
que apaga n nodos de uma árvore binária. O critério para escolha de quais os nodos a apagar é livre. Se a
árvore tiver menos do que n nodos então a deve apagar todos. A função deve
devolver o número de nós efetivamente apagados
*/
int apaga(ABin *a, int n) {
    if (*a == NULL || n <= 0) {
        return 0;
    }

    int apagados = 0;

    apagados += apaga(&((*a)->esq), n - apagados);
    if (apagados >= n){ 
        return apagados;  
    }

    apagados += apaga(&((*a)->dir), n - apagados);

    if (apagados >= n){ 
        return apagados;
    }

    if (apagados < n) {
        ABin temp = *a;
        *a = NULL;  
        free(temp);
        apagados++;
    }

    return apagados;
}

/*
dada uma uma string s com um identificador só com dígitos, acrescenta-lhe um dígito de controle no final
calculado de acordo com o método de Luhn. Neste método, o dígito de controle a
incluir deve fazer com que a soma de todos os dígitos (incluindo o próprio dígito de
controle) seja um múltiplo de 10. No entanto, no caso dos dígitos em posições
pares (a começar do final) o que deve ser somado são os dígitos do número
correspondente ao seu dobro. Por exemplo, dado o identificador "9871", a soma
em questão corresponde a 9+1+6+7+2 = 25 (note como o dígito 1 e 8 foram
substituídos, respectivamente, por 2 e 1+6). Como a soma é 25, o dígito de controle
a acrescentar deve ser 5, pelo que a string no final deverá ser "98715"
*/
void checksum(char s[]) {
    int len = strlen(s);
    
    for (int i = 0; i < len; i++) {
        if (!isdigit(s[i])) {
            s[0] = '\0';
            return;
        }
    }

    if (len + 1 >= sizeof(s)/sizeof(s[0])) {
        s[0] = '\0'; 
        return;
    }

    int sum = 0;
    for (int i = 0; i < len; i++) {
        int digit = s[len - 1 - i] - '0'; 

        if (i % 2 == 1) { 
            digit *= 2;
            if (digit > 9) {
                digit = digit - 9; 
            }
        }
        sum += digit;
    }

    int check_digit = (10 - (sum % 10)) % 10;
    s[len] = check_digit + '0';
    s[len + 1] = '\0';
}
/*
cujo objetivo é determinar a quantidade de produtos que um
vendedor ambulante deve transportar. O vendedor tem à sua disposição uma
quantidade ilimitada de N produtos diferentes, cujos valores e pesos estão
guardados nos arrays valor e peso, respectivamente, mas só tem capacidade para
transportar C kg.
A função deve tentar maximizar o valor total dos produtos a
transportar, valor este que deve ser devolvido, e colocar no array quant a respectiva
quantidade de cada produto. 
Por exemplo, se tivermos 3 produtos com valores
[20,150,30] e pesos [2,10,3] e capacidade para 14 kg, então uma escolha ideal
de quantidades seria [2,1,0], correspondente ao valor total de 190. 
Mesmo que não consiga implementar uma estratégia de escolha óptima, implemente outra que
ache razoável. O critério mais importante é o peso total não ultrapassar a
capacidade de transporte C.
*/

int escolhe(int N, int valor[], int peso[], int C, int quant[]) {
    int valorMax[C+1];          
    int ultimoItem[C+1];   
    

    for (int w = 0; w <= C; w++) {
        valorMax[w] = 0;
        ultimoItem[w] = -1;  
    }

    for (int w = 1; w <= C; w++) {
        for (int i = 0; i < N; i++) {
            if (peso[i] <= w) {
                if (valor[i] + valorMax[w - peso[i]] > valorMax[w]) {
                    valorMax[w] = valor[i] + valorMax[w - peso[i]];
                    ultimoItem[w] = i;
                }
            }
        }
    }

    for (int i = 0; i < N; i++) {
        quant[i] = 0;
    }

    int capacidadeAtual = C;
    while (capacidadeAtual > 0 && ultimoItem[capacidadeAtual] != -1) {
        int item =ultimoItem[capacidadeAtual];
        quant[item]++;
        capacidadeAtual -= peso[item];
    }

    return valorMax[C];
}