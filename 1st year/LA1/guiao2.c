#include <stdio.h>
#include <wchar.h>
#include <locale.h>

// Função para extrair o valor da carta
int extrairvalor(wchar_t carta) {
    return (carta & 0xF); // Valor da carta
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

// Função para trocar duas cartas de posição
void trocar(wchar_t *a, wchar_t *b) {
    wchar_t temp[30];
    wcscpy(temp, a);
    wcscpy(a, b);
    wcscpy(b, temp);
}

// Função de partição para o algoritmo quicksort, tipo a da aula com o jbb, para ordenar as combinacoes
int partition(wchar_t combinacoes[][30], int primeiro, int ultimo, int tamanho) {
    wchar_t max[30];
    // vamos copiar a ultima jogada para o array max
    wcscpy(max, combinacoes[ultimo]);
    int i = primeiro - 1; // se quickSort nao fosse recursivo isto teria sempre o mesmo valor

    for (int j = primeiro; j <= ultimo - 1; j++) {
        // Compara o valor da última carta da combinação atual com a última carta do max para saber se é menor
        if (extrairvalor(combinacoes[j][tamanho - 1]) < extrairvalor(max[tamanho - 1]) ||
            (extrairvalor(combinacoes[j][tamanho - 1]) == extrairvalor(max[tamanho - 1]) &&
             combinacoes[j][tamanho - 1] < max[tamanho - 1])) {//estamos a comparar o valor e naipe juntos, compara os naipes
            i++;
            // se a atual for menor coloca a atual antes do max, compara as combinacoes
            trocar(combinacoes[i], combinacoes[j]);
        }
    }
    //se for maior
    trocar(combinacoes[i + 1], combinacoes[ultimo]);
    return i + 1;
}

// Função de ordenação quicksort para combinações
// o int ultimo é numcombinacoes - 1, a ultima combinacao encontrada
// o int primeiro é 0, a primeira combinação encontrada
void quickSort(wchar_t combinacoes[][30], int primeiro, int ultimo, int tamanho) {
    // chama recursivamente, quando parar é pq chegou a 0 e ja estao ordenadas
    if (primeiro < ultimo) {
        int dividir = partition(combinacoes, primeiro, ultimo, tamanho);
        quickSort(combinacoes, primeiro, dividir - 1, tamanho);
        quickSort(combinacoes, dividir + 1, ultimo, tamanho);
    }
}

// Função para classificar as combinações
void ordenar(wchar_t combinacoes[][30], int numcombinacoes, int tamanho) {
    quickSort(combinacoes, 0, numcombinacoes - 1, tamanho);
}

// Função para verificar se duas cartas são consecutivas
int consecutiva(wchar_t carta1, wchar_t carta2) {
    int s = 0;
    if ((extrairvalor(carta1) + 1) == (extrairvalor(carta2))) {
        s = 1;
    }
    return s; 
}

// Função para verificar o tipo de combinações
int tipocombinacoes(wchar_t mao[]) {
    int tamanho = wcslen(mao);

    for (int i = 0; i < tamanho - 1; i++) {
        // Verificar se duas cartas consecutivas têm o mesmo valor
        if (extrairvalor(mao[i]) == extrairvalor(mao[i + 1])) {
            // Se tiverem o mesmo valor, verifica se há uma sequência consecutiva de cartas
            if (i + 2 < tamanho && consecutiva(mao[i], mao[i + 2]) && tamanho >= 6) {
                return 3; //Dupla sequência: de três ou mais pares de valores consecutivos.
            } else {
                return 1; //Conjunto: de uma até quatro cartas todas com o *mesmo valor* mas de naipes diferentes;
            }
        } else {
            // Se não, verifica se há uma sequência consecutiva de cartas
            if (consecutiva(mao[i], mao[i + 1]) && tamanho >= 3) {
                return 2; //Sequência: de três ou mais cartas de *valores* consecutivos (não necessariamente todas do mesmo naipe);
            } else {
                return -1; // Não é nenhum tipo de combinação
            }
        }
    }
    return -1; // Não é nenhum tipo de combinação
}


// Função para imprimir as combinações
void imprimircombinacoes(wchar_t arraycomb[][30], int k, int tamanho) {
    // Ordena as combinações antes de imprimir
    // nao era preciso ordenar novamente, na funcao processarTeste ja esta a ordenar antes de chamar
    ordenar(arraycomb, k, tamanho);
    
    for (int i = 0; i < k; i++) {
        // Imprime cada carta da combinação
        for (int j = 0; j < tamanho; j++) {
            if (j > 0) wprintf(L" ");
            wprintf(L"%lc", arraycomb[i][j]);
        }
        wprintf(L"\n");
    } 
}

void processarTeste(int teste) {
    wprintf(L"Teste %d\n", teste);
        
    int num_combinacoes;
    wscanf(L"%d", &num_combinacoes);
    
    wchar_t comb[num_combinacoes][30];
    int tamanhos[num_combinacoes];
    
    // Receber e ordenar as combinações
    for (int i = 0; i < num_combinacoes; i++) {
        wscanf(L"%ls", comb[i]);
        tamanhos[i] = wcslen(comb[i]);
        // vai organizar as cartas do array
        organizar(comb[i], tamanhos[i]);
    }
    
    // Verificar se têm a mesma combinacao e o mesmo comprimento
    int comb_tipo_base = tipocombinacoes(comb[0]);
    int comb_tamanho_base = tamanhos[0];
    int comb_valida = 1;
    
    for (int i = 1; i < num_combinacoes; i++) {
        // se as compinacoes a comparar forem diferentes nao é válida
        if (tamanhos[i] != comb_tamanho_base || tipocombinacoes(comb[i]) != comb_tipo_base) {
            comb_valida = 0;
            break;
        }
    }
    
    // Se for da mesma combinacao
    if (comb_valida) {
        // Ordena as combinações de mãos com base no valor da primeira e ultima carta
        //cartas de cada combinação e, em caso de valores iguais, pelos códigos dos caracteres.
        ordenar(comb, num_combinacoes, comb_tamanho_base);
        imprimircombinacoes(comb, num_combinacoes, comb_tamanho_base);
    } else {
        wprintf(L"Combinações não iguais!\n");
    }
}

int main() {
    setlocale(LC_ALL, "C.UTF-8");
    int T;
    wscanf(L"%d", &T);

    for (int i = 0; i < T; i++) {
        processarTeste(i + 1);
    }

    return 0;
}
