package TESTES_REVI.T_16;






interface Evento {
    void sinaliza(int tipo);
    void espera(int tipo1, int n1, int tipo2, int n2);
}

class EventoImpl implements Evento {
    private final int[] contadores;   // total de eventos por tipo (índice 1..E)
    private boolean ocupado;          // true se já há uma thread em espera
    private int t1, q1, t2, q2;       // parâmetros do pedido actual
    private int inicio1, inicio2;     // valores dos contadores no momento do pedido
    private boolean satisfeito;       // true quando o pedido pode prosseguir

    EventoImpl(int E) {
        contadores = new int[E + 1];  // posição 0 não é usada
    }

    @Override
    public synchronized void sinaliza(int tipo) {
        contadores[tipo]++;

        // se há uma thread à espera e o seu pedido ficou satisfeito...
        if (ocupado &&
            contadores[t1] - inicio1 >= q1 &&
            contadores[t2] - inicio2 >= q2) {
            satisfeito = true;
            notifyAll();              // acorda a thread que está em espera
        }
    }

    @Override
    public synchronized void espera(int tipo1, int n1, int tipo2, int n2) {
        // 1. esperar até não haver outra thread a usar o serviço
        while (ocupado) {
            try {
                wait();
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }

        // 2. registar o pedido
        ocupado = true;
        t1 = tipo1; q1 = n1;
        t2 = tipo2; q2 = n2;
        inicio1 = contadores[tipo1];
        inicio2 = contadores[tipo2];
        satisfeito = false;

        // 3. esperar até que o pedido seja satisfeito
        while (!satisfeito) {
            try {
                wait();
            } catch (InterruptedException e) {
                // se for interrompida, desiste e liberta o lugar
                ocupado = false;
                notifyAll();
                throw new RuntimeException(e);
            }
        }

        // 4. pedido satisfeito: libertar o lugar e acordar a próxima thread
        ocupado = false;
        notifyAll();
    }
}











