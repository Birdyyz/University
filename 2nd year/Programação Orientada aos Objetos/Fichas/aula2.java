import java.util.Arrays;
import java.util.Scanner;

public class aula2 {
    public static void main(String[]agrs){
        //exercicio 1. a)
        int n;
        Scanner sc = new Scanner(System.in);
        System.out.println("Digite o tamanho do vetor: ");
        n = sc.nextInt();
        int [] array = new int[n];
        for(int i = 0; i<n; i++){
            System.out.println("Digite o valor da posição");
            array[i]=sc.nextInt();
        }
        Ficha2aula2 f= new Ficha2aula2(array);
        System.out.println("O minimo do array " + Arrays.toString(array) + " é " + f.minimo());
        System.out.println("O minimo2 do array "+ Arrays.toString(array) + " é " + f.minimo2());
        //exercicio 1. b)
        System.out.println("Digite dois indices do vetor: ");
        sc.nextLine();
        int k = sc.nextInt();
        int s = sc.nextInt();
        Ficha2aula2 f1= new Ficha2aula2(array);
        int [] res= f1.entre(k,s);
        System.out.println("Os valores entre os indices são: " + Arrays.toString(res));
        //exercicio 1.c)
        System.out.println("Digite o tamanho de mais um vetor: ");
        int t=sc.nextInt();
        int [] array2= new int[t];
        for(int i = 0; i<t; i++){
            System.out.println("Digite o valor da posição");
            array2[i]=sc.nextInt();
        }
        Ficha2aula2 f2= new Ficha2aula2(array);
        int [] kg = f2.comuns(array, array2);
        System.out.println("Os valores em comum entre os dois arrays são: " + Arrays.toString(kg));
        // exercicio 3.a)
        Ficha2aula2 f3= new Ficha2aula2(array);
        int []j = f3.crescente(array);
        System.out.println("O array ordenado fica:" + Arrays.toString(j));
        // exercicio 3.b)
        Ficha2aula2 f4= new Ficha2aula2(j);
        System.out.println("Digite um elemento");
        int bo=sc.nextInt();
        int h= f4.procbinario(j,bo);
        System.out.println("O elemento esta na posicao:"+ h);
    }
}