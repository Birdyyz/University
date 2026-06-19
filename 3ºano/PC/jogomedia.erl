-module(jogomedia).
-export(start)

start(N,Media)-> spawn(fun()-> jogomedia_loop(N,Media,0,0)end).

partida(Pid) ->
    Pid !{participa,self()},
    receive 
        ok -> ok
    end.

aposta(Pid,Numero)->
    Pid !{aposta,Numero,self()},
    receive
        {resultado,R}-> R
    end.

jogomedia_loop(N,Media,Soma,Quantidade)->
    receive
        {participa,From} ->
            From ! ok,
            jogomedia_loop(N,Media,Soma,Quantidade)
        {aposta,Numero,self()} ->
            NovaSoma = Soma + Numero,
            NovaQuantidade = Quantidade +1,
            Res = NovaSoma/NovaQuantidade,
            if
                Res =:= Media ->
                    From !{resultado,true},
                    jogomedia_loop(N,Media,NovaSoma,NovaQuantidade);
                true ->
                    From !{resultado,false}
                    jogomedia_loop(N,Media,NovaSoma,NovaQuantidade);
                end.
end