interface Controller {
    int request_resource(int i);
    void release_resource(int i);
}


class ControllerImpl implements Controller{

    private int recurso[] = new int[2];
    private final int T;
    

    ControllerImpl(int T){
        this.T = T;
    }


    public synchronized int request_resource(int i){
        
        while(recurso[i] == T || recurso[1 - i] > 0){
            wait();
        }
        recurso[i] += 1;
        return i;

    }
    
    public synchronized void release_resource(int i){
        recurso[i]--;
        notifyAll();

    }


}




