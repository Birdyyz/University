

start(E) ->
    Contadores = [0 || _ <- list:seq(0,E)],
    spawn(fun() -> evento_loop(...)end).


sinaliza(ServidorPid, Tipo) ->
    ServidorPid ! {sinaliza, Tipo}






espera(Evento) ->
    ServidorPid ! {espera, Tipo1, N1, Tipo2, N2, self()}
    receive
        ok -> ok
    end.







evento_loop(Contadores, Pendentes) ->
    receive
        {sinaliza, Tipo} ->
            Indice = Tipo + 1,
            Velho = lists:nth(Indice, Contadores),
            Novo = Velho + 1,
            NovosContadores = substituir(Indice, Novo, Contadores),
            
            Satisfeitos = [P || P <- Pendentes, verifica(P,NovosContadores)],
            NaoSatisfeitos = [ P || P <- Pendentes, not verifica(P, NovosContadores) ],

            list:foreach(fun({_, _, _, _, _, _, From}) -> From ! ok end, Satisfeitos),
            evento_loop(NovosContadores, NaoSatisfeitos);
        
        {espera, Tipo1, N1, Tipo2, N2, From} ->
            Inicio1 = lists:nth(Tipo1 + 1, Contadores),
            Inicio2 = lists:nth(Tipo1 + 2, Contadores),
            NovoPedido = {Tipo1, N1, Tipo2, N2,Inicio1,Inicio2,From},
            evento_loop(Contadores, [NovoPedido|Pendentes])
        end.


verifica({Tipo1, N1, Tipo2, N2,Inicio1,Inicio2,From},Contadores) ->
    C1 = lists:nth(Tipo1 + 1, Contadores),
    C2 = lists:nth(Tipo2 + 1, Contadores),
    if (C1 - Inicio1 >= N1) andalso (C2 - Inicio2 >= N2).


substituir(1,Novo,[_|T]) -> [Novo|T];
substituir(I,Novo,[H|T]) -> [H|substituir(I-1,Novo,[H|T])].



















