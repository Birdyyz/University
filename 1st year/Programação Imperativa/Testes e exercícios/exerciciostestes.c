#include <stdio.h>
//TESTE 2022
void organiza(int a[], int n) {
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (a[j] > a[j + 1]) {
                int temp = a[j];
                a[j] = a[j + 1];
                a[j + 1] = temp;
            }
        }
    }
}

int nesimo(int a[], int N, int i) {
    organiza(a, N);
    return a[i - 1];
}

typedef struct LInt_nodo {
int valor;
struct LInt_nodo *prox;
} *LInt;

LInt removeMaiores(LInt l, int x) {
    while (l != NULL && l->valor > x) {
        l = l->prox;
    }

    if (l == NULL) {
        return NULL;
    }

    LInt lista = l;
    while (lista->prox != NULL) {
        if (lista->prox->valor > x) {
            LInt temp = lista->prox;
            lista->prox = lista->prox->prox;
        } else {
            lista = lista->prox;
        }
    }
    return l;
}
LInt removeMaiores(LInt l, int x) {
    if (l == NULL) {
        return NULL;
    }
    if (l->valor>x){
        l=l->prox;
    }
    LInt lista = l;
    while (lista->prox != NULL) {
        if (lista->prox->valor > x) {
            lista->prox = lista->prox->prox;
        } else {
            lista = lista->prox;
        }
    }
    return l;
}
typedef struct ABin_nodo {
int valor;
struct ABin_nodo *esq, *dir;
} *ABin;

LInt caminho(ABin a, int x) {
    if (a == NULL) {
        return NULL;
    }
    
    if (a->valor == x) {
        LInt l = malloc(sizeof(struct LInt_nodo));
        l->valor = x;
        l->prox = NULL;
        return l;
    }
    
    if (a->valor < x) {
        LInt ldir = caminho(a->dir, x);
        if (ldir != NULL) {
            LInt l = malloc(sizeof(struct LInt_nodo));
            l->valor = a->valor;
            l->prox = ldir;
            return l;
        }
    }
        if (a->valor > x) {
        LInt lesq = caminho(a->esq, x);
        if (lesq != NULL) {
            LInt l = malloc(sizeof(struct LInt_nodo));
            l->valor = a->valor;
            l->prox = lesq;
            return l;
        }
    }
        return NULL;
}


void inc(char s[]) {
    int len = strlen(s);
    int carry = 1; // Inicializamos o "vai um" como 1 para começar o incremento
    for (int i = len - 1; i >= 0; i--) {
        int numero = s[i] - '0'; // Convertendo o caractere para o valor numérico
        numero += carry; // Incrementando o dígito

        if (numero < 10) {
            s[i] = numero + '0'; // Convertendo o dígito de volta para o caractere
            break; // Saímos do loop, pois não há necessidade de continuar a incrementar
        } else {
            s[i] = '0'; // O último dígito torna-se 0
            carry = 1; // Atualizamos o "vai um" para a próxima iteração
        }
    }
}

int sacos(int p[], int N, int C) {
    int numsacos = 0;
    int capacidade= C;
    
    for (int i = 0; i < N; i++) {
        if (p[i] > capacidade) {
            numsacos++; 
            capacidade = C; 
        }
        capacidade -= p[i]; 
    }
numsacos++;
    return numsacos; 
}
// EXAME 2022
int pesquisa(int a[], int N, int x) {
    int r = -1;
    for (int i = 0; i < N; i++) {
        if (a[i] == x) {
            r = i; 
            break; 
        }
    }
    return r; 
}
int pesquisa(int a[], int N, int x) {
    int encontrado = 0;
    for (int i = 0; i < N; i++) {
        if (a[i] == x) {
        encontrado=1;
        return i;
        }
        if (a[i]>x && encontrado=0){
            return -1;
        }
    }
    return -1; 
}
void roda(LInt *l) {
    // Se a lista estiver vazia ou tiver apenas um elemento, não há nada para fazer
    if (*l == NULL || (*l)->prox == NULL) {
        return;
    }

    LInt last = *l;
    LInt prev = NULL;

    // Percorre a lista até o último elemento e armazena o penúltimo
    while (last->prox != NULL) {
        prev = last;
        last = last->prox;
    }

    // Desconecta o último nó da lista
    prev->prox = NULL;

    // Conecta o último nó como o novo primeiro nó
    last->prox = *l;
    *l = last;
}

void checksum(char s[]) {
    int len = strlen(s);
    int soma = 0;
    
    // Percorre a string de trás para frente
    for (int i = len - 1; i >= 0; i--) {
        int digito = s[i] - '0'; // Converte o caractere para inteiro
        
        if ((i+1) % 2 == 0) { // Se a posição é par
            digito *= 2;
            if (digito >=10) {
                digito = digito / 10 + digito % 10; // Soma os dígitos do número
            }
        }
        soma += digito;
    }
    
    int digito_controle = (10 - (soma % 10)) % 10; // Calcula o dígito de controle
    
    // Adiciona o dígito de controle à string
    s[len] = digito_controle + '0';
    s[len + 1] = '\0';
}

int escolhe(int N, int valor[], int peso[], int C, int quant[]) {
    int dp[C ];
    int escolhidos[C];

    // Inicializa o array dp e escolhidos com 0
    for (int i = 0; i <= C; i++) {
        dp[i] = 0;
        escolhidos[i] = -1;
    }

    // Preenche o array dp
    for (int i = 0; i < N; i++) {
        for (int j = peso[i]; j <= C; j++) {
            if (valor[i] + dp[j - peso[i]] > dp[j]) {
                dp[j] = valor[i] + dp[j - peso[i]];
                escolhidos[j] = i; // Armazena o índice do último produto escolhido
            }
        }
    }

    // Reconstrói a solução a partir do array escolhidos
    int c = C;
    while (escolhidos[c] != -1) {
        quant[escolhidos[c]]++;
        c -= peso[escolhidos[c]];
    }

    return dp[C];
}

//TESTE 2023
int perfeito(int x) {
    int soma = 0;
    
    for (int i = 1; i <= x / 2; i++) {
        if (x % i == 0) {
            soma += i;
        }
    }
        return soma == x;
}
typedef struct {
int x,y;
} Ponto;
// Função para calcular a distância de um ponto à origem
double distancia_origem(Ponto p) {
    return sqrt(p.x * p.x + p.y * p.y);
}

// Função para trocar dois pontos de posição no array
void trocar(Ponto *p1, Ponto *p2) {
    Ponto temp = *p1;
    *p1 = *p2;
    *p2 = temp;
}

// Função para particionar o array para o algoritmo de ordenação rápida
int particionar(Ponto pos[], int inicio, int fim) {
    double pivot = distancia_origem(pos[fim]);
    int i = inicio - 1;
    
    for (int j = inicio; j < fim; j++) {
        if (distancia_origem(pos[j]) < pivot) {
            i++;
            trocar(&pos[i], &pos[j]);
        }
    }
    
    trocar(&pos[i + 1], &pos[fim]);
    return i + 1;
}

// Função de ordenação rápida
void quicksort(Ponto pos[], int inicio, int fim) {
    if (inicio < fim) {
        int pi = particionar(pos, inicio, fim);
        quicksort(pos, inicio, pi - 1);
        quicksort(pos, pi + 1, fim);
    }
}

// Função para ordenar os pontos por distância à origem
void ordena(Ponto pos[], int N) {
    quicksort(pos, 0, N - 1);
}

int depth(ABin a, int x) {
    if (a == NULL) {
        return -1; 
    }  
    
    if (a->valor == x) {
        return 0;
    
    int r1 = -1, r2 = -1;
    if (a->valor > x) {
        r1 = depth(a->esq, x); 
    } else {
        r2 = depth(a->dir, x); 
    }
    
    if (r1 == -1 && r2 == -1) {
        return -1; 
    }
    if (r1 >= 0) {
        r1++; 
    }
    
    if (r2 >= 0) {
        r2++; 
    }
    
    if (r1 == -1 || (r2 != -1 && r2 < r1)) {
        return r2; 
    } else {
        return r1; 
    }
}
}
//está quase
int wordle(char secreta[], char tentativa[]) {
    int r = 0;
    for (int i = 0; secreta[i] != '\0' && tentativa[i] != '\0'; i++) {
        if (secreta[i] == tentativa[i]) {
            tentativa[i] = toupper(tentativa[i]); 
            r++;
        } else {
           tentativa[i] = '*';

        }
    }
    return r;
}

//EXAME 2023
int isFib(int x) {
    int fib1 = 0;
    int fib2 = 1;
    int proximo = fib1 + fib2;

    while (proximo <= x) {
        if (proximo == x) {
            return 1; 
        }
        fib1 = fib2;
        fib2 = proximo;
        proximo = fib1 + fib2;
    }
    return 0; 
}

typedef struct {
    float teste, minis;
} Aluno;
// nao esta funcional
int moda(Aluno turma[], int N) {
    int negativa = 0;
    int positiva = 0;
    float temp =turma[0].teste * 0.8 + turma[0].minis * 0.2;
    for (int i = 1; i < N; i++) {
        float notaatual=turma[i].teste * 0.8 + turma[i].minis * 0.2;
        if(notaatual>=9,5){
            positiva++;
        }
      if (notaatual>temp){
       temp= turma[i].teste * 0.8 + turma[i].minis * 0.2 >= 9.5;
            }
         if(notaatual<9,5) {
            negativa++;
        }
    }
    if (negativa > positiva) {
        return 0;
    }
 return temp;
    
}
// Função iterativa para apagar todos os nós para além do n-ésimo
int take(int n, LInt *l) {
    int count = 0;
    LInt current = *l;
    LInt prev = NULL;

    // Percorrer até o n-ésimo nó
    while(n>0 && current!=NULL){
      prev = current;
        current = current->prox;
        n--;
    }

    // Se chegamos ao final da lista, não há nada para apagar
    if (current == NULL) {
        return count;
    }

    // Apagar os nós seguintes
    while (current != NULL) {
        current = current->prox;
        count++;
    }

    // Desconectar o n-ésimo nó da lista
    if (prev != NULL) {
        prev->prox = NULL;
    } else {
        *l = NULL;
    }

    return count;
}

int verifica(char frase[], int k) {
    int r = 0;

    for (int i = 0; frase[i] != '\0'; i++) {
        if (frase[i]== ' ') {
                r += 0; 
        } else if (isalpha(frase[i])) {
            r++;
        }
    }

    if (r >= k) {
        return 1; 
    } else {
        return 0; 
    }
}

//TESTE 2021

int procura(LInt *l, int x){

	while(*l->prox!=NULL){
	if((*l)->valor == x){
		LInt nova = malloc(sizeof(struct lligada));
		nova->valor = x;
		nova->prox = *l;
        return 1;
	} else {
        		l= &(*l)->prox;
    }}
	return 0;	  
}
int freeAB(ABin a){
	int r = 0;
	if(a==NULL)
		return r;
	else {
		r += 1 + freeAB(a->esq) + freeAB(a->dir);
		free(a);
	}
	return r;
}