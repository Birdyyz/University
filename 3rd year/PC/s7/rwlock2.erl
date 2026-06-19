-module(rwlock2).

-export([
    create/0,
    acquire/2,
    release/1
]).

%%====================================
%% API
%%====================================

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

%%====================================
%% Estado:
%% Readers       -> nº leitores ativos
%% WriterActive  -> escritor ativo?
%% Waiting       -> fila de espera
%%====================================

loop(Readers, WriterActive, Waiting) ->
    receive

        {acquire, Mode, Pid} ->
            handle_acquire(
                Mode,
                Pid,
                Readers,
                WriterActive,
                Waiting
            );

        {release, _Pid} ->
            handle_release(
                Readers,
                WriterActive,
                Waiting
            )
    end.