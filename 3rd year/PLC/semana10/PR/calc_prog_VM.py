from calc_sin_VM import parser 
import sys 
print( 
"""     calculator:
        available commands:
        ! e : print the value of an expression e
        % v : print the value of a variable v 
        v = e : assign value of expression e to variable v 
        # : dump the value of all variables

        Available operators:
        arithmetic: + - / *
        logical: | & 
        relational: < >
        conditional: c ? e : e
        """
)
input = ""
for linha in sys.studio:
    parser.sucess = True 
    result = parser.parse(linha)
    if parser.sucess:
        if result: print(result)
