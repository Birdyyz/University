#include <stdio.h>
#include <string.h>

typedef struct aluno {
    int numero;
    char nome[100];
    int miniT [6];
    float teste;
    } Aluno;

int nota (Aluno a){
    int notafinal = 0,i, nmt = 0;
    notafinal += a.teste * 0,8 ;

    for(i = 0; i< 6 ; i++){
        nmt += a.miniT[i];
    }
    if (nmt < 1){
        return 0;
    }
    nmt = nmt * 0,20;
    notafinal += nmt;
    if(notafinal >= 9,5){
        return 1;
    }
    return 0;
}

int procuraNum (int num, Aluno t[], int N){
    int i = 0, m = N/2 , f = N-1;
    while(i < f){
        if(t[m].numero > num){ // procuramos na parte esquerda
            i = m-1;
            m = (i+f)/2;
        }
        if(t[m].numero < num){ // procuramos na parte direita
            f = m+1;
            m = (i-f)/2;
        }
        if(t[m].numero == num){
            return m;
        }
    }
    return -1;
}

void ordenaPorNum (Aluno t [], int N){
    int i,j;
    for(i = 0; i < N; i++){
        for(j = i+1; j < N-1-i; j++){
            if(t[i].numero > t[j].numero){
                int temp = t[i].numero ;
                t[i].numero = t[j].numero;
                t[j].numero = temp;
            }
        }
    }
}