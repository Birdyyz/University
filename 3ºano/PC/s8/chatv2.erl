-module(chatv2).
-export([start/1, stop/1]).
% prints faz-se no CLIENTE!

start(Port) -> 
  login_manager:start(), % o nosso login manager nao tem start, mas se tivesse era aqui que o chamavamos
  spawn(fun() -> server(Port) end).

stop(Server) -> 
  Server ! stop,
  login_manager:stop(). % o nosso login manager nao tem stop, mas se tivesse era aqui que o chamavamos

server(Port) ->
  {ok, LSock} = gen_tcp:listen(Port, [list, {packet, line}, {reuseaddr, true}]),
  login_manager:start(),
  Room = spawn(fun()-> room([]) end),
  spawn(fun() -> acceptor(LSock, Room) end),
  receive stop -> ok end.
  % ou podemos chamar o login_manager:stop() aqui

acceptor(LSock, Room) ->
  {ok, Sock} = gen_tcp:accept(LSock),
  spawn(fun() -> acceptor(LSock, Room) end),
  user(Sock, Room).

% utilizador ja esta autenticado
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

%
user_not_in(Sock, Room) ->
  receive
    {tcp, _, Data} ->
      case stringsplit(Data, " ",all) of 
        ["/create", User, Pass] ->
          case login_manager:create_account(User, Pass) of
            ok ->
              gen_tcp:send(Sock, "Account created");
              login_manager:login(User, Pass) -> % esta parte depende de como esta o login manager
              gen_tcp:send(Sock, "Login successful"), 
              Room ! {enter, self()},
              user_in(Sock, Room,User);
              _ ->
                gen_tcp:send(Sock, "User already exists"),
                user_not_in(Sock, Room);
          end,

        ["/login", User, Pass] ->
          case login_manager:login(User, Pass) of
            ok ->
              gen_tcp:send(Sock, "Login successful"),
              user_in(Sock, Room,User);
            _ ->
              gen_tcp:send(Sock, "Invalid username or password")
              user_not_in(Sock, Room);
          end;
        
        _ ->
          gen_tcp:send(Sock, "Create account")
      end,
    {tcp_closed, _} ->
      ok
    {tcp_error, _, _} ->
      ok
  end.

user_in(Sock, Room,User) ->
  receive
    {line, User, Data} ->
      gen_tcp:send(Sock, [User ,"; ",Data]),
      user_in(Sock, Room, User);
    {tcp, _, Data} ->
      Room ! {line, User, Data},
      user_in(Sock, Room, User);
    {tcp_closed, _} ->
      Room ! {leave, self()};
    {tcp_error, _, _} ->
      Room ! {leave, self()}
  end.