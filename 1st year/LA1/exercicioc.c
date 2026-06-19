/*
Para nao esquecer o que faz
a mainaux verifica que os numeros sao iguais o que ajuda no calculo do expoente e da mantissa na main.
retorna 1(ideia de True) se for igual e retorna 0 (ideia de False) se for diferente
A main é a principal onde iremos atribuir os resultados e onde iremos realizar os calculos
*/


#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <math.h>

int mainaux(char s[], char x) 
{
    int i = 0;
    while (s[i] != '\0')
     {
        if (s[i] != x) 
        {
            return 0;
        }
        i++;
    }
    return 1;
}

int main() {
    int N;
    if (scanf("%d", &N) == 1) 
    {

        while (getchar() != '\n');

        for (int i = 0; i < N; i++) 
        {
            char buf[BUFSIZ];
            if (fgets(buf, BUFSIZ, stdin) != NULL) 
            {

                int E, M;
                char bits[BUFSIZ] = {0};
                if (sscanf(buf, "%d %d %s", &E, &M, bits) == 3)
                 {
                    if ((E >= 1 && E <= 5) && (M >= 1 && M <= 7))
                    {
                        char Sinal;
                        char Exp[BUFSIZ] = {0};
                        char Mant[BUFSIZ] = {0};
                        char formato[BUFSIZ];

                        sprintf(formato, "%%c%%%ds%%%ds", E, M);
                        if (sscanf(bits, formato, &Sinal, Exp, Mant) == 3) 
                        {

                            if (mainaux(Exp, '1') && mainaux(Mant, '0'))
                             {
                                if (Sinal == '0') 
                                {
                                    printf("+Infinity\n");
                                }
                                 else 
                                 {
                                    printf("-Infinity\n");
                                }
                            }
                             else if (mainaux(Exp, '1')) 
                            {
                                printf("NaN\n");

                            } 
                            else if (mainaux(Exp, '0') && mainaux(Mant, '0'))
                            {
                                if (Sinal == '0')
                                {
                                    printf("0\n");
                                }
                                 else 
                                 {
                                    printf("-0\n");
                                } 
                            } 
                            else if (mainaux(Exp, '0') && !mainaux(Mant, '0'))
                            {
                                double mantissa = 0.0;
                                for (int j = 0; j < M; j++) 
                                {
                                    if (Mant[j] == '1') {
                                        mantissa += 1.0 / pow(2, j + 1);
                                    }
                                }
                                double valor = pow(-1, Sinal - '0') * mantissa * pow(2, 1 - pow(2, (E - 1)));
                                valor *= 2;
                                printf("%lg\n", valor);

                            } 
                            else 
                            {
                                int expoente = 0;
                                for (int y = 0; y < E; y++) 
                                {
                                    expoente += (Exp[y] - '0') * pow(2, E - 1 - y);
                                }

                                double mantissa = 1.0;
                                for (int y = 0; y < M; y++) 
                                {
                                    if (Mant[y] == '1') {
                                        mantissa += 1.0 / pow(2, y + 1);
                                    }
                                }

                                double valor = pow(-1, Sinal - '0') * mantissa * pow(2, expoente - ((1 << (E - 1)) - 1));
                                printf("%lg\n", valor);
                                /*nao funcionava pow(2, 1 - pow(2, (E - 1))) entao nao esquecer do 
                                << é um deslocamento de bits para a esquerda. Isso desloca o bit 1 para a esquerda E - 1 vezes
                                site: https://www.geeksforgeeks.org/left-shift-right-shift-operators-c-cpp/
                                */
                            }
                        }
                    }
                }
            }
        }
    }
    return 0;
}
