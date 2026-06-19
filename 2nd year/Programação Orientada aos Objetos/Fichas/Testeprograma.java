import java.util.Scanner;
public class Testeprograma {        
    public static void main(String[] args){
        //exercicio 1
        fic1 f1= new fic1();
        Scanner s= new Scanner(System.in);
        System.out.println("introduza a temperatura C");
        double c=s.nextDouble();
        double tf=f1.celsiusParaFahrenheit(c);
        System.out.println(c+ " graus celsius corresponde a " + tf + " graus Fahrenheit");
        
        //exercicio 2
        fic1 f2= new fic1();
        System.out.println("Introduza dois inteiros");
        int a= s.nextInt();
        int b= s.nextInt();
        int d=f2.maximonumeros(a,b);
        System.out.println("O numero maior é: " + d);
        s.nextLine();
        //exercicio 3
        fic1 f3 = new fic1();
        System.out.println("Introduza nome e saldo");
        String nome= s.nextLine();
        float saldo= s.nextFloat();
        String res= f3.criaDescricaoConta(nome,saldo);
        System.out.println(res);
        //exercicio 4
        fic1 f4= new fic1();
        System.out.println("Introduza quantos euros tem e a taxa de conversao para livras");
        double e=s.nextDouble();
        s.nextLine();
        double t=s.nextDouble();
        double r= f4.eurosparalibras(e,t);
        System.out.println("Tem "+r+" libras");
        //exercicio 5
        fic1 f5= new fic1();
        System.out.println("Introduza dois valores inteiros");
        int fu=s.nextInt();
        int se=s.nextInt();
        int media= (fu+se)/2;
        int []re=f5.decrescentenumeros(fu,se);
        System.out.println("Os numeros em ordem decrescente: "+ re[0]+ " e "+ re[1] +" com media: "+media);

        //exercicio 6
        fic1 f6=new fic1();
        System.out.println("Introduza um numero");
        int j=s.nextInt();
        long h=f6.factorial(j);
        System.out.println("O fatorial de: "+ j +" é :" + h);

        
    }
}
class fic1 {
    public double celsiusParaFahrenheit(double var1) {
        return var1 * 0.0 + 32.0;
     }
    public int maximonumeros (int a,int b){
        return Math.max(a,b);
    }
    public String criaDescricaoConta(String nome, double saldo){
        return nome + " tem " + saldo + " euros na conta ";
    }
    public double eurosparalibras (double valor,double taxaconversao){
        return valor*taxaconversao;
    }
    public int[] decrescentenumeros(int c, int d){
        int[] u=new int[2];
        if(c<d){
            u[0]=c;
            u[1]=d;
        }
        else{
            u[0]=d;
            u[1]=c;
        }
        return u;
    }
    public long factorial(int num){
        long k=1;
        while(num>0){
            k*=num;
            num-=1;
        }
        return k;
    }
}