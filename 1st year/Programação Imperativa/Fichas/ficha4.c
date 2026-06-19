#include <stdio.h>
#include <string.h>
int isvowel(char s){
    if(s == ('a'||'e'||'i'||'o'||'u'||'A'||'E'||'I'||'O'||'U')){
        return 1;
    }
    return 0;
}

int contaVogais (char *s){
        int resultado = 0;
    for(int i = 0; s[i] != '\0' ; i++){
        if (isvowel(s[i])){
            resultado++;
        }
    }
    return resultado;
}


int retiraVogaisRep (char *s){
    char p[strlen(s)];
    int n = 0;
    for(int i = 0; s[i] != '\0' ; i++){
            if (isvowel(s[i]) || s[i] != s[i+1]){
                p[n] = s[i];
                n++;
            }
        }
    p[n] = '\0';
    strcopy(s,p);
    return i-n;
}
int duplicaVogais (char *s){
    char p[2*strlen(s)];
    int res = 0;
    for(int i = 0; s[i] != '\0' ; i++){
        if (isvowel(s[i])){
            p[n] = s[i];
            p[n++] = s[i];
            n++;
            res++;
        }
        else{
            p[n] = s[i];
            n++;
        }
    }
    p[n] = '\0';
    return res;
}

int ordenado (int v[], int N){
    for (int i = 0; i < N-1 ; i++){
            if (v[i] > v[i+1]){
                return 0;
            }
        }
    return 1;
}

void merge(int a[], int na, int b[], int nb, int r[]) {
    int i = 0, j = 0, n = 0;
    while (i < na && j < nb) {
        if (a[i] < b[j]) {
            r[n++] = a[i++];
        } else {
            r[n++] = b[j++];
        }
    }
    while (i < na) {
        r[n++] = a[i++];
    }
    while (j < nb) {
        r[n++] = b[j++];
    }
}

int partition (int v[], int N, int x){
    int aux[N];
    int n = 0;
    int fim = N-1;
    for(int i = 0; i < N ; i++){
        if(v[i] <= x){
            aux[n] = v[i];
            n++;
        }
        else{
            aux[fim] = v[i];
            fim--;
        }
    }
    for(i = 0; i<N;i++){
        v[i] = aux[i];
    }
}

int main(){   
    char s1 [100] = "Estaa e umaa string coom duuuplicadoos";
    int x;
    
    printf ("Testes\n");
    printf ("A string \"%s\" tem %d vogais\n", s1, contaVogais (s1));
    
    x = retiraVogaisRep (s1);
    printf ("Foram retiradas %d vogais, resultando em \"%s\"\n", x, s1);
 /*
    x = duplicaVogais (s1);
    printf ("Foram acrescentadas %d vogais, resultando em \"%s\"\n", x, s1);
   */    
    printf ("\nFim dos testes\n");

    return 0;
}