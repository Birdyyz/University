#include <stdio.h>
#include <wchar.h>
#include <stdlib.h>
#include <locale.h>

#define ESPADASMIN 0x1F0A1
#define ESPADASMAX 0x1F0AE
#define COPASMIN 0x1F0B1
#define COPASMAX 0x1F0BE
#define OUROSMIN 0x1F0C1
#define OUROSMAX 0x1F0CE
#define PAUSMIN 0x1F0D1
#define PAUSMAX 0x1F0DE

int extrairnaipe(wchar_t carta) {
    int naipe;
    if (carta >= ESPADASMIN && carta <= ESPADASMAX) {
        naipe = 0;
    } else if (carta >= COPASMIN && carta <= COPASMAX) {
        naipe = 1;
    } else if (carta >= OUROSMIN && carta <= OUROSMAX) {
        naipe = 2;
    } else {
        naipe = 3;
    }
    return naipe;
}
//Portanto, ao preservar apenas os quatro bits menos significativos, garantimos que o resultado estará dentro do intervalo de 0 a 15.
int extrairvalor(wchar_t carta) {
    return (carta & 0xF); // Valor da carta
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
        } else if (naipe1 > naipe2) {
            return -1; // naipe da carta2 é maior
        } else {
            return 0; // As cartas são iguais
        }
    }
}

void ordenarcartas(wchar_t cartas[], size_t tamanho) {
    for (size_t i = 0; i < tamanho - 1; i++) {
        for (size_t j = 0; j < tamanho - i - 1; j++) {
            if (compararcartas(cartas[j], cartas[j + 1]) > 0) {
                wchar_t temp = cartas[j];
                cartas[j] = cartas[j + 1];
                cartas[j + 1] = temp;
            }
        }
    }
}
//Conjunto: de uma até quatro cartas todas com o *mesmo valor* mas de naipes diferentes;
int verificarconjunto(const wchar_t baralho[], size_t tamanho) {
    int valor1 = extrairvalor(baralho[0]);
    for (size_t i = 0; i < tamanho; i++) {
        if (extrairvalor(baralho[i]) != valor1) {
            return 0; 
        }
    }
    return 1; 
}
//Sequência: de três ou mais cartas de *valores* consecutivos (não necessariamente todas do mesmo naipe);
int verificarsequencia(const wchar_t baralho[], size_t tamanho) {
    if (tamanho < 3) {
        return 0; 
    }
    for (size_t i = 1; i < tamanho; i++) {
        if (extrairvalor(baralho[i]) != extrairvalor(baralho[i - 1]) + 1) {
            return 0; 
        }
    }
    return 1;
}
//Dupla sequência: de três ou mais pares de valores consecutivos.
int verificarduplasequencia(const wchar_t baralho[], size_t tamanho) {
    if (tamanho < 6 || tamanho % 2 != 0) {
        return 0; 
    }
    for (size_t i = 0; i < tamanho; i += 2) {
        if (extrairvalor(baralho[i]) != extrairvalor(baralho[i + 1])) {
            return 0; 
        }
    }
    return 1; 
}

void combinacoes(wchar_t baralho[], size_t tamanho, wchar_t cartamaisalta) {
    if (verificarconjunto(baralho, tamanho)) {
        wprintf(L"conjunto com %zu cartas onde a carta mais alta é %lc\n", tamanho, cartamaisalta);
    } 
    else if (verificarsequencia(baralho, tamanho)) {
        wprintf(L"sequência com %zu cartas onde a carta mais alta é %lc\n", tamanho, cartamaisalta);
    }
    else if (verificarduplasequencia(baralho, tamanho)) {
        wprintf(L"dupla sequência com %zu cartas onde a carta mais alta é %lc\n", tamanho / 2, cartamaisalta);
    }
    else {
        wprintf(L"Nada!\n");
    }
}
int main() {
    int T;
    setlocale(LC_CTYPE, "C.UTF-8");
    if (wscanf(L"%d", &T) == 1) {
        fgetwc(stdin); // Consumir o caractere de nova linha após a leitura de T

        for (int i = 0; i < T; i++) {
            wchar_t baralho[BUFSIZ];

            if (fgetws(baralho, BUFSIZ, stdin) != NULL) {
                // Remover o caractere de nova linha do buffer
                wchar_t *novalinha = wcschr(baralho, L'\n');
                if (novalinha != NULL) {
                    *novalinha = L'\0';
                }

                size_t tamanho = wcslen(baralho);
                wchar_t cartamaisalta = baralho[0]; //primeira carta é a mais alta inicialmente

                for (size_t j = 1; baralho[j] != L'\0'; j++) {
                    if (compararcartas(baralho[j], cartamaisalta) > 0) {
                        cartamaisalta = baralho[j];
                    }
                }

                // Ordenar o array de cartas
                ordenarcartas(baralho, tamanho);

                combinacoes(baralho, tamanho, cartamaisalta);
            }
        }
    }

    return 0;
}