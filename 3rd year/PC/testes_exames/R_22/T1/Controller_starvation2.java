package TESTES_REVI.R_22;



import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;





interface Controller_starvation2 {
    int request_resource(int i);
    void release_resource(int i);
}




class ControllerImpl implements Controller_starvation2 {
    private final int T;
    private final Lock l = new ReentrantLock();
    private final Condition cond = l.newCondition();   // única condição (como um único monitor)
    private int[] waiting = new int[2];
    private int[] accessing = new int[2];

    ControllerImpl(int T) {
        this.T = T;
    }

    public int request_resource(int i) throws InterruptedException {
        l.lock();
        try {
            waiting[i]++;
            // mesmo predicado de sempre
            while (accessing[i] == T || accessing[1 - i] > 0) {
                cond.await();      // equivalente a wait()
            }
            waiting[i]--;
            accessing[i]++;
            return i;
        } finally {
            l.unlock();
        }
    }

    public void release_resource(int i) {
        l.lock();
        try {
            accessing[i]--;
            cond.signalAll();      // equivalente a notifyAll()
        } finally {
            l.unlock();
        }
    }
}



