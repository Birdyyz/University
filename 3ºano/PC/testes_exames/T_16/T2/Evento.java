

interface Evento {
    void sinaliza(int tipo);
    void espera(int tipo1, int n1, int tipo2, int n2);
}

class EventoImpl implements Evento {
    private int[] eventos;

    EventoImpl(int E) {
        eventos = new int[E + 1];   // posições 0..E, usa-se 1..E
    }

    @Override
    public synchronized void sinaliza(int tipo) {
        eventos[tipo]++;
        notifyAll();
    }

    @Override
    public synchronized void espera(int tipo1, int n1, int tipo2, int n2) {
        // variáveis locais – cada thread tem as suas
        int v1 = eventos[tipo1];
        int v2 = eventos[tipo2];

        // espera enquanto pelo menos uma das quantidades ainda não foi atingida
        while (eventos[tipo1] - v1 < n1 || eventos[tipo2] - v2 < n2) {
            try {
                wait();
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }
    }
}

