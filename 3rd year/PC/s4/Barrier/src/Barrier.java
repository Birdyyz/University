class Barrier {
    private final int N;
    private int count = 0;
    private int out = 0;
    public Barrier (int N) {
        this.N = N;    
     }
    public synchronized void await() throws InterruptedException {
        while(out > 0){
            wait();
        }
        count++;
        if (count < N){
            while(count < N){
                wait();
            }
        }else{
            // o count antes ou depois de notifyAll() vai dar ao mesmo e nao funciona para o 2
            notifyAll();
            //count = 0;
        }
        //count--; nao funciona
        out++;
        if(out == N){
            count = 0;
            out = 0;
            notifyAll();
        }                       
    }
}