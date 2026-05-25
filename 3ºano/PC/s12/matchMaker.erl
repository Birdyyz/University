-module(matchmaker).
-export([create/0, wait_for_consumer/1, wait_for_producer/1]).

create() ->
    spawn(fun() -> matchmaker([], []) end).

wait_for_consumer(MM) ->
    MM ! {producer, self()},
    receive
        {ok, B} -> B
    end.

wait_for_producer(MM) ->
    MM ! {consumer, self()},
    receive
        {ok, B} -> B
    end.

matchmaker(ProdutoresEspera, ConsumidoresEspera) ->
    receive

        {producer, Pid} ->
            case ConsumidoresEspera of

                [] ->
                    % não há consumidor -> produtor fica à espera
                    matchmaker(
                        ProdutoresEspera ++ [Pid],
                        ConsumidoresEspera
                    );

                [ConsumidorPid | Resto] ->
                    B = make_buffer(),
                    Pid ! {ok, B},
                    ConsumidorPid ! {ok, B},
                    matchmaker(
                        ProdutoresEspera,
                        Resto
                    )
            end;

        {consumer, Pid} ->
            case ProdutoresEspera of

                [] ->
                    % não há produtor -> consumidor fica à espera
                    matchmaker(
                        ProdutoresEspera,
                        ConsumidoresEspera ++ [Pid]
                    );

                [ProdutorPid | Resto] ->
                    B = make_buffer(),
                    Pid ! {ok, B},
                    ProdutorPid ! {ok, B},
                    matchmaker(
                        Resto,
                        ConsumidoresEspera
                    )
            end

    end.
                
                
