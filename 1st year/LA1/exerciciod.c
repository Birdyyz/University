#include <stdio.h>
#include <string.h>


double tab[26] = {43.31, 10.56, 23.13, 17.25, 56.88, 9.24,
                    12.59, 15.31, 38.45, 1.00, 5.61, 27.98,
                    15.36, 33.92, 36.51, 16.14, 1.00, 38.64,
                    29.23, 35.43, 18.51, 5.13, 6.57, 1.48,
                    9.06, 1.39};


void calcularfrequencias(const char texto[], double frequencias[]) 
{    for (int i = 0; i < 26; i++) 
{
frequencias [i] = 0;
}
    int letras = 0;
    for (int i = 0; texto[i] != '\0'; i++) 
    {
        char c = texto[i];
        if (c >= 'A' && c <= 'Z')
         {
            frequencias[c - 'A']++;
            letras++;
        }
         else if (c >= 'a' && c <= 'z') 
        {
            frequencias[c - 'a']++;
            letras++;
        }
    }
    for (int i = 0; i < 26; i++) 
    {
        frequencias[i] /= letras;
    }
}
int encontrardeslocamento(double frequencias[])
 {
    int deslocamento = 0;
    double menor = 1e9;
    for (int i = 0; i < 26; i++)
     {
        double diferenca = 0.0;
        for (int j = 0; j < 26; j++)
         {
            int x = (j + i) % 26;
            diferenca += (frequencias[j] - tab[x]) * (frequencias[j] - tab[x]) / tab [x];
        }
        if (diferenca < menor) 
        {
            menor = diferenca;
            deslocamento = i;
        }
    }
    return deslocamento;
}
void decifrar(char texto[], int deslocamento)
 {
    for (int i = 0; texto[i] != '\0'; i++) 
    {
        char c = texto[i];
        if (c >= 'A' && c <= 'Z') 
        {
            printf("%c", ((c - 'A' + deslocamento) % 26) + 'A');
        }
        else if (c >= 'a' && c <= 'z') 
        {
            printf("%c", ((c - 'a' + deslocamento) % 26) + 'a');
        } 
        else 
        {
            printf("%c", c);
        }
    }
}
int main() 
{
    char texto_cifrado[10000];
     if (fgets(texto_cifrado, sizeof(texto_cifrado), stdin) != NULL) 
     {

    double frequencias[26];
    calcularfrequencias(texto_cifrado, frequencias);

    int deslocamento = encontrardeslocamento(frequencias);

    printf("%d ", deslocamento);
    decifrar(texto_cifrado, deslocamento);
     }
    return 0;
}
