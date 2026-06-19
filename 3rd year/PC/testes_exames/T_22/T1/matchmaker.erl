

-module(matchmaker).
-export([start/0, waitForConsumer/1, waitForProducer/1]).

%---------- Interface para clientes ----------
start() ->
    spawn(fun() -> loop([], []) end).   % Produtores, Consumidores

waitForConsumer(MatchMakerPid) ->
    MatchMakerPid ! {wait_consumer, self()},
    receive
        {buffer, BufferPid} -> BufferPid
    end.

waitForProducer(MatchMakerPid) ->
    MatchMakerPid ! {wait_producer, self()},
    receive
        {buffer, BufferPid} -> BufferPid
    end.

%---------- Servidor MatchMaker ----------
loop(Producers, Consumers) ->
    receive
        {wait_consumer, From} ->
            % Chegou um produtor (waitForConsumer é chamado pelo produtor)
            case Consumers of
                [] ->
                    % Não há consumidores: adiciona o produtor à lista
                    loop([From | Producers], []);
                [C | Rest] ->
                    % Há pelo menos um consumidor: forma um par
                    BufferPid = spawn_buffer(),
                    From ! {buffer, BufferPid},
                    C ! {buffer, BufferPid},
                    loop(Producers, Rest)   % continua com produtores restantes e consumidores sem o primeiro
            end;
        {wait_producer, From} ->
            % Chegou um consumidor
            case Producers of
                [] ->
                    loop([], [From | Consumers]);
                [P | Rest] ->
                    BufferPid = spawn_buffer(),
                    P ! {buffer, BufferPid},
                    From ! {buffer, BufferPid},
                    loop(Rest, Consumers)
            end
    end.

%---------- Buffer (versão mínima) ----------
spawn_buffer() ->
    spawn(fun() -> buffer_loop([]) end).

buffer_loop(Items) ->
    receive
        {put, Item} ->
            buffer_loop([Item | Items]);
        {get, From} ->
            case Items of
                [] ->
                    % buffer vazio: podia esperar, mas para simplificar devolve vazio
                    From ! {empty},
                    buffer_loop([]);
                [H | T] ->
                    From ! {value, H},
                    buffer_loop(T)
            end
    end.
    
        


                

                
                    








