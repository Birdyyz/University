
-module(jogo).
-export([start/0, participa/1, aposta/3]).

%---------- Interface ----------
start() ->
    spawn(fun() -> jogo_loop(undefined, []) end).

participa(JogoPid) ->
    JogoPid ! {participa, self()},
    receive
        {partida, PartidaPid} -> PartidaPid
    end.

aposta(PartidaPid, N, Media) ->
    PartidaPid ! {aposta, N, Media, self()},
    receive
        Res -> Res
    end.

%---------- Servidor de jogo ----------
jogo_loop(TimerRef, Pids) ->
    receive
        {participa, From} ->
            if
                TimerRef == undefined ->
                    {ok, NovoRef} = timer:send_after(60000, self(), timeout),
                    jogo_loop(NovoRef, [From]);
                true ->
                    jogo_loop(TimerRef, [From | Pids])
            end;
        {timeout, TimerRef, timeout} ->
            Total = length(Pids),
            PartidaPid = spawn(fun() -> partida_loop(Total, 0, []) end),
            lists:foreach(fun(Pid) -> Pid ! {partida, PartidaPid} end, Pids),
            jogo_loop(undefined, [])
    end.

%---------- Processo da partida ----------
partida_loop(Total, Votaram, Apostas) ->
    receive
        {aposta, N, Media, From} ->
            NovoVotaram = Votaram + 1,
            NovasApostas = [{From, N, Media} | Apostas],
            if
                NovoVotaram == Total ->
                    % todos votaram: calcula a média e responde
                    MediaReal = calcular_media(NovasApostas, Total, 0),
                    responder(NovasApostas, MediaReal);
                true ->
                    partida_loop(Total, NovoVotaram, NovasApostas)
            end
    end.

%---------- Funções auxiliares recursivas ----------
calcular_media([], _Total, Soma) ->
    Soma div _Total;
calcular_media([{_, N, _} | T], Total, Soma) ->
    calcular_media(T, Total, Soma + N).

responder([], _MediaReal) ->
    ok;
responder([{Jogador, _, Palpite} | T], MediaReal) ->
    Jogador ! (Palpite == MediaReal),
    responder(T, MediaReal).