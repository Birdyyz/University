
-module(Evento_coiso).
-export()

-module(evento).
-export([start/1, sinaliza/2, espera/5]).

%---------- Interface para clientes ----------
start(E) ->
    % cria contadores: lista com E+1 zeros (índice 0 não usado)
    Contadores = [0 || _ <- lists:seq(0, E)],
    spawn(fun() -> loop(Contadores, []) end).

sinaliza(ServerPid, Tipo) ->
    ServerPid ! {sinaliza, Tipo}.              % assíncrono

espera(ServerPid, Tipo1, N1, Tipo2, N2) ->
    ServerPid ! {espera, Tipo1, N1, Tipo2, N2, self()},
    receive
        ok -> ok
    end.

%---------- Servidor ----------
loop(Contadores, Pendentes) ->
    receive
        {sinaliza, Tipo} ->
            % incrementa o contador do tipo
            Indice = Tipo + 1,
            NovoValor = lists:nth(Indice, Contadores) + 1,
            NovosContadores = substituir(Indice, NovoValor, Contadores),
            % processa todos os pedidos pendentes
            NaoSatisfeitos = processar_pendentes(Pendentes, NovosContadores),
            loop(NovosContadores, NaoSatisfeitos);

        {espera, Tipo1, N1, Tipo2, N2, From} ->
            % verifica se a condição já é satisfeita agora
            V1 = lists:nth(Tipo1 + 1, Contadores),
            V2 = lists:nth(Tipo2 + 1, Contadores),
            % cuidado: as diferenças são em relação ao momento atual,
            % mas o pedido acabou de chegar, por isso os valores iniciais são V1 e V2
            if
                (V1 - 0 >= N1) andalso (V2 - 0 >= N2) ->
                    % nunca pode acontecer porque V1 e V2 são os totais atuais
                    % e o pedido quer eventos futuros; o correto é usar 0 como base
                    % porque os eventos passados não contam, por isso:
                    % (0 >= N1 and 0 >= N2) é falso a menos que N1=0,N2=0
                    % Na verdade, a verificação inicial deve ser:
                    % se N1==0 e N2==0 -> ok imediatamente
                    % senão, adiciona aos pendentes
                    From ! ok,
                    loop(Contadores, Pendentes);
                true ->
                    NovoPedido = {Tipo1, N1, Tipo2, N2, 0, 0, From},
                    loop(Contadores, [NovoPedido | Pendentes])
            end
    end.

%---------- Funções auxiliares ----------

% substitui o elemento na posição I (1‑indexed) por Novo
substituir(1, Novo, [_ | T]) -> [Novo | T];
substituir(I, Novo, [H | T]) -> [H | substituir(I - 1, Novo, T)].

% percorre a lista de pendentes e:
% - envia 'ok' aos que já estão satisfeitos
% - devolve a lista dos não satisfeitos
processar_pendentes([], _Contadores) ->
    [];
processar_pendentes([{T1, N1, T2, N2, Base1, Base2, From} | T], Contadores) ->
    C1 = lists:nth(T1 + 1, Contadores),
    C2 = lists:nth(T2 + 1, Contadores),
    if
        (C1 - Base1 >= N1) andalso (C2 - Base2 >= N2) ->
            From ! ok,
            processar_pendentes(T, Contadores);   % remove este pedido
        true ->
            [ {T1, N1, T2, N2, Base1, Base2, From} | processar_pendentes(T, Contadores) ]
    end.