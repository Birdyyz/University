#include <stdio.h>
#include <locale.h>
#include <wchar.h>

int main()
{
    int dia, mes;

    setlocale(LC_CTYPE, "C.UTF-8");

    if (scanf("%d%d", &dia, &mes)) 
    {
        if ((mes == 3 && dia >= 21 && dia <= 31) || (mes == 4 && dia <= 20))
            wprintf(L"%lc\n",0x2648);
        else if ((mes == 4 && dia >= 21 && dia <= 30) || (mes == 5 && dia <= 20))
            wprintf(L"%lc\n",0x2649);
        else if ((mes == 5 && dia >= 21 && dia <= 31) || (mes == 6 && dia <= 20))
            wprintf(L"%lc\n",0x264a);
        else if ((mes == 6 && dia >= 21 && dia <= 30) || (mes == 7 && dia <= 22))
            wprintf(L"%lc\n",0x264b);
        else if ((mes == 7 && dia >= 23 && dia <= 31) || (mes == 8 && dia <= 22))
            wprintf(L"%lc\n",0x264c);
        else if ((mes == 8 && dia >= 23 && dia <= 31) || (mes == 9 && dia <= 22))
            wprintf(L"%lc\n",0x264d);
        else if ((mes == 9 && dia >= 23 && dia <= 30) || (mes == 10 && dia <= 22))
            wprintf(L"%lc\n",0x264e);
        else if ((mes == 10 && dia >= 23 && dia <= 31) || (mes == 11 && dia <= 21))
            wprintf(L"%lc\n",0x264f);
        else if ((mes == 11 && dia >= 22 && dia <= 30) || (mes == 12 && dia <= 21))
            wprintf(L"%lc\n",0x2650);
        else if ((mes == 12 && dia >= 22 && dia <= 31) || (mes == 1 && dia <= 19))
            wprintf(L"%lc\n",0x2651);
        else if ((mes == 1 && dia >= 20 && dia <= 31) || (mes == 2 && dia <= 18))
            wprintf(L"%lc\n",0x2652);
        else if ((mes == 2 && dia >= 19 && dia <= 29) || (mes == 3 && dia <= 20 ))
            wprintf(L"%lc\n",0x2653);
    }
    return 0;
}
