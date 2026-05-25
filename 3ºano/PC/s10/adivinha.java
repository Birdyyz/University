import java.util.Random;

interface Jogo { 
    Partida participa(); 
} 
interface Partida { 
    String adivinha(int n); 
}

class JogoImpl implements Jogo {
    private PartidaImpl partidaAtual = new PartidaImpl();
    public synchronized Partida participa() {

        PartidaImpl minhaPartida = partidaAtual;
        partidaAtual.jogadores++;
        if (partidaAtual.jogadores == 4) {
            partidaAtual.start();
            partidaAtual = new PartidaImpl();
            notifyAll();
        }
        else {
            while (partidaAtual == minhaPartida) {
                try {
                    wait();
                }
                catch (InterruptedException e) {}
            }
        }
        return minhaPartida;
    }
}
class PartidaImpl implements Partida{
    int tentativas = 100;
    int jogadores = 0;
    boolean ganhou = false;
    Random rand = new Random();
    int numero = rand.nextInt(100) + 1; 
    boolean timeout = false;

    synchronized void timeout(){
        timeout = true;
    }
    void start(){
        new Thread(() -> {
            try{
                Thread.sleep(60000);
            } catch (InterruptedException ignored) {}
            timeout();
        }).start();
    }

    public synchronized String adivinha(int n){

    if (ganhou)
        return "PERDEU";

    if (timeout)
        return "TEMPO";

    if (tentativas == 0)
        return "TENTATIVAS";

    tentativas--;

    if (n == numero){
        ganhou = true;
        return "GANHOU";
    }

    if (n < numero)
        return "MAIOR";

    return "MENOR";
}
}