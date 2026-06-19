


interface Jogo {
    Partida participa();
}

interface Partida {
    boolean aposta(int n, int media);
}

class JogoImpl implements Jogo {
    private long tempoInicio = 0;      // instante em que o primeiro jogador chegou
    private int espera = 0;            // quantos jogadores estão à espera nesta ronda
    private Partida partida = null;    // partida criada para esta ronda

    JogoImpl() { }

    @Override
    public synchronized Partida participa() {
        espera++;

        // Se for o primeiro, regista o instante inicial
        if (tempoInicio == 0) {
            tempoInicio = System.currentTimeMillis();
        }

        // Espera enquanto não tiver passado 1 minuto
        while (System.currentTimeMillis() - tempoInicio < 60000) {
            try {
                wait(1000);   // espera até 1 segundo e reavalia
            } catch (InterruptedException e) {
                espera--;
                notifyAll();
                throw new RuntimeException(e);
            }
        }

        // O minuto acabou: acorda todas as outras threads
        notifyAll();

        int total = espera;          // número de jogadores desta partida
        espera--;

        // A primeira thread a sair do loop cria a partida
        if (partida == null) {
            partida = new PartidaImpl(total);
        }

        Partida minhaPartida = partida;

        // Se for o último a sair, reinicia o estado para a próxima ronda
        if (espera == 0) {
            tempoInicio = 0;
            partida = null;
        }

        return minhaPartida;
    }
}

class PartidaImpl implements Partida {
    private final int total;          // número de jogadores
    private int votaram = 0;          // quantos já votaram
    private int soma = 0;             // soma dos números escolhidos
    private int mediaReal = -1;       // média calculada (-1 = ainda não calculada)

    PartidaImpl(int total) {
        this.total = total;
    }

    @Override
    public synchronized boolean aposta(int n, int media) {
        votaram++;
        soma += n;

        // Se todos já votaram, calcula a média e acorda as outras threads
        if (votaram == total) {
            mediaReal = soma / total;   // divisão inteira
            notifyAll();
        }

        // Espera até a média estar calculada
        while (mediaReal == -1) {
            try {
                wait();
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }

        return (mediaReal == media);
    }
}




