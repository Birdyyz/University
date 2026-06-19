import java.util.concurrent.TransferQueue;

interface Travessia{
    void inicioTravessiaIda();
    void inicioTravessiaVolta();
    void fimTravessia();
}

class TravessiaImpl implements Travessia{

    private final int maximo = 10;
    private final int atual = 0;
    private final int ida = 0;
    private final int voltar = 0;

    TravessiaImpl(){
    }

    public synchronized void inicioTravessiaIda(){
        ida++;
        while( atual == maximo || voltar > 0){
            wait();
        }
        ida--;
        atual++;
        notifyAll();
    }

    public synchronized void inicioTravessiaVolta(){
        voltar++;
        while(atual == maximo ){
            wait();
        }
        voltar--;
        atual++;
        notifyAll();
    }

    public synchronized void fimTravessia(){
        atual--;
        notifyAll();
    }




}













