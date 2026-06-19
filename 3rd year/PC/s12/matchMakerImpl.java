import java.util.ArrayList;
import java.util.List;

interface MatchMaker {
    BoundedBuffer waitForConsumer() throws InterruptedException;
    BoundedBuffer waitForProducer() throws InterruptedException;
}

class MatchMakerImpl implements MatchMaker {

    private int produtoresEspera = 0;
    private int consumidoresEspera = 0;

    private List<BoundedBuffer> buffers = new ArrayList<>();

    @Override
    public synchronized BoundedBuffer waitForConsumer() throws InterruptedException {

        // há produtor disponível → faz match
        if (produtoresEspera > 0) {

            produtoresEspera--;

            BoundedBuffer b = new BoundedBuffer();

            buffers.add(b);

            notifyAll();

            return b;
        }

        // não há produtor → espera
        consumidoresEspera++;

        while (buffers.isEmpty()) {
            wait();
        }

        return buffers.remove(0);
    }

    @Override
    public synchronized BoundedBuffer waitForProducer() throws InterruptedException {

        // há consumidor disponível → faz match
        if (consumidoresEspera > 0) {

            consumidoresEspera--;

            BoundedBuffer b = new BoundedBuffer();

            buffers.add(b);

            notifyAll();

            return b;
        }

        // não há consumidor → espera
        produtoresEspera++;

        while (buffers.isEmpty()) {
            wait();
        }

        return buffers.remove(0);
    }
}