#include <stdio.h>



//por sucessivas trocas com o pai) puxa o elemento que esta na posicao i da min-heap h ate que satisfaca a propriedade das min-heaps
void bubbleUp(int i, int h[]){
    while(i>0){
        if(h[i]<h[(i-1)/2]){
            int temp=h[(i-1)/2];
            h[(i-1)/2]=h[i];
            h[i]=temp;
            i=(i-1)/2;
        }
        else{
            break;
        }
    }
}

// Função para imprimir a heap
void printHeap(int h[], int N) {
    printf("Heap: ");
    for (int i = 0; i < N; i++) {
        printf("%d ", h[i]);
    }
    printf("\n");
}

void bubbleDown(int i, int h[], int N){
int x= 2*i+1;
  while(x<N){
    int menor=x;

    if(x+1<N && h[x+1]<h[x]){
        menor=x+1;
    }
    if(h[i]<=h[menor]){
        break;
    }
            int temp=h[i];
            h[i]=h[menor];
            h[menor]=temp;
            i=menor;
            x=2*i+1;
  }
}

int main() {
    // Exemplo de min-heap inicial
    int h[] = {1, 3, 6, 5, 9, 8};
    int N = 6; // Tamanho da heap

    printf("Heap inicial:\n");
    printHeap(h, N);

    // Simula um elemento no topo que viola a propriedade da min-heap
    h[0] = 10;

    printf("\nHeap após violação:\n");
    printHeap(h, N);

    // Chama bubbleDown para corrigir a heap
    bubbleDown(0, h, N);

    printf("\nHeap após bubbleDown:\n");
    printHeap(h, N);

    return 0;
}
