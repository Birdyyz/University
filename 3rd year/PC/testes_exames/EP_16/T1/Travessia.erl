

-module(travessia).
-export([start/0, inicioTravessiaIda/1, inicioTravessiaVolta/1,fimTravessia/1]).

start() ->
    spawn(fun() -> loop(10,0,[],[])end).



inicioTravessiaIda(Serv) ->
    Serv ! {ida, self()},
    receive
        ok -> ok
    end.

inicioTravessiaVolta(Serv) ->
    Serv ! {volta, self()},
    receive
        ok -> ok
    end.

fimTravessia(Serv) ->
    Serv ! {fim, self()}.            % não precisa de resposta




loop(Maximo, Atual, IdaQ, VoltaQ) ->
    receive
        {ida, From} ->
            if 
                Atual < Maximo, Volta == []  ->
                    From ! ok,
                    travessia_loop(Maximo,Atual+1,IdaQ, VoltaQ),

                true ->
                    travessia_loop(Maximo,Atual,[From|IdaQ],VoltaQ)
            end;
        
        {volta, From} ->
            if
                Atual < Maximo ->
                    From ! ok,
                    travessia_loop(Maximo,Atual+1,IdaQ, VoltaQ),
                true ->
                    travessia_loop(Maximo,Atual,IdaQ,[From|VoltaQ])
        
        [fim, From] ->
            NovoAtual = Atual - 1;
            {NovoIdaQ,NovoVoltaQ} = acordar_proximo(Maximo, Atual, IdaQ, VoltaQ),
            travessia_loop(Maximo,Atual-1,NovoIdaQ,NovoVoltaQ)


acordar_proximo(IdaQ, VoltaQ, Atual, Max) ->
    if
        Atual < Max, VoltaQ /= [] ->
            [VoltaPid | VoltaT] = VoltaQ,
            VoltaPid ! ok,
            {IdaQ, VoltaT, Atual + 1};
        Atual < Max, IdaQ /= [] ->
            [IdaPid | IdaT] = IdaQ,
            IdaPid ! ok,
            {IdaT, VoltaQ, Atual + 1};
        true ->
            {IdaQ, VoltaQ, Atual}
    end.























