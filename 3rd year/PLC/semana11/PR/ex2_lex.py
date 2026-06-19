import ply.lex as lex 

literals = ("(",")",">","=","*","-")
tokens = ("VAR","NUM","READ", "IF","WRITE","WHILE")

def t_WHILE(t):
    t = "while"
    return t 
def t_VAR(t):
    r"[a-zA-Z]"
def t_NUM(t):
    r"\d+"
    t.value = int(t.value)
    return t 

def t_error(t):
    print("Invalid character:", t)
    lexer.skip(1)

t_ignore = "\n"
lexer = lex.lex()