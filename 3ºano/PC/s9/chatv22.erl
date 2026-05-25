-module(chatv22).
-export([start/1, stop/1]).
% prints faz-se no CLIENTE!

start(Port) -> 
  login_manager:start(), 
  spawn(fun() -> server(Port) end).

stop(Server) -> 
  Server ! stop,
  login_manager:stop(). 

startRM() ->
  spawn(fun() -> room_manager(#{}) end).

getRoom(RM,Name) ->
  RM ! {{get,Name}, self()},
  receive {room,Room} -> Room end.

room_manager(Map) ->
  receive
    {{get_room, RoomName}, From} ->
      case maps:find(RoomName, Map) of
        {ok, RoomPid} ->
          From ! {room, RoomPid},
          room_manager(Map);
        _ ->
          RoomPid = spawn(fun() -> room([]) end),
          From ! {room, RoomPid},
          (maps:put(RoomName, RoomPid, Map))
      end,
      From ! {room, RoomPid},
      room_manager(Map)
      end.

server(Port) ->
  {ok, LSock} = gen_tcp:listen(Port, [list, {packet, line}, {reuseaddr, true}]),
  login_manager:start(),
  RoomManager = startRM(),
  spawn(fun() -> acceptor(LSock, Room) end),
  receive stop -> ok end.

acceptor(LSock, RoomManager) ->
  {ok, Sock} = gen_tcp:accept(LSock),
  spawn(fun() -> acceptor(LSock, RoomManager) end),
  user(Sock, Room).

room(Pids) ->
  receive
    {enter, Pid} ->
      io:format("Username entered~n", []),
      room([Pid | Pids]);

    {line, User, Data} = Msg ->
      io:format("received ~p; ~p~n", [User,Data]),
      [Pid ! Msg || Pid <- Pids],
      room(Pids);

    {leave, Pid} ->
      io:format("Username left~n", []),
      room(Pids -- [Pid])
  end.

user(Sock, Room) ->
  receive
    {line, Data} ->
      gen_tcp:send(Sock, Data),
      user(Sock, Room);
    {tcp, _, Data} ->
      Room ! {line, Data},
      user(Sock, Room);
    {tcp_closed, _} ->
      Room ! {leave, self()};
    {tcp_error, _, _} ->
      Room ! {leave, self()}
  end.


user_not_in(Sock, RoomManager) ->
  receive
    {tcp, _, Data} ->
      case string:split(Data, " ", all) of 
        ["/create", User, Pass] ->
          case login_manager:create_account(User, Pass) of
            ok ->
              Room = getRoom("Lobby"),
              Room ! {enter, self()},
              user_in(Sock, "Lobby", Room, User, RoomManager);
            _ ->
              gen_tcp:send(Sock, "User already exists\n"),
              user_not_in(Sock, RoomManager)
          end;
        ["/login", User, Pass] ->
          case login_manager:login(User, Pass) of
            ok ->
              gen_tcp:send(Sock, "Login successful\n"),
              RoomPid ! {enter, self()},
              user_in(Sock, "Lobby", RoomPid, User, RoomManager);
            _ ->
              gen_tcp:send(Sock, "Invalid username or password\n"),
              user_not_in(Sock, RoomName, RoomPid, RoomManager)
          end;

        _ ->
          gen_tcp:send(Sock, "Use /create or /login\n"),
          user_not_in(Sock, RoomName, RoomPid, RoomManager)
      end;

    {tcp_closed, _} ->
      ok;

    {tcp_error, _, _} ->
      ok
  end.


user_in(Sock, RoomName, RoomPid, MyUser, RoomManager) ->
  receive
    {line, User,RoomName, Data} ->
      gen_tcp:send(Sock, [User ,"; ",RoomName, "; ", Data]),
      user_in(Sock, RoomName, RoomPid, MyUser, RoomManager);
    {tcp, _ , Data} ->
      Room !{line, MyUser, Data},
      user_in(Sock, RoomName, RoomPid, MyUser, RoomManager);
    {tcp_closed, _} ->
      RoomPid ! {leave, self()};
    {tcp_error, _, _} ->
      RoomPid ! {leave, self()}
  end.