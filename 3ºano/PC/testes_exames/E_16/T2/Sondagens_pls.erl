



-module(sondagens).
-export([start/0, vota/2, espera/4]).

start() ->
    spawn(fun() -> loop(#{}, []) end).

vota(Pid, Cand) ->
    Pid ! {vota, Cand}.

espera(Pid, C1, C2, C3) ->
    Pid ! {espera, C1, C2, C3, self()},
    receive ok -> ok end.

loop(Map, Pendentes) ->
    receive
        {vota, Cand} ->
            Val = maps:get(Cand, Map, 0) + 1,
            NovoMap = maps:put(Cand, Val, Map),
            Pendentes2 = acordar(Pendentes, NovoMap),
            loop(NovoMap, Pendentes2);
        {espera, C1, C2, C3, From} ->
            V1 = maps:get(C1, Map, 0),
            V2 = maps:get(C2, Map, 0),
            V3 = maps:get(C3, Map, 0),
            if
                (V1 < V2) andalso (V2 < V3) ->
                    From ! ok,
                    loop(Map, Pendentes);
                true ->
                    loop(Map, [{C1,C2,C3,From} | Pendentes])
            end
    end.

acordar([], _) -> [];
acordar([{C1,C2,C3,From}|T], Map) ->
    V1 = maps:get(C1, Map, 0),
    V2 = maps:get(C2, Map, 0),
    V3 = maps:get(C3, Map, 0),
    if
        (V1 < V2) andalso (V2 < V3) ->
            From ! ok,
            acordar(T, Map);
        true ->
            [{C1,C2,C3,From} | acordar(T, Map)]
    end.


