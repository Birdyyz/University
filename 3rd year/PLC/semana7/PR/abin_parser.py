from abin_lexer import lexer 

prox_symb = None 

def process_terminal(term):
    global prox_symb
    if prox_symb.type == term:
        prox_symb = lexer.token()
    else:
        raise ValueError("Invalid syntax.", term , "got", prox_symb)

def ACONT():
    global prox_symb
    if prox_symb == "INT":
        val = int(process_terminal("NUM"))
        resl = ABIN()
        resd = ABIN()
        return val+resl+resd
    elif prox_symb.type == "PF":
        return 
    else:
        raise ValueError("Invalid syntax.")
# INT PA PF
# P1: ABIN -> PA ACONT
# P2: ACONT -> ε
#            | INT ABIN ABIN PF
#First(ACONT -> INT ABIN ABIN) = {INT}
#First(ACONT -> ε) = {PF}

def ABIN():
    global prox_symb
    if prox_symb.type == "PA":
        process_terminal("PA")
        val = ACONT()
        process_terminal("PF")
        return val 
    else:
        raise ValueError("Invalid syntax.")

def parser(s):
    global prox_symb
    lexer.input(s)
    prox_symb = lexer.token()
    ABIN()

parser("(18 () ())")
parser("(18 (20 ()()) (50 ()()))")
parser("()")
parser("(40)") #erro
parser("(40 () ()") #erro