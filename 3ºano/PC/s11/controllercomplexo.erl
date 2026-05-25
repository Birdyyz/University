-module(controllercomplexo).
-export([create/1]).

create(T) ->
    spawn(fun() -> controller(-1, 0, T, []) end).

controller(RecursoAtual, EmUso, T, Fila) ->
    receive

        {request, I, Pid} ->
            case possible(I, RecursoAtual, EmUso, T) of

                true ->
                    NovoRecurso =
                        case RecursoAtual of
                            -1 -> I;
                            _  -> RecursoAtual
                        end,

                    Pid ! {ok, I},

                    controller(
                        NovoRecurso,
                        EmUso + 1,
                        T,
                        Fila
                    );

                false ->
                    controller(
                        RecursoAtual,
                        EmUso,
                        T,
                        Fila ++ [{I, Pid}]
                    )
            end;

        {release, _I, _Pid} ->

            NovoEmUso = EmUso - 1,

            NovoRecurso =
                case NovoEmUso of
                    0 -> -1;
                    _ -> RecursoAtual
                end,

            case escolhe(Fila, NovoRecurso, NovoEmUso, T) of

                none ->
                    controller(
                        NovoRecurso,
                        NovoEmUso,
                        T,
                        Fila
                    );

                {{RI, RPid}, NovaFila} ->

                    RecursoDepois =
                        case NovoRecurso of
                            -1 -> RI;
                            _  -> NovoRecurso
                        end,

                    RPid ! {ok, RI},

                    controller(
                        RecursoDepois,
                        NovoEmUso + 1,
                        T,
                        NovaFila
                    )
            end
    end.

escolhe([], _RecursoAtual, _EmUso, _T) ->
    none;

escolhe([{I,Pid} | Resto], RecursoAtual, EmUso, T) ->
    case possible(I, RecursoAtual, EmUso, T) of

        true ->
            {{I,Pid}, Resto};

        false ->
            case escolhe(Resto, RecursoAtual, EmUso, T) of

                none ->
                    none;

                {Elem, NovoResto} ->
                    {Elem, [{I,Pid} | NovoResto]}
            end
    end.