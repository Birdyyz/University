-module(controller).
-export([create/1,request_resource/2,release_resource/2]).
create(T) ->
    spawn(fun() -> controller(-1,0,T,[]) end).

request_resource(Controller, I) ->
    Controller ! {request, I, self()},
    receive
        {ok, I} ->
            I
    end.

release_resource(Controller, I) ->
    Controller ! {release, I, self()}.

controller(RecursoAtual, EmUso, T, Fila) ->
    receive

        {request,I,Pid} ->
            case possible(I,RecursoAtual,EmUso,T) of

                true ->
                    NovoRecurso =
                        case RecursoAtual of
                            -1 -> I;
                            _  -> RecursoAtual
                        end,

                    NovoEmUso = EmUso + 1,

                    Pid ! {ok,I},

                    controller(NovoRecurso, NovoEmUso, T, Fila);

                false ->
                    controller(RecursoAtual, EmUso, T, Fila ++ [{I,Pid}])
            end,

        {release,_I,_Pid} ->

            NovoEmUso = EmUso - 1,

            case NovoEmUso of

                0 ->
                    NovoRecurso = -1,

                    case Fila of
                        [] ->
                            controller(NovoRecurso, 0, T, []);

                        [{RI,RPid} | Resto] ->
                            RPid ! {ok, RI},
                            controller(RI, 1, T, Resto)
                    end;

                _ ->
                    controller(RecursoAtual, NovoEmUso, T, Fila)
            end
    end.