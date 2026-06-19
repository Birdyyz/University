import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class Ficha2aula2 {
    private int[] estado;
    public Ficha2aula2(int[] array){
        estado = Arrays.copyOf(array,array.length);
    }

    public int minimo(){
        int min = Integer.MAX_VALUE;
        for(int i = 0; i< estado.length; i++){
            if(estado[i] < min){
            min = estado[i];
        }
    }
    return min;
}
    public int minimo2(){
        int min = Integer.MAX_VALUE;
        for(int v: estado){
            if (v < min){
                min = v;
        }
    }
    return min;
}
    public int[] entre(int a, int b){
        if (a<b && b < estado.length){
            int [] novo =Arrays.copyOfRange(estado,a,b);
            return novo;
    }   else {
               return null;
        }

    }
    /* 
    so funciona para elementos comuns na mesma posicao
    public int [] comuns(int [] pr , int [] sec){ 
        ArrayList<Integer> h = new ArrayList<>();
        int minLength = Math.min(pr.length, sec.length);
        for(int i=0; i<minLength; i++){
            if(pr[i]== sec [i]){
                h.add(pr[i]);
            }
        }
        int[] resultado = new int[h.size()];
        for (int i = 0; i < h.size(); i++) {
            resultado[i] = h.get(i);
        }
        return resultado;
    }
       */ 
    public int[] comuns(int[] pr, int[] sec) {
        int minLength = Math.min(pr.length, sec.length); // Tamanho máximo possível de comuns
        int[] temp = new int[minLength]; // Array temporário para armazenar elementos comuns
        int count = 0; // Contador de elementos comuns

        // Percorre os dois arrays e encontra os elementos comuns
        for (int i = 0; i < pr.length; i++) {
            for (int j = 0; j < sec.length; j++) {
                if (pr[i] == sec[j]) { 
                    // Verifica se o elemento já foi adicionado (evita duplicatas)
                    boolean jaExiste = false;
                    for (int k = 0; k < count; k++) {
                        if (temp[k] == pr[i]) {
                            jaExiste = true;
                            break;
                        }
                    }
                    if (!jaExiste) {
                        temp[count] = pr[i]; // Adiciona no array temporário
                        count++; // Incrementa o contador
                    }
                }
            }
        }

        // Cria um array final com o tamanho exato dos elementos comuns encontrados
        int[] resultado = new int[count];
        for (int i = 0; i < count; i++) {
            resultado[i] = temp[i];
        }

        return resultado;
    }
    public int[] crescente(int[] a){
        int u = a.length;
        for(int i = 0; i < u; i++){
            for(int j = i+1 ; j < u ; j++){
                if(a[j] < a[i]){ // se o indice j for menor troca
                    int temp= a[j];
                    a[j]=a[i];
                    a[i]=temp;
                }
            }
        }
        return a;
    }
    public int procbinario(int []a, int bo){
        int fim = a.length-1;
        int comeco=0;
        while(comeco<=fim){
            int meio=comeco+(fim-comeco)/2;
            if(a[meio] == bo){
                return meio;
            }
            else if (a[meio] >= bo){
                fim=meio-1;
            } 
            else{
                comeco=meio+1;
            }
        }
        return -1;
    }
}

