#include <stdio.h>
#include <stdlib.h>
#define NV 10
typedef struct aresta {
int dest; int custo;
struct aresta *prox;
} *LAdj, *GrafoL [NV];
typedef int GrafoM [NV][NV];
void inicializa_grafo(GrafoL grafo) {
    for (int i = 0; i < NV; i++) {
        grafo[i] = NULL;
    }
}
void adiciona_aresta(GrafoL grafo, int origem, int destino, int custo) {
    LAdj nova = (LAdj)malloc(sizeof(struct aresta));
    nova->dest = destino;
    nova->custo = custo;
    nova->prox = grafo[origem];
    grafo[origem] = nova;
}
void imprime_grafo(GrafoL grafo) {
    for (int i = 0; i < NV; i++) {
        printf("Vertice %d: ", i);
        LAdj atual = grafo[i];
        while (atual != NULL) {
            printf("(%d, custo %d) -> ", atual->dest, atual->custo);
            atual = atual->prox;
        }
        printf("NULL\n");
    }
}


//constroi o grafo out a partir do grafo in.
void fromMat (GrafoM in, GrafoL out){
    struct aresta *x;
    int i,j;
    for(i=0;i<NV;i++){
        out[i]=NULL; // iniciar a nossa posicao como null
        for (j=0;j<NV;j++){
            if (in[i][j]!=0){ // se existir aresta
            x=malloc(sizeof(struct aresta)); //criar a caixinha
            x->dest= j; //o destino da aresta será o nosso j
            x->custo = in[i][j]; // o custo da nossa aresta
            x->prox=out[i];
            out[i]= x;
            x=x->prox; // avancamos para o proximo x senao vamos estar a apagar a lista
        }
    }
    }
}// é void nao devolve nada

void inverte (GrafoL in, GrafoL out){
    struct aresta *x,*y;
    int i,j;
    for (i=0;i<NV;i++){ 
        for(x=in[i];x!=NULL;x=x->prox){
                y=malloc(sizeof(struct aresta));
                y->dest=i;
                y->custo=x->custo;
                y->prox = out [x->dest];
                out[x->dest]= y;
            }
        
    }
}
int BF(GrafoL g, int or, int v[], int p[], int l[])
{
    int i, x;
    LAdj a;
    int q[NV], front, end;
    for (i = 0; i < NV; i++)
    {
        v[i] = 0;
        p[i] = -1;
        l[i] = -1;
    }
    front = end = 0;
    q[end++] = or ; //enqueue
    v[or] = 1;
    p[or] = -1;
    l[or] = 0;
    i = 1;
    while (front != end)
    {
        x = q[front++]; //dequeue
        for (a = g[x]; a != NULL; a = a->prox)
            if (!v[a->dest])
            {
                i++;
                v[a->dest] = 1;
                p[a->dest] = x;
                l[a->dest] = 1 + l[x];
                q[end++] = a->dest; //enqueue
            }
    }
    return i;
}
int maisLonga (GrafoL g, int or, int p[]) {
    int i, r, max = or;
    int vis[NV], pai[NV], dist[NV];

    BF(g, or, vis, pai, dist);

    for (i = 0; i < NV; i++) {
        if (dist[i] > dist[max]) {
            max = i;
        }
    }

    r = dist[max];

    while (max != -1) {
        p[dist[max]] = max;
        max = pai[max];
    }

    return r;
}

int main() {
    GrafoL in;
    int predecessores[NV];

    // Inicializa o grafo
    inicializa_grafo(in);

    // Adiciona arestas ao grafo
    adiciona_aresta(in, 0, 1, 10);
    adiciona_aresta(in, 0, 2, 5);
    adiciona_aresta(in, 1, 3, 2);
    adiciona_aresta(in, 2, 3, 1);
    adiciona_aresta(in, 3, 4, 7);

    // Imprime o grafo original
    printf("Grafo original:\n");
    imprime_grafo(in);

    // Encontra o caminho mais longo a partir do vértice 0
    int origem = 0;
    int maxDist = maisLonga(in, origem, predecessores);

    printf("\nCaminho mais longo a partir do vertice %d tem comprimento %d\n", origem, maxDist);
    printf("Predecessores:\n");
    for (int i = 0; i < NV; i++) {
        if (predecessores[i] != -1) {
            printf("Vertice %d <- %d\n", i, predecessores[i]);
        }
    }

    return 0;
}

int inDegree(GrafoL g){
    struct aresta *x;
    int i;
    int max=0; r=0;
    for(i=0;i<NV;i++){
        x=g[i];
        while(x!=NULL){
            r++;
            x=x->prox;
        }
        if(r>max){
            max=r;
        }
        r=0;
    }
    return max;
}

int colorok(GrafoL g, int cor[]){
    int i;
    struct aresta *x;
    for (i=0;i<NV;i++){
        for(x=g[i]; x!=NULL; x=x->prox){
            if(cor[x]==cor[x->dest]){
                return 0;
            }
        }
    }
    return 1;
}

int homorfOK(GrafoL g, GrafoL h, int f[]){
    int i;
    struct aresta *x,*y;
    for(i=0;i<NV;i++){
        for(x=g[i];x!=NULL;x=x->prox){
            for(y=h[f[x]];y!=NULL;y=y->prox){
                if(x->dest == f[y->dest]){
                break;
                }
            }
        }
    }
}