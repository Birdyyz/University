/*
A sala tem capacidade máxima N
Se houver espaço → entram imediatamente
Se não houver espaço → ficam bloqueadas até haver lugar
Se houver threads à espera, deve entrar a primeira da fila (FIFO) imediatamente
*/

import java.util.List;

interface Sala {
    void entra() throws InterruptedException;
    void sai();
}

class SalaImpl implements Sala{
    private final int N;
    private int ocupacao;
    List<Thread> fila = new ArrayList<>();

    public SalaImpl(int N){
        this.N = N;
    }
    public synchronized void entra() throws InterruptedException{
        Thread atual = Thread.currentThread();
        fila.add(atual);

        while(N < ocupacao || fila.get(0) != atual){
            wait();
        }
        fila.remove(0);
        ocupacao++;
    }

    public synchronized void sai(){
        ocupacao--;
        notifyAll();
    }
}