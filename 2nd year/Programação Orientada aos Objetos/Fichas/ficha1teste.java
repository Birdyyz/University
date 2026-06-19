import java.util.Scanner;

public class ficha1teste {
    public static void main(String[] args){
        ficha1 f= new ficha1();
        Scanner s= new Scanner(System.in);
        System.out.println("introduza a temperatura C");
        double c=s.nextDouble();
        double tf=f.celsiusParaFahrenheit(c);
        System.out.println(c+ " graus celsius corresponde a " + tf + " graus Fahrenheit");
    }
}
