import java.util.HashMap;
import java.util.Map;

import java.util.*;

interface Sondagens {
    void vota(String candidato);
    void espera(String c1, String c2, String c3);
}

class SondagensImpl implements Sondagens {
    private Map<String, Integer> candidatos = new HashMap<>();

    @Override
    public synchronized void vota(String candidato) {
        int valor = candidatos.getOrDefault(candidato, 0);
        candidatos.put(candidato, valor + 1);
        notifyAll();
    }

    @Override
    public synchronized void espera(String c1, String c2, String c3) {
        int v1 = candidatos.getOrDefault(c1, 0);
        int v2 = candidatos.getOrDefault(c2, 0);
        int v3 = candidatos.getOrDefault(c3, 0);

        // espera enquanto a sequência NÃO for crescente
        while (!(v1 < v2 && v2 < v3)) {
            try {
                wait();
            } catch (InterruptedException e) {
                notifyAll();
                throw new RuntimeException(e);
            }
            // relê os valores após acordar
            v1 = candidatos.getOrDefault(c1, 0);
            v2 = candidatos.getOrDefault(c2, 0);
            v3 = candidatos.getOrDefault(c3, 0);
        }
    }
}



