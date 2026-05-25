-module(room).
-export([create/1,entra/1,sai/1]).

create(N) -> spawn(fun() -> room(N,0,[]) end).

entra(R)->
    R ! {entra,self()}.

sai(R) ->
    R!{sai,self()}.

room(N,Ocupacao,Fila) ->
    receive
        {entra,Pid}->
            case Ocupacao < N of
                true ->
                    Pid ! ok,
                    room(N,Ocupacao+1,Fila);
                false ->
                    room(N,Ocupacao,Fila++[Pid]);
            end;
        {sai,Pid} ->
            case Fila of 
                [] -> 
                    room(N,Ocupacao -1, []);
                [Proximo | Resto]->
                    Proximo ! ok,
                    room(N,Ocupacao-1,Resto);
            end;
        end.