-module(sondagens).
-export([start/0, vota/2, espera/4]).

start() ->
    spawn(fun() -> sondagem_loop(#{}, []) end).

vota(Pid, Candidato) ->
    Pid ! {vota, Candidato}.            % assíncrono, não precisa de self()

espera(Pid, C1, C2, C3) ->
    Pid ! {espera, C1, C2, C3, self()},
    receive
        ok -> ok
    end.

sondagem_loop(Votos, Pendentes) ->
    receive
        {vota, Candidato} ->
            Velho = maps:get(Candidato, Votos, 0),
            NovoVotos = maps:put(Candidato, Velho + 1, Votos),
            % processa os pedidos pendentes com o novo mapa
            NovaLista = processar_pendentes(Pendentes, NovoVotos),
            sondagem_loop(NovoVotos, NovaLista);

        {espera, C1, C2, C3, From} ->
            % verifica se a condição já é verdadeira agora
            V1 = maps:get(C1, Votos, 0),
            V2 = maps:get(C2, Votos, 0),
            V3 = maps:get(C3, Votos, 0),
            case (V3 > V1) andalso (V3 > V2) of
                true ->
                    From ! ok,
                    sondagem_loop(Votos, Pendentes);
                false ->
                    % adiciona o pedido à lista de pendentes
                    sondagem_loop(Votos, [{C1, C2, C3, From} | Pendentes])
            end
    end.

% Função recursiva que percorre os pendentes, acorda os satisfeitos e devolve os restantes
processar_pendentes([], _Votos) ->
    [];
processar_pendentes([{C1, C2, C3, From} = P | T], Votos) ->
    V1 = maps:get(C1, Votos, 0),
    V2 = maps:get(C2, Votos, 0),
    V3 = maps:get(C3, Votos, 0),
    case (V3 > V1) andalso (V3 > V2) of
        true ->
            From ! ok,
            processar_pendentes(T, Votos);   % remove o pedido
        false ->
            [P | processar_pendentes(T, Votos)] % mantém o pedido
    end.