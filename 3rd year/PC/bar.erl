-module(bar).
-export([create/1, entrar/1, sai/1]).

create(N) -> spawn(fun()-> bar(0,N,[]) end).

entrar(B) ->
    B ! {entra, self()},
    receive
        ok ->
            ok
    end.
sai(B) ->
    B ! {sai,self()}

bar(Ocupacao, N,Fila)->
    receive 
        {entra, Pid}->
            case Ocupacao < N of
                true -> 
                    Pid ! ok,
                    bar(Ocupacao+1,N,Fila);
                false ->
                    bar(Ocupacao, N, Fila ++ [Pid]);
            end;
        {sai, _Pid} ->
            case Fila of
                [] ->
                    bar(Ocupacao - 1, N, []);

                [Proximo | Resto] ->
                    Proximo ! ok,
                    bar(Ocupacao, N, Resto)
            end;
        end.
                
