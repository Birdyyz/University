-module(jogo).

-export([create/0, participa/1, adivinha/2]).

%% =====================================================
%% Interface
%% =====================================================

create() ->
    spawn(fun() -> jogo([]) end).

participa(Jogo) ->
    Jogo ! {participa, self()},
    receive
        {partida, Partida} ->
            Partida
    end.

adivinha(Partida, N) ->
    Partida ! {adivinha, N, self()},
    receive
        {result, Res} ->
            Res
    end.

%% =====================================================
%% Processo gestor das partidas
%% =====================================================

jogo(Jogadores) when length(Jogadores) =:= 4 ->

    Numero = rand:uniform(100),

    Partida =
        spawn(fun() ->
            partida(Numero, 100, false, false)
        end),

    %% entrega a partida aos 4 jogadores
    [J ! {partida, Partida} || J <- Jogadores],

    %% processo responsável pelo timeout
    spawn(fun() ->
        receive
        after 60000 ->
            Partida ! timeout
        end
    end),

    jogo([]);

jogo(Jogadores) ->
    receive
        {participa, Jogador} ->
            jogo([Jogador | Jogadores])
    end.

%% =====================================================
%% Processo da partida
%% Estado:
%% Numero      -> número secreto
%% Tentativas  -> tentativas restantes
%% Ganhou      -> já existe vencedor?
%% Timeout     -> tempo esgotado?
%% =====================================================

partida(Numero, Tentativas, Ganhou, Timeout) ->

    receive

        timeout ->
            partida(Numero, Tentativas, Ganhou, true);

        {adivinha, N, Jogador} ->

            {Resposta, NovoGanhou, NovasTentativas} =

                if
                    Ganhou ->
                        {"PERDEU", Ganhou, Tentativas};

                    Timeout ->
                        {"TEMPO", Ganhou, Tentativas};

                    Tentativas =< 0 ->
                        {"TENTATIVAS", Ganhou, Tentativas};

                    N =:= Numero ->
                        {"GANHOU", true, Tentativas - 1};

                    N < Numero ->
                        {"MAIOR", Ganhou, Tentativas - 1};

                    true ->
                        {"MENOR", Ganhou, Tentativas - 1}
                end,

            Jogador ! {result, Resposta},

            partida(
                Numero,
                NovasTentativas,
                NovoGanhou,
                Timeout
            )
    end.