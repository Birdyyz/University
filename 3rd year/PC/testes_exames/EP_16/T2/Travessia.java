

package TESTES_REVI.EP_16.T2;

public interface Travessia {
    void inicioTravessiaIda();
    void inicioTravessiaVolta();
    void fimTravessia();
}

class TravessiaImpl implements Travessia {
    private final int MAXIMO = 10;
    private int atual = 0;      // pessoas na ponte
    private int ida = 0;        // pessoas à espera para ir
    private int volta = 0;      // pessoas à espera para voltar

    TravessiaImpl() { };


    public synchronized void inicioTravessiaIda() {
        ida++;
        try {
            while (atual == MAXIMO || volta > 0) {
                wait();
            }
        } catch (InterruptedException e) {
            ida--;
            notifyAll();
            Thread.currentThread().interrupt();
        }
        ida--;
        atual++;
    }

    @Override
    public synchronized void inicioTravessiaVolta() {
        volta++;
        try {
            while (atual == MAXIMO) {
                wait();
            }
        } catch (InterruptedException e) {
            volta--;
            notifyAll();
            Thread.currentThread().interrupt();
        }
        volta--;
        atual++;
    }

    @Override
    public synchronized void fimTravessia() {
        atual--;
        notifyAll();
    }
}
