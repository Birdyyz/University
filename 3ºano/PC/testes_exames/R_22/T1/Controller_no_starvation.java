package TESTES_REVI.R_22;



import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;





interface Controller_no_starvation2 {
    int request_resource(int i);
    void release_resource(int i);
}




class ControllerImpl implements Controller_no_starvation2 {
    private final int T;
    private final Lock l = new ReentrantLock();
    private final Condition[] cond = { l.newCondition(), l.newCondition() };

    private int[] accessing = new int[2];   // threads a usar cada recurso
    private int[] waiting  = new int[2];    // threads à espera de cada recurso
    private int[] permits  = new int[2];    // bilhetes de prioridade

    ControllerImpl(int T) {
        this.T = T;
    }

    @Override
    public int request_resource(int i) throws InterruptedException {
        l.lock();
        try {
            waiting[i]++;
            // espera enquanto:
            //   - o recurso i já tem T threads
            //   - o outro recurso está a ser acedido (exclusão mútua)
            //   - não tem bilhete e há threads à espera do outro recurso
            while (accessing[i] == T ||
                   accessing[1 - i] > 0  ||
                   (permits[i] == 0 && waiting[1 - i] > 0)) {
                cond[i].await();
            }
            waiting[i]--;
            accessing[i]++;
            if (permits[i] > 0) {
                permits[i]--;          // consome um bilhete de prioridade
            }
            return i;
        } finally {
            l.unlock();
        }
    }

    @Override
    public void release_resource(int i) {
        l.lock();
        try {
            accessing[i]--;
            cond[i].signal();           // acorda uma thread do mesmo recurso
            if (accessing[i] == 0) {
                // passa a vez ao outro recurso, concedendo-lhe bilhetes
                permits[1 - i] = waiting[1 - i];
                cond[1 - i].signalAll();
            }
        } finally {
            l.unlock();
        }
    }
}