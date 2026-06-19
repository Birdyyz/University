#include <stdio.h>
#include <wchar.h>
#include <locale.h>
#include <stdbool.h>
//usa deslocamento de bits 
// Função para extrair o valor da carta, obtem o ultimo bit de uma carta
int extrairvalor(wchar_t carta) {
    return (carta & 0xF); // Valor da carta
}
int extrairnaipe(wchar_t carta) {
    return (carta & 0xF0) / 16; // Aplica uma máscara para extrair os 4 bits do naipe e depois divide o resultado por 16
} 
int compararcartas(wchar_t carta1, wchar_t carta2) {
    int valor1 = extrairvalor(carta1);
    int valor2 = extrairvalor(carta2);

    if (valor1 > valor2) {
        return 1; // carta1 é maior
    } else if (valor1 < valor2) {
        return -1; // carta2 é maior
    } else { // Os valores das cartas são iguais, comparar naipes
        int naipe1 = extrairnaipe(carta1);
        int naipe2 = extrairnaipe(carta2);
        
        if (naipe1 > naipe2) {
            return 1; // naipe da carta1 é maior
        } else if (naipe1 < naipe2) {
            return -1; // naipe da carta2 é maior
        } else {
            return 0; // As cartas são iguais
        }
    }
}

// Função para ordenar as cartas na mão
void organizar(wchar_t mao[], int tamanho) {
    for (int i = 0; i < tamanho - 1; i++) {
        for (int j = 0; j < tamanho - i - 1; j++) {
            int atual = extrairvalor(mao[j]);
            int proximo = extrairvalor(mao[j + 1]);
            
            if (atual > proximo || (atual == proximo && mao[j] > mao[j + 1])) {
                wchar_t temp = mao[j];
                mao[j] = mao[j + 1];
                mao[j + 1] = temp;
            }
        }
    }

}

int consecutiva(wchar_t carta1, wchar_t carta2) {
    int s = 0;
    if ((extrairvalor(carta1) + 1) == (extrairvalor(carta2))) {
        s = 1;
    }
    return s;
}
// Função para verificar se todas as cartas têm o mesmo valor
int formamConjunto(wchar_t mao[], int tamanho) {
    for (int i = 0; i < tamanho - 1; i++) {
        if (extrairvalor(mao[i]) != extrairvalor(mao[i + 1])) {
            return 0; // Nem todas as cartas têm o mesmo valor
        }
    }
    return 1; // Todas as cartas têm o mesmo valor
}

// Função para verificar se as cartas formam uma sequência
// Função para verificar se as cartas formam uma sequência
int formamSequencia(wchar_t mao[], int tamanho) {
    // Verifica se há pelo menos 3 cartas para formar uma sequência
    if (tamanho < 3) {
        return 0;
    }

    for (int i = 0; i < tamanho - 1; i++) {
        if (!consecutiva(mao[i], mao[i + 1])) {
            return 0; // As cartas não formam uma sequência
        }
    }
    return 1; // As cartas formam uma sequência
}

// Função para verificar se as cartas formam uma dupla sequência
int formamDuplaSequencia(wchar_t mao[], int tamanho) {
    // Verifica se há pelo menos 6 cartas para formar uma dupla sequência
    if (tamanho < 6) {
        return 0;
    }

    // Verifica se há pares consecutivos com o mesmo valor
    for (int i = 0; i < tamanho - 3; i += 2) {
        if (extrairvalor(mao[i]) != extrairvalor(mao[i + 1])) {
            return 0; // Não há um par consecutivo de cartas com o mesmo valor
        }
    }

    // Verifica se as cartas restantes formam uma sequência
    for (int i = 0; i < tamanho - 3; i += 2) {
        if (!consecutiva(mao[i], mao[i + 2])) {
            return 0; // As cartas não formam uma sequência
        }
    }

    return 1; // As cartas formam uma dupla sequência
}

// Função para identificar o tipo de combinação de cartas
int tipocombinacoes(wchar_t mao[]) {
    int tamanho = wcslen(mao);
    organizar(mao, tamanho);

    if (tamanho == 1) {
        return 1; // Conjunto de uma carta
    }

    if (formamConjunto(mao, tamanho)) {
        return 1; // Conjunto
    }

    if (formamSequencia(mao, tamanho)) {
        return 2; // Sequência
    }

    if (formamDuplaSequencia(mao, tamanho)) {
        return 3; // Dupla sequência
    }

    return -1; // Não é nenhum tipo de combinação
}

void eliminaCarta(wchar_t mao[], wchar_t jogadapretendida[]) {
    // Percorre as cartas da jogada
    for (int i = 0; jogadapretendida[i] != L'\0'; i++) {
        // Percorre as cartas da mão
        for (int j = 0; mao[j] != L'\0'; j++) {
            // Se a carta da jogada for encontrada na mão
            if (jogadapretendida[i] == mao[j]) {
                // Elimina a carta da mão
                for (int k = j; mao[k] != L'\0'; k++) {
                    mao[k] = mao[k + 1];
                }
            }
        }
    }
}

void imprimirMao(wchar_t mao[]) {
    int tamanho = wcslen(mao);
    organizar(mao, tamanho);

    for (int i = 0; i < tamanho; i++) {
        wprintf(L"%lc", mao[i]); // Imprime a carta

        // Verifica se é a última carta
        if (i != tamanho - 1) {
            wprintf(L" "); // Imprime um espaço entre as cartas, exceto a última
        }
    }
    wprintf(L"\n");
}

//funcao auxiliar para contar a quantidade de cartas com o mesmo valor de uma carta específica
int contarCaracter(wchar_t *str, wchar_t valork) {
    int contador = 0;
    while (*str != L'\0') {
        if (extrairvalor(*str) == extrairvalor(valork)) {
            contador++;
        }
        str++;
    }
    return contador;
}

//funcao para verificar o caso especial do K
int casoK(wchar_t jogadaanterior[], wchar_t jogadaatual[], int tamanho2, wchar_t jogadasant[][20], int numjogant) {
    int r = 0;
    int passos = 0;
        for (int i = numjogant - 1; i >= 0 && i > numjogant - 4 && passos < 3; i--) {
            if (wcscmp(jogadasant[i], L"PASSO") == 0) {
                passos++;
            } else {
                wcscpy(jogadaanterior, jogadasant[i]);
            }
if (tipocombinacoes(jogadaanterior)==1){
    int numReisAnterior = contarCaracter(jogadaanterior, 0xE); // Conta os Reis na jogada anterior

    if (numReisAnterior == 1) {
        if ((tipocombinacoes(jogadaatual) == 1 && tamanho2 == 4) || (tipocombinacoes(jogadaatual) == 3 && tamanho2 == 6)) { 
            r = 1;
        }
    } else if (numReisAnterior == 2) {
        if (tipocombinacoes(jogadaatual) == 3 && tamanho2 == 8) {
            r = 1;
        }
    } else if (numReisAnterior == 3) {
        if (tipocombinacoes(jogadaatual) == 3 && tamanho2 == 10) {
            r = 1;
        }
            //  wprintf(L"quantidade de K: %d\n", numReisAnterior);

    } }
          else {
            r=0;
          }
        }
    return r;
}

//calcula a carta mais alta de uma mao, organiza e devolve o valor da ultima
int cartaMaisAlta(wchar_t mao[], wchar_t jogadaanterior[]) {
    int tamanho = wcslen(mao);
    organizar(mao, tamanho); 
    int tamanho1 = wcslen(jogadaanterior);
    organizar(jogadaanterior, tamanho1);
    
    // Inicializa as cartas mais altas como a primeira carta na mão e na jogada anterior
    wchar_t cartaMaisAltaMao = mao[0];
    wchar_t cartaMaisAltaJogadaAnterior = jogadaanterior[0];

    // Encontra a carta mais alta da mão
    for (int i = 1; i < tamanho; i++) {
        if (compararcartas(mao[i], cartaMaisAltaMao) >= 1) {
            cartaMaisAltaMao = mao[i];
        }
    }

    // Encontra a carta mais alta da jogada anterior
    for (int i = 0; i < tamanho1; i++) {
        if (compararcartas(jogadaanterior[i], cartaMaisAltaJogadaAnterior) >= 1) {
            cartaMaisAltaJogadaAnterior = jogadaanterior[i];
        }
    }

    // Compara as cartas mais altas
    if (compararcartas(cartaMaisAltaMao, cartaMaisAltaJogadaAnterior) >= 1) {
        return 1; // A carta mais alta da mão é maior
    } else {
        return 0; // A carta mais alta da jogada anterior é maior ou igual
    }
}


int jogadavalida(wchar_t jogadaanterior[], wchar_t jogadapretendida[], wchar_t jogadasant[][20], int numjogant) {
    int s = 0;
    int tppretendida = tipocombinacoes(jogadapretendida);

    if ((numjogant == 0) && (tppretendida != -1 || wcslen(jogadapretendida) == 1)) {
        s = 1;
    } 
          if (casoK(jogadaanterior, jogadapretendida, wcslen(jogadapretendida), jogadasant, numjogant)) {
            s = 1;
        }
        else {
        int passos = 0;
        for (int i = numjogant - 1; i >= 0 && i > numjogant - 4 && passos < 3; i--) {
            if (wcscmp(jogadasant[i], L"PASSO") == 0) {
                passos++;
            } else {
                wcscpy(jogadaanterior, jogadasant[i]);
            }
        }
        if (passos >= 3 && tppretendida != -1) {
            s = 1;
        }

        if (numjogant != 0) {
            if (wcslen(jogadapretendida) == wcslen(jogadaanterior) && (tipocombinacoes(jogadaanterior) == tppretendida && cartaMaisAlta(jogadapretendida,jogadaanterior)==1)) {
                s = 1;
            }
        }
             // wprintf(L"Tipo de combinação pretendida: %d\n", tppretendida);
              // int tpanterior = tipocombinacoes(jogadaanterior);
              // wprintf(L"Tipo de combinação anterior: %d\n", tpanterior);
    }
    return s;
}

int main() {
    setlocale(LC_ALL, "C.UTF-8");
    int num_testes, numjogant;
    wscanf(L"%d", &num_testes); // Lê o número de testes
    for (int teste = 1; teste <= num_testes; teste++) {
        wscanf(L"%d", &numjogant); // Lê o número de jogadas
        wchar_t mao[15]; // Assume que a mão não terá mais de 14 caracteres
        wscanf(L"%ls", mao); // Lê a mão
        wchar_t jogadasant[numjogant][20]; // Array para armazenar as jogadas anteriores
        for (int i = 0; i < numjogant; i++) {
            wscanf(L"%ls", jogadasant[i]); // Lê as jogadas anteriores
        }
        wchar_t ultimaJogadaAnterior[15];
        if (numjogant > 0) {
            wcscpy(ultimaJogadaAnterior, jogadasant[numjogant - 1]);
        }

        wprintf(L"Teste %d\n", teste);
        wchar_t jogadapretendida[15];
        wscanf(L"%ls", jogadapretendida); // Lê a jogada
     // wprintf(L"jogada jogadapretendida: %ls\n", jogadapretendida);
        if (jogadavalida(ultimaJogadaAnterior, jogadapretendida, jogadasant, numjogant) == 1) {
            eliminaCarta(mao, jogadapretendida);
          // wprintf(L"Última jogada anterior: %ls\n", ultimaJogadaAnterior); // se for válida imprime antes da mão
            imprimirMao(mao);
        } else {
            imprimirMao(mao);
          // wprintf(L"Última jogada anterior: %ls\n", ultimaJogadaAnterior); // quando a jogada não é válida imprime depois
        }
    }
    return 0;
}


/*
int extrairvalor(wchar_t carta) {
    return (carta & 0xF0) / 16;; 
}

int main() {
    wchar_t carta = L'\U0001F0D1';
        int valor = extrairvalor(carta);
    
    printf("O naipe da carta é: %d\n", valor);
    
    return 0;
}*/