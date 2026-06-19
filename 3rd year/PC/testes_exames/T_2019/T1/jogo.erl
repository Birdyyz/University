-module(jogo).
-export([start/0, participa/1, adivinha/2]).

start() ->
    spawn(fun() -> jogo_manager([]) end).

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

jogo_manager(Espera) ->
    receive
        {participa, From} ->
            NovaEspera = [From | Espera],
            case length(NovaEspera) of
                4 ->
                    PartidaPid = spawn(fun() -> partida(rand:uniform(100), os:system_time(millisecond), 0, false) end),
                    lists:foreach(fun(Pid) -> Pid ! {partida, PartidaPid} end, NovaEspera),
                    jogo_manager([]);
                _ ->
                    jogo_manager(NovaEspera)
            end
    end.

partida(Resposta, Inicio, Tentativas, Vencedor) ->
    receive
        {adivinha, N, From} ->
            NovasTentativas = Tentativas + 1,
            if
                Vencedor ->
                    From ! "PERDEU",
                    partida(Resposta, Inicio, NovasTentativas, Vencedor);
                NovasTentativas > 100 ->
                    From ! "TENTATIVAS",
                    partida(Resposta, Inicio, NovasTentativas, Vencedor);
                os:system_time(millisecond) - Inicio > 60000 ->
                    From ! "TEMPO",
                    partida(Resposta, Inicio, NovasTentativas, Vencedor);
                N == Resposta ->
                    From ! "GANHOU",
                    partida(Resposta, Inicio, NovasTentativas, true);
                N > Resposta ->
                    From ! "MAIOR",
                    partida(Resposta, Inicio, NovasTentativas, Vencedor);
                true ->
                    From ! "MENOR",
                    partida(Resposta, Inicio, NovasTentativas, Vencedor)
            end
    end.