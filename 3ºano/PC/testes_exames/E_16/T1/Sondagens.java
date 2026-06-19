import java.util.HashMap;
import java.util.Map;

interface Sondagens {
    void vota(String candidato);
    void espera(String c1, String c2, String c3);
}

class SondagensImpl implements Sondagens {

    private Map<String, Integer> votos;

    public SondagensImpl() {
        votos = new HashMap<>();
    }

    public synchronized void vota(String candidato) {
        int atual = votos.getOrDefault(candidato, 0);
        votos.put(candidato, atual + 1);

        notifyAll();
    }

    public synchronized void espera(String c1, String c2, String c3) {

        while (!(votos.getOrDefault(c1, 0) <
                 votos.getOrDefault(c2, 0) &&
                 votos.getOrDefault(c2, 0) <
                 votos.getOrDefault(c3, 0))) {

            try {
                wait();
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                return;
            }
        }
    }
}