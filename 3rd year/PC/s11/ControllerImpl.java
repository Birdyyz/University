interface Controller {
    int request_resource(int i) throws InterruptedException;
    void release_resource(int i);
}

class ControllerImpl implements Controller {

    private final int T;

    private int recursoAtual = -1;
    private int emUso = 0;

    private int espera0 = 0;
    private int espera1 = 0;

    private int preferencia = 0;

    public ControllerImpl(int T) {
        this.T = T;
    }

    public synchronized int request_resource(int i)
            throws InterruptedException {

        if (i == 0) espera0++;
        else espera1++;

        while (
            (recursoAtual != -1 && recursoAtual != i)|| emUso == T|| ( recursoAtual == -1&& preferencia != i&& ((i == 0 && espera1 > 0)|| (i == 1 && espera0 > 0)))) {
            wait();
        }

        if (i == 0) espera0--;
        else espera1--;

        if (recursoAtual == -1)
            recursoAtual = i;

        emUso++;

        return i;
    }

    public synchronized void release_resource(int i) {
        emUso--;
        if (emUso == 0) {

            recursoAtual = -1;

            if (i == 0 && espera1 > 0)
                preferencia = 1;

            else if (i == 1 && espera0 > 0)
                preferencia = 0;
        }

        notifyAll();
    }
}