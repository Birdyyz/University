#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void processar(char *linha) {
    int E, M;
    char bits[BUFSIZ] = {0};
    sscanf(linha, "%d %d %s", &E, &M, bits);

    if (E == 111 && M == 0) {
        printf("-Infinity\n");
    } else if (E == 0 && M != 1111) {
        printf("NaN\n");
    } else {
        int exp = 0;
        for (int i = 0; i < M; i++) {
            exp += (bits[E + i] - '0') * (1 << (M - i - 1)); 
        }
        if (exp == 0) {
            printf("-Infinity\n");
        } else {
            printf("+Infinity\n");
        }
    }
}

int main() {
    char buf[BUFSIZ];
    int num_testes;
    

    assert(scanf("%d ", &num_testes) == 1);

    for (int i = 0; i < num_testes; i++) {
        assert(fgets(buf, BUFSIZ, stdin) != NULL);
        assert(buf[strlen(buf) - 1] == '\n');
        buf[strlen(buf) - 1] = 0;
        processar(buf);
    }
    
    return 0;
}


