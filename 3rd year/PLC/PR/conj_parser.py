from conj_lexer import lexer 

prox_simb = None

def rec_C():
    global prox_simb 
    if prox_simb is None or 
def parser(str):
    global prox_simb
    lexer.input(str)
    prox_simb = lexer.token()
    print(prox_simb)
