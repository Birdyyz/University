def p_program(t):
    r'Program : Statements return'
    t[0] = "\n".join(len(parser.vars)*("pushi 0")+t[1])

def p_stmts_0(t):
    t[0] = []

def p_stmt_read(t):
    r'Statement: VAR "=" input "(" ")"'
    if t[1] not in parser.vars:
        parser.vars.append(t[1])
    idx = parser.vars.index(t[1])
    t[0] = [f'pushs "\\nvar {t[1]}?" ', "writes","read","atoi",f"storeg{idx}"]

def p_stmt_write(t):
    r'Statement : print "(" Exp ")"'
    t[0] = t[3] + ["writei"]
    