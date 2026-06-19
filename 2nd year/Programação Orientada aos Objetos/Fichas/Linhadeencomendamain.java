public class Linhadeencomendamain {
    public static void main(String[] args) {
        double price = 1.99;
        Integer quantity = 2;
        double tax = 6;
        double discount = 10;
        Linhadeencomenda s = new Linhadeencomenda("1987654","Golden apple",price,quantity,tax,discount);
        System.out.println(s.toString());
    }
}