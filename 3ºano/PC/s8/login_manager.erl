-module(login_manager).
-export([create_account/2, 
        close_account/2, 
        login/2, 
        logout/1, 
        online/0]).

start() -> 
    Pid = spawn(fun() -> loop(#{}) end),
    %Pid = spawn(fun() -> loop(maps:new()) end),
    %register(login_manager , Pid).
    register(?MODULE, Pid).

rpc(Request)->
    ?MODULE ! {Request, self()},
    receive {?MODULE, Res} -> Res end.

create_account(Username, Passwd) ->
    rpc({create_account, Username, Passwd}).
    %?MODULE ! {create_account, Username, Passwd, self()},
    %receive {?MODULE, Res} -> Res end.

close_account(Username, Passwd) -> 
    rpc({close_account, Username, Passwd}).
    %?MODULE ! {close_account, Username, Passwd, self()},
    %receive {?MODULE, Res} -> Res end.


login(Username, Passwd) -> rpc({login, Username, Passwd}).
logout(Username) -> rpc([logout, Username]).
online() -> rpc(online).

%loop(Map) ->
%    receive
%        {create_account, Username, Passwd}, From} ->
%            case maps:find(Username, Map) of
%                error -> 
%                    From ! {?MODULE, ok},
%                    loop(maps:put(Username, {Passwd,true}, Map));
%                {ok, _} ->
%                    From ! {?MODULE, user_exists},
%                    loop(Map)
%            end;
%           loop()
%    end.


loop(Map) ->
    receive
        {{create_account, Username, Passwd}, From} ->
            case maps:find(Username, Map) of
                error -> 
                    From ! {?MODULE, ok},
                    loop(maps:put(Username, {Passwd,true}, Map));
                {ok, _} ->
                    From ! {?MODULE, user_exists},
                    loop(Map)
            end;

        {{close_account, Username, Passwd}, From} ->
            case maps:find(Username,Map) of 
                {ok, {Passwd, _}} ->
                    From ! {?MODULE, ok},
                    loop(maps:remove(Username, Map));
                 ->
                    From ! {?MODULE, invalid},
                    loop(Map);
            end;

        {{login, Username, Passwd}, From} ->
            case maps:find(Username, Map) of
                {ok, {Passwd, _}} ->
                    From ! {?MODULE, ok},
                    loop(maps:put(Username, {Passwd,true}, Map));
                ->
                    From ! {?MODULE, user_not_found},
                    loop(Map);
            end;

        {{logout, Username}, From} ->
            case maps:find(Username, Map) of
                    {ok, {Passwd, _}} ->
                        From ! {?MODULE, ok},
                        loop(maps:put(Username,{ Passwd, false}, Map));
                    ->
                        From ! {?MODULE, user_not_found},
                        loop(Map);
            end;

        {{online}, From} ->


            loop()
    end.

loop(State) ->
    {Request,From} ->
        {Res,NextState} = handle(Request, State),
        From ! {?MODULE, Res},
        loop(NextState).
    end.

handle({{create_account,  Username, Passwd}, Map} ->
    case maps:find(Username, Map) of
        error -> 
            {ok, maps:put(Username, {Passwd,true}, Map)};
        {ok, _} ->
            {user_exists,Map},
    end;)