-module(rwlock).

-export([
    create/0,
    acquire/2,
    release/1
]).

%%====================================================
%% API
%%====================================================

create() ->
    spawn(fun() ->
        loop(0, false, queue:new())
    end).

acquire(Lock, Mode) ->
    Lock ! {acquire, Mode, self()},
    receive
        ok -> ok
    end.

release(Lock) ->
    Lock ! {release, self()},
    ok.

%%====================================================
%% Estado:
%%
%% Readers       -> número de leitores ativos
%% WriterActive  -> existe escritor ativo?
%% Waiting       -> fila de pedidos
%%====================================================

loop(Readers, WriterActive, Waiting) ->

    receive

        %%==============================
        %% Pedido de leitura
        %%==============================

        {acquire, read, Pid}
            when WriterActive =:= false ->

            case queue:is_empty(Waiting) of

                true ->
                    Pid ! ok,
                    loop(Readers + 1,
                         WriterActive,
                         Waiting);

                false ->
                    loop(
                        Readers,
                        WriterActive,
                        queue:in({read, Pid}, Waiting)
                    )
            end;

        %%==============================
        %% Pedido de escrita
        %%==============================

        {acquire, write, Pid}
            when Readers =:= 0,
                 WriterActive =:= false,
                 queue:is_empty(Waiting) ->

            Pid ! ok,
            loop(Readers,
                 true,
                 Waiting);

        %%==============================
        %% Leitura bloqueada
        %%==============================

        {acquire, read, Pid} ->

            loop(
                Readers,
                WriterActive,
                queue:in({read, Pid}, Waiting)
            );

        %%==============================
        %% Escrita bloqueada
        %%==============================

        {acquire, write, Pid} ->

            loop(
                Readers,
                WriterActive,
                queue:in({write, Pid}, Waiting)
            );

        %%==============================
        %% Libertação
        %%==============================

        {release, _Pid}
            when WriterActive =:= true ->

            grant_next(
                Readers,
                false,
                Waiting
            );

        {release, _Pid}
            when Readers > 0 ->

            NewReaders = Readers - 1,

            case NewReaders of
                0 ->
                    grant_next(
                        0,
                        WriterActive,
                        Waiting
                    );
                _ ->
                    loop(
                        NewReaders,
                        WriterActive,
                        Waiting
                    )
            end
    end.