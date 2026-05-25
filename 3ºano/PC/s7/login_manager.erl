-module(login_manager).

-export([
    start/0,
    create_account/2,
    close_account/2,
    login/2,
    logout/1,
    online/0
]).
%% escreva um módulo que implemente um gestor de logins que permita a criação de contas bem como controlar o login/logout de utilizadores

%% Inicializa o servidor
% Esta função cria o processo servidor que vai gerir os utilizadores e devolve o PID desse processo.
start() ->
    %spawn cria um novo processo Erlang.
    % Quando o processo é criado, executa loop(#{} ):
    % #{} é um mapa vazio que representa o estado inicial do servidor, onde não há utilizadores registados.
    % spawn devolve o PID do processo criado.
    Pid = spawn(fun() -> loop(#{} ) end),
    % Regista o processo com um nome.
    % ?MODULE refere-se ao nome do do ficheiro
    register(?MODULE, Pid),
    Pid.

%% Função auxiliar para chamadas ao servidor
rpc(Request) ->
    ?MODULE ! {Request, self()},
    receive
        {?MODULE, Res} -> Res
    end.

%% API pública
% Apenas enviam mensagens ao processo servidor através de rpc/1, que trata da lógica e devolve o resultado.
create_account(Username, Passwd) ->
    rpc({create_account, Username, Passwd}).

close_account(Username, Passwd) ->
    rpc({close_account, Username, Passwd}).

login(Username, Passwd) ->
    rpc({login, Username, Passwd}).

logout(Username) ->
    rpc({logout, Username}).

online() ->
    rpc(online).

%% Ciclo principal do servidor

loop(State) ->
    % espera até receber uma mensagem
    receive
        % Request: o pedido (login, create_account, etc.)
        % From: quem pediu (PID do cliente)
        {Request, From} ->
            {Reply, NewState} = handle(Request, State),
            From ! {?MODULE, Reply},
            loop(NewState)
    end.

%% Tratamento dos pedidos

handle({create_account, Username, Passwd}, Map) ->
    case maps:find(Username, Map) of
        error ->
            {ok, maps:put(Username, {Passwd, false}, Map)};
        {ok, _} ->
            {user_exists, Map}
    end;

handle({close_account, Username, Passwd}, Map) ->
    case maps:find(Username, Map) of
        {ok, {Passwd, _}} ->
            {ok, maps:remove(Username, Map)};
        _ ->
            {invalid, Map}
    end;

handle({login, Username, Passwd}, Map) ->
    case maps:find(Username, Map) of
        {ok, {Passwd, _}} ->
            {ok, maps:put(Username, {Passwd, true}, Map)};
        _ ->
            {invalid, Map}
    end;

handle({logout, Username}, Map) ->
    case maps:find(Username, Map) of
        {ok, {Passwd, _}} ->
            {ok, maps:put(Username, {Passwd, false}, Map)};
        _ ->
            {invalid, Map}
    end;

handle(online, Map) ->
    Users =
        [Username ||
            {Username, {_, true}} <- maps:to_list(Map)],
    {Users, Map}.