-module(jogo1).
-export([start/0, participa/1, adivinha/2]).

%---------- Interface para clientes ----------
start() ->
    spawn(fun() -> jogo_loop(0, []) end).

participa(JogoPid) ->
    JogoPid ! {participa, self()},
    receive
        {partida, PartidaPid} -> PartidaPid
    end.

adivinha(PartidaPid, N) ->
    PartidaPid ! {adivinha, N, self()},
    receive
        Res -> Res
    end.

%---------- Servidor de formação de partidas ----------
jogo_loop(Atual, Pids) ->
    receive
        {participa, From} ->
            NovoAtual = Atual + 1,
            if
                NovoAtual < 4 ->
                    % ainda não chegou o 4º jogador
                    jogo_loop(NovoAtual, [From | Pids]);
                true ->
                    % chegou o 4º jogador: cria partida e notifica todos
                    PartidaPid = spawn(fun() -> partida_loop(rand:uniform(100), os:system_time(millisecond), 0, false) end),
                    % envia o PID da partida aos 3 que estavam à espera
                    lists:foreach(fun(Pid) -> Pid ! {partida, PartidaPid} end, Pids),
                    % envia também ao próprio 4º jogador
                    From ! {partida, PartidaPid},
                    % reinicia para a próxima partida
                    jogo_loop(0, [])
            end
    end.

%---------- Processo da partida ----------
partida_loop(Resposta, Inicio, Tentativas, Vencedor) ->
    receive
        {adivinha, N, From} ->
            NovasTentativas = Tentativas + 1,
            if
                Vencedor ->
                    From ! "PERDEU",
                    partida_loop(Resposta, Inicio, NovasTentativas, Vencedor);
                NovasTentativas > 100 ->
                    From ! "TENTATIVAS",
                    partida_loop(Resposta, Inicio, NovasTentativas, Vencedor);
                os:system_time(millisecond) - Inicio > 60000 ->
                    From ! "TEMPO",
                    partida_loop(Resposta, Inicio, NovasTentativas, Vencedor);
                N == Resposta ->
                    From ! "GANHOU",
                    partida_loop(Resposta, Inicio, NovasTentativas, true);
                N > Resposta ->
                    From ! "MAIOR",
                    partida_loop(Resposta, Inicio, NovasTentativas, Vencedor);
                true ->
                    From ! "MENOR",
                    partida_loop(Resposta, Inicio, NovasTentativas, Vencedor)
            end
    end.
