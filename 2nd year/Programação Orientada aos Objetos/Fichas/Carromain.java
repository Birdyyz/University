public class Carromain {
//https://www.abt-sportsline.com/abt-limited-editions/abt-rs6-le
public static void main(String[] args) {
        int ano = 2023;
        double consumoporkm = 20;
        double kmtotais = 12;
        double mediaconsumoinicio = 240;
        double kmultimoper = 2;
        double mediaconsumoultimoper = 40;
        double recuperaenergia = 1;
        boolean ligado = false;
        Carro s = new Carro("Audi", "ABT RS6 ", ano , consumoporkm, kmtotais, mediaconsumoinicio, kmultimoper, mediaconsumoultimoper, recuperaenergia,ligado);
        System.out.println(s.toString());
        s.avancaCarro(4000, 150);
        System.out.println("\nApós um avanço de 4km a 150 km/h:");
        System.out.println(s.toString());
        s.travaCarro(300);
        System.out.println("\nApós uma travagem de 300 metros:");
        System.out.println(s.toString());
    }
}