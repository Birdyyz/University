import ply.lex as lex

tokens = (PA,PF,E,OU,F,T)
t_PA = r'\('
t_PF = r'\)'
t_E = r'\V'
t_OU = r'\∧'
t_F = r'\FALSE'
t_T = r'\TRUE'

def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)
t_ignore = ' \t'

def t_error(t):
    print("Caracter desconhecido '%s'", t.value[0], 'Linha', t.lexer.lineno)
    t.lexer.skip(1)
lexer = lex.lex()