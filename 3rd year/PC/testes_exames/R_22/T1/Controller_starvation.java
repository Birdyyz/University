package TESTES_REVI.R_22;



import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;





interface Controller_starvation {
    int request_resource(int i);
    void release_resource(int i);
}




class ControllerImpl implements Controller_starvation {
    private final int T;
    private int[] waiting = new int[2];
    private int[] accessing = new int[2];

    ControllerImpl(int T) {
        this.T = T;
    }

    public synchronized int request_resource(int i) throws InterruptedException {
        waiting[i]++;
        // Espera enquanto:
        // - o meu recurso já tem T threads (cheio)
        // - ou o outro recurso está a ser acedido (exclusão mútua)
        while (accessing[i] == T || accessing[1 - i] > 0) {
            wait();
        }
        waiting[i]--;
        accessing[i]++;
        return i;
    }

    public synchronized void release_resource(int i) {
        accessing[i]--;
        notifyAll();   // acorda todas as threads à espera
    }
}













