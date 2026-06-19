


-module(travessia).
-export([start/0, inicioTravessiaIda/1, inicioTravessiaVolta/1, fimTravessia/1]).

%---------- Interface para os clientes ----------
start() ->
    spawn(fun() -> loop(10, 0, [], []) end).   % Max, Atual, Ida, Volta

inicioTravessiaIda(Pid) ->
    Pid ! {ida, self()},
    receive
        ok -> ok
    end.

inicioTravessiaVolta(Pid) ->
    Pid ! {volta, self()},
    receive
        ok -> ok
    end.

fimTravessia(Pid) ->
    Pid ! {fim, self()}.            % não espera resposta

%---------- Servidor ----------
loop(Max, Atual, Ida, Volta) ->
    receive
        {ida, From} ->
            % Pode atravessar se ponte não cheia E não houver ninguém à espera para voltar
            if
                Atual < Max, Volta == [] ->
                    From ! ok,
                    loop(Max, Atual + 1, Ida, Volta);
                true ->
                    loop(Max, Atual, [From | Ida], Volta)
            end;
        {volta, From} ->
            % Pode atravessar se ponte não cheia (volta tem prioridade)
            if
                Atual < Max ->
                    From ! ok,
                    loop(Max, Atual + 1, Ida, Volta);
                true ->
                    loop(Max, Atual, Ida, [From | Volta])   % adiciona à lista de volta
            end;
        {fim, _From} ->
            NovoAtual = Atual - 1,
            % Após sair, tenta acordar alguém, com prioridade a Volta
            {NovaIda, NovaVolta, NovoAtual2} = acordar_proximo(Ida, Volta, NovoAtual, Max),
            loop(Max, NovoAtual2, NovaIda, NovaVolta)
    end.

%---------- Lógica de acordar o próximo ----------
% Primeiro tenta a fila de volta, depois a de ida.
acordar_proximo(Ida, [VoltaPid | VoltaT], Atual, Max) when Atual < Max ->
    VoltaPid ! ok,
    acordar_proximo(Ida, VoltaT, Atual + 1, Max);
acordar_proximo([IdaPid | IdaT], Volta, Atual, Max) when Atual < Max ->
    IdaPid ! ok,
    acordar_proximo(IdaT, Volta, Atual + 1, Max);
acordar_proximo(Ida, Volta, Atual, _Max) ->
    {Ida, Volta, Atual}.





