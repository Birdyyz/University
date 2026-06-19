interface Jogo{
    Partida participa();
}
interface Partida{
    boolean aposta(int n, int media);
}

class JogoImpl implements Jogo{
    private int numero_jogadores = 0;
    private PartidaImpl partida;
    private boolean timerAtivo = false;
    public synchronized Partida participa(){
        if(numero_jogadores == 0){
            partida = new PartidaImpl();
            iniciar_timer(partida);
        }
        numero_jogadores++;
        return partida;
    }
    public synchronized void iniciar_timer(PartidaImpl partida){
        if(timerAtivo){
            return;
        }
        timerAtivo = true;
        new Thread(()-> {
            try{
                Thread.sleep(60000);
                partida.iniciarPartida();
            }catch(InterruptedException e){}
        }).start();
    }
}
class PartidaImpl implements Partida{
    private int soma = 0;
    private int quantidade = 0;
    private boolean ativa = false;
    public synchronized void iniciarPartida() {
        ativa = true;
    }
    public synchronized boolean aposta(int n, int media){
        if(!ativa){
            return false;
        }
        soma+=n;
        quantidade++;
        int res = soma/quantidade;
        if(res == media){
            return true;
        }
        return false;
    }
}
