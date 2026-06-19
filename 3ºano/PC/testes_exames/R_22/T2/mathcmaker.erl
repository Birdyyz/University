-module(matchmaker).


-export([start/0, waitForConsumer/1, waitForProducer/1]).

start() ->
    spawn(fun() -> matchmaker_loop([],[])end).



waitForConsumer(Server_Pid)->
    Server_Pid ! {espera_consumer, self()},
    receive
        {buffer, BufferPid} -> BufferPid
    end.





waitForProducer(Server_Pid)->
    Server_Pid ! {espera_producer, self()},
    receive
        {buffer, BufferPid} -> BufferPid
    end.



matchmaker_loop(Consumer, Producer) ->
    receive
        {espera_consumer, From} ->
            case Consumer of
                [] ->
                    matchmaker_loop(Consumer, Producer ++ [From]);  % FIFO
                [C | Resto] ->
                    BufferPid = spawn_buffer(),
                    From ! {buffer, BufferPid},
                    C ! {buffer, BufferPid},
                    matchmaker_loop(Resto, Producer)
            end;
        {espera_producer, From} ->
            case Producer of
                [] ->
                    matchmaker_loop(Consumer ++ [From], Producer);  % FIFO
                [P | Resto] ->
                    BufferPid = spawn_buffer(),
                    From ! {buffer, BufferPid},
                    P ! {buffer, BufferPid},
                    matchmaker_loop(Consumer, Resto)
            end
    end.




spawn_buffer() ->
    spawn(fun() -> buffer_loop([]) end).


buffer_loop(Items) ->
    receive
        {put, Item} ->
            buffer_loop([Item | Items]);
        {get, From} ->
            case Items of
                [] ->
                    From ! empty,               % átomo simples
                    buffer_loop([]);
                [Item | T] ->
                    From ! Item,                % item diretamente
                    buffer_loop(T)
            end
    end.























