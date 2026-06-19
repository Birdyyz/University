import java.lang.classfile.Signature.TypeArg.Bounded;

import javax.management.RuntimeErrorException;

interface MatchMaker {
    BoundedBuffer waitForConsumer();
    BoundedBuffer waitForProducer();
}


class MatchMakerImpl implements MatchMaker {
    private int waitingProducers = 0;
    private int waitingConsumers = 0;
    private BoundedBuffer sharedBuffer;   // buffer do par atual

    @Override
public synchronized BoundedBuffer waitForConsumer() {

    waitingProducers++;

    while (waitingConsumers == 0) {
        try {
            wait();
        } catch (InterruptedException e) {
            waitingProducers--;
            notifyAll();
            throw new RuntimeException(e);
        }
    }
    waitingProducers--;
    waitingConsumers--;

    sharedBuffer = new BoundedBuffer();
    notifyAll();
    return sharedBuffer;
}

    @Override
    public synchronized BoundedBuffer waitForProducer() {

        waitingConsumers++;

        while (waitingProducers == 0) {
            try {
                wait();
            } catch (InterruptedException e) {
                waitingConsumers--;
                notifyAll();
                throw new RuntimeException(e);
            }
        }

        waitingConsumers--;
        waitingProducers--;

        sharedBuffer = new BoundedBuffer();
        notifyAll();
        return sharedBuffer;
    }

}