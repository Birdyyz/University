package TESTES_REVI.R_22.T2;






interface MatchMaker {
BoundedBuffer waitForConsumer();
BoundedBuffer waitForProducer();
}




class MatchMakerImpl implements MatchMaker{
    private int produtores = 0;
    private int consumidores = 0;
    private BoundedBuffer buffer;

    MatchMakerImpl(){
    }

    public synchronized BoundedBuffer waitForConsumer(){
        produtores++;

        while(consumidores == 0){
            wait();
        }
        consumidores--;
        buffer = new BoundedBuffer();
        notifyAll();

        return buffer


    }
    public synchronized BoundedBuffer waitForProducer(){
        consumidores ++;

        while(produtores == 0){
            wait();
        }

        produtores--;
        BoundedBuffer buff = buffer;
        buffer = null;

        notifyAll();
        return buff

    }

}

