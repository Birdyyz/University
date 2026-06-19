from paren_lexer import lexer

prox_simb = None
def processa_terminal(tipo):
    global prox_simb 
    if tipo == prox_simb.type:
        prox_simb = lexer.token()
    else:
        raise ValueError("Invalid token")
    
def rec_S():
    global prox_simb 
    if prox_simb is None or prox_simb.type == "PF":
        print("S -> ε")
        pass
    elif prox_simb.type == 'PA':
        processa_terminal("PA")
        rec_S()
        processa_terminal("PF")
        rec_S()
    else:
        raise ValueError("Invalid token")


def parser(str):
    global prox_simb
    lexer.input(str)
    prox_simb = lexer.token()
    print(prox_simb)
    rec_S()
parser("(()())")
