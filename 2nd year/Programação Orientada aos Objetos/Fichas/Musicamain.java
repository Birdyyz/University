public class Musicamain {
    public static void main(String []args){
        String[] letra = {"E até as flores do jardim","\n" ,
        "Mudam de cor ao ver-te assim", "\n" ,
        "Eu já não posso mais esconder", "\n" ,
        "Esta ansiedade de te ver", "\n" ,
        "Quem és tu miúda" ,"\n"};

        String[] musica= {"C4", "D4", "E4", "F4"};
        Musica s = new Musica("Quem és tu miúda", "Os azeitonas", "Miguel AJ, Salsa, Marlon", "EMI Music Portugal", letra, musica, 400);
        System.out.println(s.toString());
        for (int i=0; i<100;i++){
            s.incrementarNscutada();
        }
        System.out.println(s.toString());
        int posicao = 5;
        s.addLetra(posicao, "\n, Nem sequer sei se existes ou não");
        System.out.println(s.toString());
        System.out.println("\nLinha mais longa: " + s.linhaMaisLonga());
    }
}