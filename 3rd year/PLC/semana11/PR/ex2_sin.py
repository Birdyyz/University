import ply.yacc as yacc
from calc_lex import lexer, tokens, literals


def p_program(t):
    r"Program : Statements"
    t[0] = "\n".join(len(parser.vars)*"pushi 0" + t[1])

def p_stmts_0(t):
    r"Statements : Statements Statement"
    t[0] = t[1]

def p_stmts_1(t):
    r"Statements: "
    t[0] = []


def p_stmt_read(t):
    r"Statements : '(' READ VAR ')'"
    if t[3] not in parser.vars: 
        parser.vars.append(t[3])
    idx = parser.vars.index(t[3])
    t[0] = [f"pushs "var {t[3]}":" , "writes", "read","atoi", f"storeg{idx}"]

def p_stmt_write(t):
    r"Statement : '(' WRITE VAR ')'"
    parser.vars.append(t[3])
    idx = parser.vars.index(t[3])
    t[0] = [f"pushs "var {t[3]}":" , "writes" , f"pushg(idx)","writei"]

def p_stmt_assign(t):
    r"Statement : '(' '=' VAR Exp ')'"
    if t[3] not in parser.vars: 
        parser.vars.append(t[3])
    idx = parser.vars.index(t[3])
    t[0] = t[4] + [f"storeg {idx}"]


def p_stmt_if(t):
    r"Statement : '(' IF Cond Block Block ')'"
    t[0] = t[3] + [f"jz else{parser.label}"] + t[4] + [f"jump end {parser.label}", f"else{parser.label}:"] + t[5] + [f"end{parser.label}"]
    parser.label += 1
    
def stmt_while(t):
    r"Statemenet : '(' WHILE Cond Block ')'"
    t[0] = [f"while{parser.label}:"] + t[3]+[f"jz end{parser.label}"] +t[4] + [f"jump while{parser.label}", f""]
    parser.label += 1

def p_block_0(t):
    r"Block : Statement"
    t[0] = t[1]

def p_block_1(t):
    r"Block : '(' Statement ')'"
    t[0] = t[2]

def p_exp_sum(t):
    r"Exp : '(' '+' Exp Term ')'"
    t[0] = t[3] + t[4] + ["add"]

def p_exp_sub(t):
    r"Exp : '(' '-' Exp Term ')'"
    t[0] = t[3] + t[4] + ["add"]

def p_factor_fact(t):
    r"Term : Factor"

def p_factor_num(t):
    r"Factor : NUM"
    t[0] = t[1]


def p_factor_var(t):
    r"Factor: VAR"
    idx = parser.vars.index(t[1])







parser = yac.yacc()
ex2= """
(read a)
(= f 1)
while(> a 1)
    (
        (= f (* f a)
        ( = a (- a 1)
    )
)
(write f)
"""

ex3 ="""
(read n)
(= nx 1)
(= ny 1)
(while( > n 0)
    (
        ( = aux nx)
        ( = nx(+ nx ny))
        (= ny aux)
        (= n (- n 1))
    )
)
(write nx)
"""

parser = init()
result = parser.parser(ex2)
if parser.error:
    print("Error!",parser.errror)
else:
    print(result)
