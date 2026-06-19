package TESTES_REVI.T_2019.T2;

import java.util.Random;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import javax.management.RuntimeErrorException;
import java.util.Random;



import java.util.Random;

interface Jogo {
    Partida participa();
}

interface Partida {
    String adivinha(int n);
}

class JogoImpl implements Jogo {
    private final int total = 4;
    private int atual = 0;
    private Partida partida;          // começa null

    JogoImpl() { }

    @Override
    public synchronized Partida participa() {
        atual++;
        if (atual < total) {
            // não é a última: espera até que a partida seja criada
            while (partida == null) {
                try {
                    wait();
                } catch (InterruptedException e) {
                    atual--;
                    notifyAll();
                    throw new RuntimeException(e);
                }
            }
        } else {
            // é a última (atual == total): cria a partida e acorda todas
            partida = new PartidaImpl();
            notifyAll();
        }
        // todas as threads chegam aqui (as que esperaram e a que criou)
        Partida p = partida;
        atual--;
        if (atual == 0) {
            partida = null;      // limpa para a próxima partida
        }
        return p;
    }
}

class PartidaImpl implements Partida {
    private final int numeroSecreto;
    private int tentativas = 0;
    private boolean vencedor = false;
    private final long inicio;

    PartidaImpl() {
        Random rand = new Random();
        this.numeroSecreto = rand.nextInt(100) + 1;   // 1..100
        this.inicio = System.currentTimeMillis();
    }

    @Override
    public synchronized String adivinha(int n) {
        tentativas++;

        // 1. já houve vencedor?
        if (vencedor) {
            return "PERDEU";
        }
        // 2. limite de tentativas total
        if (tentativas > 100) {
            return "TENTATIVAS";
        }
        // 3. tempo limite (1 minuto)
        if (System.currentTimeMillis() - inicio > 60_000) {
            return "TEMPO";
        }
        // 4. compara com o número secreto
        if (n == numeroSecreto) {
            vencedor = true;
            return "GANHOU";
        } else if (n > numeroSecreto) {
            return "MAIOR";
        } else {
            return "MENOR";
        }
    }
}




