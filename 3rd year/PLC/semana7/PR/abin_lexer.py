import ply.lex as lex 

tokens = ('PA','PF','INT')

t_PA= r'\('
t_PF= r'\)'
t_INT = r'{+\-}?\d+'

# INT PA PF
# P1: ABIN -> PA ACONT
# P2: ACONT -> ε
#            | INT ABIN ABIN PF
#First(ACONT -> INT ABIN ABIN) = {INT}
#First(ACONT -> ε) = {PF}

def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)
t_ignore = '\t'

def t_error(t):
    print("Caracter desconhecido '%s'", t.value[0], 'Linha', t.lexer.lineno)
    t.lexer.skip(1)
lexer = lex.lex()

# lexer.input("(10 () ())")
for token in lexer:
    print(token.type,token.value)