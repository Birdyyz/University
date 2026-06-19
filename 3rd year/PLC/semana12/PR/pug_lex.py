import ply.lex as lex 
tokens = ['input','print','if','while','return','else','VAR','NUM','INDENT','DEDENT','KEEP']
literals = [">", "<","+","-","/","*","=",":","(",")"]

indent_level = 0
def t_input(token):
    r'input'
    return token 

def t_if(token):
    r'if'
    return token

def t_print(token):
    r'print'
    return token 
def t_while(token):
    r'while'
    return token 
def t_return(token):
    r'return'
    return token


def t_VAR(t):
    r"[a-zA-Z]"

def t_NUM(t):
    r"\d+"
    t.value = int(t)
    return t
def t_newline(token):
    r"\n[ \t]*"
    global indent_level 
    token.lexer.lineno += 1 
    i = len(token.value) - 1

    if i == indent_level:
        token.type = "KEEP"
        token.value = i 
    elif i > indent_level:
        token.type = "INDENT"
        token.value = i 
        indent_level = i 
    elif i < indent_level: 
        token.type = "DEDENT"
        token.value = i 
        indent_level = i 
    if token.type != "KEEP":
        return token
    
t_ignore = ' \t'

def t_error(token):
    print("Illegal character")


lexer = lex.lex()

import sys 

ex = """
n = input()
while n > 0:
    n = n-1
    if n > 0:
        print(n)
    else:
        print(-n)
    n = n-1
return
"""

lexer.input(ex)