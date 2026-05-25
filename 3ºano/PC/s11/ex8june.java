import java.util.concurrent.*;
import java.util.concurrent.locks.*;

interface Controller { 
    void request_resource(int i) throws InterruptedException; 

    void release_resource(int i); 

}

class ControllerImpl implements Controller{
    final int T;
    ControllerImpl(int T){
        this.T = T;
    }
    Lock l = new ReentrantLock();

    Condition[] cond = {l.newCondition(), l.newCondition()};
    int[] acessing = new int[2];
    int[] waiting = new int[2];
    int[] permits = new int[2];

    void request_resource(int i) throws InterruptedException{
        l.lock();
        try {
            waiting[i]++;
            while (acessing[1-i] > 0 || T == acessing[i] || waiting[1-i] > 0 && permits[i] == 0){
                cond[i].await();
            }
            waiting[i]--;
            acessing[i]++;
            if(permits[i] > 0){
                permits[i]--;
        }
        } finally {
            l.unlock();
        }
    }

    void release_resource(int i){
        l.lock();
        try {
            acessing[i]--;
            cond[i].signal();
            if (acessing[i] == 0){
                cond[1-i].signalAll();
                permits[1-i] = waiting[1-i];
            }
        } finally {
            l.unlock();
        }
        waiting[i] = 0;
    }
}

