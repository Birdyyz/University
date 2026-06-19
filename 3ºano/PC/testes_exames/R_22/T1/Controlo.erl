-module(controller).
-export([start/1, request_resource/2, release_resource/2]).

%---------- Interface para clientes ----------
start(T) ->
    spawn(fun() -> server_loop(-1, 0, [], [], T) end).

request_resource(Server_Pid, Recurso) ->
    Server_Pid ! {request, Recurso, self()},
    receive
        {granted, Recurso} -> ok
    end.

release_resource(Server_Pid, Recurso) ->
    Server_Pid ! {release, Recurso}.

%---------- Servidor ----------
server_loop(Active, Count, Wait0, Wait1, T) ->
    receive
        {request, I, From} ->
            if
                Active == -1 ->
                    From ! {granted, I},
                    server_loop(I, 1, Wait0, Wait1, T);
                Active == I, Count < T ->
                    From ! {granted, I},
                    server_loop(Active, Count + 1, Wait0, Wait1, T);
                Active == I ->
                    case I of
                        0 -> server_loop(Active, Count, [From | Wait0], Wait1, T);
                        1 -> server_loop(Active, Count, Wait0, [From | Wait1], T)
                    end;
                true ->
                    case I of
                        0 -> server_loop(Active, Count, [From | Wait0], Wait1, T);
                        1 -> server_loop(Active, Count, Wait0, [From | Wait1], T)
                    end
            end;
        {release, I} ->
            NewCount = Count - 1,
            if
                NewCount > 0 ->
                    {NewWait0, NewWait1} = wake_one(Active, Wait0, Wait1),
                    server_loop(Active, NewCount, NewWait0, NewWait1, T);
                NewCount == 0 ->
                    lists:foreach(fun(Pid) -> Pid ! {granted, 0} end, Wait0),
                    lists:foreach(fun(Pid) -> Pid ! {granted, 1} end, Wait1),
                    server_loop(-1, 0, [], [], T)
            end
    end.

%---------- Função auxiliar ----------
wake_one(0, [Pid | Rest], Wait1) ->
    Pid ! {granted, 0},
    {Rest, Wait1};
wake_one(1, Wait0, [Pid | Rest]) ->
    Pid ! {granted, 1},
    {Wait0, Rest};
wake_one(_, Wait0, Wait1) ->
    {Wait0, Wait1}.


