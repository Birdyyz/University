


def e_primo(n):
    for x in range(2, n):
        if n % x == 0:
            return False
    return True

def e_primo(n):
    for x in range(2, n):
        if n % x == 0:
            return False
    return True
    
def anel(n):
    if n % 2 != 0:
        return []
    usado = [False] * (n + 1)
    sequencia = [1]

    def backtrack():
        if len(sequencia) == n:
            return e_primo(sequencia[-1]+sequencia[0])
        
        for i in range(2,n+1):
            if not usado[i] and e_primo(sequencia[-1]+i):
                usado[i] = True
                sequencia.append(i)
                if backtrack():
                    return True
                usado[i] = False
                sequencia.pop()
        return False
        
    if backtrack():
        return sequencia
    return None