import ply.lex as lex 

tokens = ('EQ','BF','CA','CF','ENTRADA','AGENDA','NOME','EMAIL','TELEFONE',
          'ID','T','PO','TEXT','HEADER')

# XML -> HEADER CA AGENDA CF ENTRADAS CA BF AGENDA CF 
# ENTRADAS -> ε
#           | ELEM ENTRADAS 
# ELEM -> CA ELEMCONT 
# ELEMCONT -> ENTRADA CF ...
#           | GRUPO CF ...




def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)
t_ignore = '\t'

def t_error(t):
    print("Caracter desconhecido '%s'", t.value[0], 'Linha', t.lexer.lineno)
    t.lexer.skip(1)
lexer = lex.lex()

for token in lexer:
    print(token.type,token.value)