import ply.yacc as yacc
from calc_lex_VM import tokens, literals, lexer


"""
Exp: Cond '?' Exp ':' Exp
Cond : Cond '||' Conj
    | Conj
Conj: Conj '&' Comp
    | Comp
Comp: Exp '>' Exp
    | Exp '<' Exp
"""

def p_program(t):
    r"""~Program : Instruction
                | Instruction 
        Instruction : "%" VAR 
                | "!" Exp
                | VAR "=" Exp
                | "#"
        Exp : Exp "+" Term 
            | Exp "-" Term 
            | Term 
        Term : Term "*" Factor
            | Term "/" Factor 
            | Factor 
        Factor : NUM
            | VAR
            | "(" Exp ")"
            | Cond "?" Exp ":" Exp
        Cond : Cond "|" Conj 
            | Conj 
        Conj : Conk "&" Comp 
            | Comp 
        Comp : Exp ">" Exp 
            | Exp "<" Exp
    """


def p_error(t):
    parser.error = f"Syntax error: {t}"

parser = yacc.yacc()
parser.error = None