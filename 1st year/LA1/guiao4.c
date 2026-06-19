#include <stdio.h>
#include <wchar.h>
#include <locale.h>
#include <stdlib.h>

#define MAX_CONJUNTOS 1000
#define MAX_CONJUNTOS4 1000
int extrairvalor(wchar_t carta) {
    return (carta & 0xF);
}
int extrairnaipe(wchar_t carta) {
    return (carta & 0xF0) / 16;
}
int compararcartas(wchar_t carta1, wchar_t carta2) {
    int valor1 = extrairvalor(carta1);
    int valor2 = extrairvalor(carta2);

    if (valor1 > valor2) {
        return 1;
    } else if (valor1 < valor2) {
        return -1;
    } else {
        int naipe1 = extrairnaipe(carta1);
        int naipe2 = extrairnaipe(carta2);
        
        if (naipe1 > naipe2) {
            return 1;
        } else if (naipe1 < naipe2) {
            return -1;
        } else {
            return 0;
        }
    }
}
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
int tipocombinacoes(wchar_t mao[]) {
    int tamanho = wcslen(mao);
    organizar(mao, tamanho); 

    if (tamanho == 1) {
        return 1;
    }

    for (int i = 0; i < tamanho - 1; i++) {
        if (extrairvalor(mao[i]) == extrairvalor(mao[i + 1])) {
            if (i + 2 < tamanho && consecutiva(mao[i], mao[i + 2]) && tamanho >= 6) {
                return 3;
            } else {
                return 1;
            }
        } else {
            if (consecutiva(mao[i], mao[i + 1]) && tamanho >= 3) {
                return 2;
            } else {
                return -1;
            }
        }
    }
    return -1;
}
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

//Conjuntos normais (sem caso K)
void encontrarconjuntos(wchar_t mao[], int tamanho, wchar_t conjuntos_encontrados[][14], int *num_conjuntos, wchar_t conjunto[], int tamanhoconjunto, int posicao, int tamanhoant, int naipeCartaMaisAlta, int valorCartaMaisAlta) {
    if (tamanhoconjunto == tamanhoant) {
        if((extrairvalor(conjunto[tamanhoconjunto-1]) == valorCartaMaisAlta && extrairnaipe(conjunto[tamanhoconjunto-1])<naipeCartaMaisAlta) ){
            return;
        } else {
            for (int i = 0; i < tamanhoant; i++) {
                conjuntos_encontrados[*num_conjuntos][i] = conjunto[i];
            }
            (*num_conjuntos)++;
            return;
        }
    }
    for (int i = posicao; i < tamanho; i++) {
        if (extrairvalor(mao[i]) == extrairvalor(conjunto[0]) && (extrairnaipe(mao[i]) != extrairnaipe(conjunto[0]))) { //comparar a carta que queremos adicionar com a que já temos
            conjunto[tamanhoconjunto++] = mao[i];
            encontrarconjuntos(mao, tamanho, conjuntos_encontrados, num_conjuntos, conjunto, tamanhoconjunto, i + 1, tamanhoant, naipeCartaMaisAlta, valorCartaMaisAlta);
            tamanhoconjunto--;
        }
    }
}

void criaconjuntos(wchar_t mao[], int tamanho, wchar_t jogadaanterior[], wchar_t conjuntos_encontrados[][14], int *num_conjuntos, int tamanhoant) {
    int valorCartaMaisAlta= extrairvalor(jogadaanterior[tamanhoant-1]);
    int naipeCartaMaisAlta= extrairnaipe(jogadaanterior[tamanhoant-1]);

    for (int i = 0; i < tamanho; i++) {
        if ((extrairvalor(mao[i])>valorCartaMaisAlta) || ( (extrairvalor(mao[i])== valorCartaMaisAlta && extrairnaipe(mao[i])>naipeCartaMaisAlta ) ) || ( (extrairvalor(mao[i])== valorCartaMaisAlta && extrairnaipe(mao[i])<naipeCartaMaisAlta)) ) {
            wchar_t conjunto[4];
            conjunto[0] = mao[i];
            int tamanho_conjunto = 1;
            encontrarconjuntos(mao, tamanho, conjuntos_encontrados, num_conjuntos, conjunto, tamanho_conjunto, i + 1, tamanhoant, naipeCartaMaisAlta, valorCartaMaisAlta);
        }
    }
}

void imprimir_conjuntos(wchar_t conjuntos_encontrados[][14], int num_conjuntos) {
        for (int i = 0; i < num_conjuntos; i++) {
            int comprimentoconjuntos = wcslen(conjuntos_encontrados[i]);
            for (int j = 0; j < comprimentoconjuntos; j++) {
                wprintf(L"%lc", conjuntos_encontrados[i][j]);
                if (j < comprimentoconjuntos - 1) {
                    wprintf(L" ");
                }
            }
            wprintf(L"\n");
        }
    }

//Conjunto para responder a um K
void imprimir_conjuntos4(wchar_t conjuntos[][4], int num_conjuntos4){
    for (int i = num_conjuntos4 - 1; i >= 0; i--) { 
        for (int j = 0; j < 4; j++) {
            wprintf(L"%lc", conjuntos[i][j]);
            if (j != 3) {
                wprintf(L" "); // Imprime um espaço entre as cartas, exceto a última
            }
        }
        wprintf(L"\n");
    }
}

void criarConjunto4(wchar_t mao[], int tamanho, wchar_t conjuntos4[][4], int *num_conjuntos4) {
    for (int i = tamanho - 1; i >= 0; i--) { // Começa da última carta e anda para trás
        if (i >= 3 && extrairvalor(mao[i]) == extrairvalor(mao[i - 1]) &&
            extrairvalor(mao[i]) == extrairvalor(mao[i - 2]) &&
            extrairvalor(mao[i]) == extrairvalor(mao[i - 3])) {
            conjuntos4[*num_conjuntos4][0] = mao[i - 3];
            conjuntos4[*num_conjuntos4][1] = mao[i - 2];
            conjuntos4[*num_conjuntos4][2] = mao[i - 1];
            conjuntos4[*num_conjuntos4][3] = mao[i]; 
            (*num_conjuntos4)++; 
            i -= 3; 
        }
    } // Imprimir os conjuntos de tamanho 4
}


//Sequencias
void imprimesequencia(wchar_t mao[], int indices[], int tamanhoSequencia) {
    // Imprime a dupla sequência atual
    for (int i = 0; i < tamanhoSequencia; i += 1) {
        wprintf(L"%lc", mao[indices[i]]);
        if (i != tamanhoSequencia - 1) {
            wprintf(L" ");
        }
    }
    wprintf(L"\n");
}

void criasequencias(wchar_t mao[], int tamanho, int tamanhoSequencia, wchar_t cartaMaisAlta, int *encontradoSeq,int indices[14]) {
    int i, j;
    // Inicializa os índices
    for (i = 0; i < tamanhoSequencia; i++) {
        indices[i] = i;
    }
    // Loop para gerar e imprimir todas as sequências possíveis
    int r = 0;
    while (!r) {
        // Verifica se a sequência é válida
        int sequenciaValida = 1;
        for (i = 0; i < tamanhoSequencia - 1; i++) {
            if (!consecutiva(mao[indices[i]], mao[indices[i + 1]])) {
                sequenciaValida = 0;
            }
        }
        
        // Se a sequência for válida e maior que a última jogada, imprime
        if (sequenciaValida && (extrairvalor(mao[indices[tamanhoSequencia - 1]]) > extrairvalor(cartaMaisAlta) || (extrairvalor(mao[indices[tamanhoSequencia - 1]]) == extrairvalor(cartaMaisAlta) && extrairnaipe(mao[indices[tamanhoSequencia - 1]]) > extrairnaipe(cartaMaisAlta)))) {
            imprimesequencia(mao, indices, tamanhoSequencia);
            if (encontradoSeq != NULL) {
                *encontradoSeq = 1; // Define a variável encontradoDupSeq como verdadeira se uma dupla sequência for encontrada
            }
        }

        // Encontra o próximo índice a ser incrementado
        i = tamanhoSequencia - 1;
        while (i >= 0 && indices[i] == tamanho - (tamanhoSequencia - i)) {
            i--;
        }
        if (i < 0) {
            r = 1;
        } else {
            indices[i]++;
            // Atualiza os índices seguintes
            for (j = i + 1; j < tamanhoSequencia; j++) {
                indices[j] = indices[j - 1] + 1;
            }
        }
    }
}


//Dupla sequencia 

void imprimeduplasequencia(wchar_t mao[], int indices[], int tamanhoDupSequencia) {
    // Imprime a dupla sequência atual
    for (int i = 0; i < tamanhoDupSequencia; i += 2) {
        wprintf(L"%lc %lc", mao[indices[i]], mao[indices[i + 1]]);
        if (i != tamanhoDupSequencia - 2) {
            wprintf(L" ");
        }
    }
    wprintf(L"\n");
}

void criaduplasequencias(wchar_t mao[], int tamanho, int tamanhoDupSequencia, wchar_t cartaMaisAlta, int *encontradoDupSeq,int indices[14]) {
    
    int i, j;

    // Inicializa os índices
    for (i = 0; i < tamanhoDupSequencia; i++) {
        indices[i] = i;
    }
    // Loop para gerar e imprimir todas as duplas sequências possíveis
    int r = 0;
    while (!r) {
        // Verifica se a dupla sequência é válida
        int dupsequenciaValida = 1;
        for (i = 0; i < tamanhoDupSequencia - 3; i += 2) {
            if (!consecutiva(mao[indices[i]], mao[indices[i + 2]]) ||
                extrairvalor(mao[indices[i]]) != extrairvalor(mao[indices[i + 1]]) ||
                extrairvalor(mao[indices[i + 2]]) != extrairvalor(mao[indices[i + 3]])) {
                dupsequenciaValida = 0;
            }
        }
        
        // Se a dupla sequência for válida e maior que a última jogada, imprime
        if (dupsequenciaValida &&
            (extrairvalor(mao[indices[tamanhoDupSequencia - 1]]) > extrairvalor(cartaMaisAlta) ||
            (extrairvalor(mao[indices[tamanhoDupSequencia - 1]]) == extrairvalor(cartaMaisAlta) &&
            extrairnaipe(mao[indices[tamanhoDupSequencia - 1]]) > extrairnaipe(cartaMaisAlta)))) {
            imprimeduplasequencia(mao, indices, tamanhoDupSequencia);
            if (encontradoDupSeq != NULL) {
                *encontradoDupSeq = 1; // Define a variável encontradoDupSeq como verdadeira se uma dupla sequência for encontrada
            }
        }

        // Encontra o próximo índice a ser incrementado
        i = tamanhoDupSequencia - 1;
        while (i >= 0 && indices[i] == tamanho - (tamanhoDupSequencia - i)) {
            i--;
        }
        if (i < 0) {
            r = 1;
        } else {
            indices[i]++;
            // Atualiza os índices seguintes
            for (j = i + 1; j < tamanhoDupSequencia; j++) {
                indices[j] = indices[j - 1] + 1;
            }
        }
    }
}

//Duplas sequencias para caso K
void criaduplasequenciasK(wchar_t mao[], int tamanho, int tamanhoDupSequencia, int *encontradoDupSeq,int indices[14]) {
    
    int i, j;

    // Inicializa os índices
    for (i = 0; i < tamanhoDupSequencia; i++) {
        indices[i] = i;
    }
    // Loop para gerar e imprimir todas as duplas sequências possíveis
    int r = 0;
    while (!r) {
    // Verifica se a dupla sequência é válida
    int dupsequenciaValida = 1;
    for (i = 0; i < tamanhoDupSequencia - 3; i += 2) {
        if (!consecutiva(mao[indices[i]], mao[indices[i + 2]]) ||
            extrairvalor(mao[indices[i]]) != extrairvalor(mao[indices[i + 1]]) ||
            extrairvalor(mao[indices[i + 2]]) != extrairvalor(mao[indices[i + 3]])) {
            dupsequenciaValida = 0;
        }
    }

    if (dupsequenciaValida) {
        imprimeduplasequencia(mao, indices, tamanhoDupSequencia);
        if (encontradoDupSeq != NULL) {
            *encontradoDupSeq = 1;
        }
    }

    i = tamanhoDupSequencia - 1;
    // Verifica se `i` não ultrapassa o tamanho máximo permitido
    while (i >= 0 && indices[i] >= tamanho - (tamanhoDupSequencia - i)) {
        i--;
    }
    if (i < 0) {
        r = 1;
    } else {
        indices[i]++;
        for (j = i + 1; j < tamanhoDupSequencia; j++) {
            indices[j] = indices[j - 1] + 1;
        }
    }
}
}


//Caso K


void casoKAux2K(wchar_t mao[], int tamanhoMao, int indices[14], int *num_conjuntos){
        int encontradoDupSeq = 0;
        criaduplasequenciasK(mao, tamanhoMao, 8, &encontradoDupSeq, indices);

        if (!encontradoDupSeq && *num_conjuntos == 0 ) {
            wprintf(L"PASSO\n");
        }
}

void casoKAux3K(wchar_t mao[], int tamanhoMao, int indices[14]){
        int encontradoDupSeq = 0;
        criaduplasequenciasK(mao, tamanhoMao, 10, &encontradoDupSeq, indices);

        if (!encontradoDupSeq) {
            wprintf(L"PASSO\n");
        }
}

void casoKconjuntos(wchar_t ultimaJogada[], wchar_t mao[], int tamanhoMao, int numReis, wchar_t conjuntos_encontrados[][14], int *num_conjuntos, int tamanhoant,  wchar_t conjuntos4[][4],int *num_conjuntos4,int indices[14]) {
    int numReisMao= contarCaracter(mao, 0xE);
    if (numReis == 1) {
        if(numReisMao>=1){
            criaconjuntos(mao, tamanhoMao, ultimaJogada, conjuntos_encontrados, num_conjuntos, tamanhoant);
            imprimir_conjuntos(conjuntos_encontrados, *num_conjuntos);
        } 
        criarConjunto4(mao, tamanhoMao, conjuntos4, num_conjuntos4);
        imprimir_conjuntos4(conjuntos4, *num_conjuntos4);
        int encontradoDupSeq = 0;
        criaduplasequenciasK(mao, tamanhoMao, 6, &encontradoDupSeq, indices);

        if (!encontradoDupSeq && *num_conjuntos4 == 0 && *num_conjuntos == 0 ) {
            wprintf(L"PASSO\n");
        }
    } else if (numReis == 2) {
        if(numReisMao==2){
            criaconjuntos(mao, tamanhoMao, ultimaJogada, conjuntos_encontrados, num_conjuntos, tamanhoant); //conjuntos de tamanho = tamanhoant
            imprimir_conjuntos(conjuntos_encontrados, *num_conjuntos);
        }
        casoKAux2K(mao,tamanhoMao,indices, num_conjuntos);
    }else if (numReis == 3) {
        casoKAux3K(mao,tamanhoMao,indices);
    } else if (numReis >= 4) {
     wprintf(L"PASSO\n");
    }
}


//Main menor
void criasemK (wchar_t mao[], int tamanhoMao,wchar_t ultimaJogada[], int tamanhoJogadaAnterior){
    wchar_t conjuntos_encontrados[MAX_CONJUNTOS][14];
    int num_conjuntos = 0;
    int indices[14];
    int encontradoDupSeq=0;
    int encontradoSeq=0;
    if (tipocombinacoes(ultimaJogada) == 1) {
        criaconjuntos(mao, tamanhoMao, ultimaJogada, conjuntos_encontrados, &num_conjuntos, tamanhoJogadaAnterior);
        if (num_conjuntos == 0) {
            wprintf(L"PASSO\n");
        } else {
            imprimir_conjuntos(conjuntos_encontrados, num_conjuntos);
        }
    } 
    else if (tipocombinacoes(ultimaJogada) == 2){
          criasequencias(mao, tamanhoMao,tamanhoJogadaAnterior,ultimaJogada[tamanhoJogadaAnterior-1],&encontradoSeq,indices);
          if (!encontradoSeq) {
            wprintf(L"PASSO\n");
        }
    }
    else if (tipocombinacoes(ultimaJogada) == 3){
          criaduplasequencias(mao, tamanhoMao,tamanhoJogadaAnterior,ultimaJogada[tamanhoJogadaAnterior-1],&encontradoDupSeq,indices);
          if (!encontradoDupSeq) {
            wprintf(L"PASSO\n");
        }
    } 
}
void cria(wchar_t mao[],wchar_t ultimaJogada[], int tamanhoJogadaAnterior){
    wchar_t conjuntos_encontrados[MAX_CONJUNTOS][14];
    wchar_t conjuntos4[MAX_CONJUNTOS4][4];
    int num_conjuntos = 0;
    int num_conjuntos4 = 0;
    int indices[14];
    int encontradoDupSeq=0;
    int encontradoSeq=0;
    int numReis = contarCaracter(ultimaJogada, 0xE); //conta quantos reis existem na ultima jogada
    int tamanhoMao= wcslen(mao);
    if (numReis != 0) {
        if(tipocombinacoes(ultimaJogada)==1){ //Caso K
            casoKconjuntos(ultimaJogada, mao,tamanhoMao, numReis, conjuntos_encontrados, &num_conjuntos, tamanhoJogadaAnterior,conjuntos4, &num_conjuntos4, indices);
        }
        else if(tipocombinacoes(ultimaJogada)==2){ //Sequencia
            criasequencias(mao, tamanhoMao,tamanhoJogadaAnterior,ultimaJogada[tamanhoJogadaAnterior-1],&encontradoSeq,indices);
            if (!encontradoSeq) {
            wprintf(L"PASSO\n");
        }
        }
        else if(tipocombinacoes(ultimaJogada)==3){ //Dupla sequencia
            criaduplasequencias(mao, tamanhoMao,tamanhoJogadaAnterior,ultimaJogada[tamanhoJogadaAnterior-1],&encontradoDupSeq,indices);
          if (!encontradoDupSeq) {
            wprintf(L"PASSO\n");
        }
        }
    }
    if (numReis==0){
    criasemK(mao,tamanhoMao,ultimaJogada,tamanhoJogadaAnterior);
    }
}

int main() {
    setlocale(LC_ALL, "C.UTF-8");
    int num_testes;
    wscanf(L"%d", &num_testes); 
    
    for (int teste = 1; teste <= num_testes; teste++) {
        wchar_t ultimaJogada[14];
        wscanf(L"%ls", ultimaJogada); 
        int tamanhoJogadaAnterior = wcslen(ultimaJogada);
        organizar(ultimaJogada, tamanhoJogadaAnterior);
        wchar_t mao[56]; 
        wscanf(L"%ls", mao); 
        organizar(mao, wcslen(mao));
        wprintf(L"Teste %d\n", teste);
        cria(mao,ultimaJogada,tamanhoJogadaAnterior);
    }
    return 0;
}
