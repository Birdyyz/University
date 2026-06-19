#include <stdio.h>
#include <string.h>
#include <math.h>

int maior() {
    int x;

    scanf("%d", &x);
    int maior=x;
    while (x != 0) {
        if (x > maior)
            maior = x;
        scanf("%d", &x); 
    }
    return maior; 
}
int media(){
    int x,var=0,i=0;
    scanf("%d", &x);
    while(x!=0){
        var+=x;
        i+=1;
        scanf("%d",&x);
    }
    if (i==0){
        return 0;
    }
    return var/i;
}
int secmaior(){
    int x,maior,secmaior;
    scanf("%d", &x);
    maior=x;
    scanf("%d", &x);
    if (x<maior){
        secmaior=x;
    }
    else{
        secmaior=maior;
        maior=x;
    }
    scanf("%d",&x);
    while (x != 0) {
        if (x > maior) {
            secmaior = maior;  
            maior = x;
        } else if (x > secmaior && x != maior) {
            secmaior = x;
        }
        scanf("%d", &x);
    }

    return secmaior;
}
int bitsUm(unsigned int n) {
    int i, x = 0;
    for(i = n; i > 0; i/=2) {
        if (i % 2 == 0) x++;
    }
    return x;
}

int qDig(unsigned int n){
    if (n == 0) return 1;
    return (int)log10(abs(n)) + 1;
}

char *mystrcat(char s1[], char s2[]) {
    int p, i;
    
    for (p = 0; s1[p] != '\0'; p++); 
    for (i = 0; s2[i] != '\0'; i++, p++)
        s1[p] = s2[i];
    s1[p] = '\0';
    return s1;
}

char *mystrcpy(char *dest, char source[]) {
	int i = 0;
	for(i = 0; source[i] != '\0'; i++)
		dest[i] = source[i];
	dest[i] = '\0';
	return dest;
}
int main() {
    printf("Digite numeros (0 para parar):\n");
    //int resultado = maior();
    //int medias =media();
    //int segundo=secmaior();
    int binario= bitsUm(2);
    //printf("Maior numero: %d\n", resultado);
    //printf("A media da sequencia: %d \n", medias);
    //printf("O segundo maior e: %d\n", segundo);
    printf("O numero em binario tem :%d \n uns ",binario);
    return 0;
}
int mystrcmp(char s1[], char s2[]) {
	int i;
	for(i = 0; s1[i] != '\0' && s2[i] != '\0' && s1[i] == s2[i]; i++);
	return s1[i]-s2[i];
}
char *mystrstr(char s1[], char s2[]) {
    char *res = NULL;
    int i,p;
    if (s2[0] == '\0') return s1;
    for(i = 0; s1[i] != '\0' && res == NULL; i++) {
        for(p = 0; s2[p] != '\0' && s2[p] == s1[i+p];p++);
        if (s2[p] == '\0')
            res = s1 + i;
    }
    return res;
}
void strrev(char s[]) {
    int i, j;
    char temp;
    int len = strlen(s);
    for (i = 0, j = len - 1; i < j; i++, j--) {
        temp = s[i];
        s[i] = s[j];
        s[j] = temp;
    }
}

void strnoV (char s[]){
    int i,m=0;
    for(i=0; s[i]!='\0';i++){
        if (!(s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u' || 
              s[i] == 'A' || s[i] == 'E' || s[i] == 'I' || s[i] == 'O' || s[i] == 'U')) {
           s[m++]=s[i];
        }
    }
    s[m]='\0';
}
void truncW (char t[], int n){
    int i, chars=0, pos=0;
    for(i=0;t[i]!='\0';i++){
        if(t[i]==' '){
            chars=0;
            t[pos++]=' ';
        }
        else if(chars<n){
            chars++;
            t[pos++]=t[i];
        }
    }
    t[pos]='\0';
}

char charMaisfreq (char s[]){
    int i,max=0, freq=0,m;
    char mfreq='0';
    if (s[0]=='\0'){
        return 0;
    }
    for(i=0;s[i]!='\0';i++){
        freq=0;
        for(m=0;s[m]!='\0';m++){
            if(s[i]==s[m]){
                freq++;
            }
        }
        if(freq>max){
            max=freq;
            mfreq=s[i];
        }
    }
    return mfreq;
}

int iguaisConsecutivos (char s[]){
    int count = 1;
    int countmax = 1;
    int i,j;
    if (s[0]=='\0'){
        return 0;
    }
    for(i=0;s[i+1]!='\0';i++){
            if(s[i] == s[i+1]){
                count++;
            }
            else{
                if (count > countmax){
                    countmax = count;
                }
                count = 1;
            }
        }
    if (count > countmax){
                    countmax = count;
    }
    return countmax;
}

int difConsecutivos (char s[]){
    int count = 1;
    int countmax = 1;
    int i;
    if (s[0]=='\0'){
        return 0;
    }
    for(i = 0; s[i+1] != '\0'; i++){
        if (s[i] != s[i+1]){
            count++;
        }
        else{
            if(count > countmax){
                countmax = count;
            }
            count = 1;
        }
    }
    if (count > countmax){
        countmax = count;
    }
    return countmax;
}

int maiorPrefixo (char s1 [], char s2 []){
    int count = 0;
    int i;
    for(i = 0; s1[i] != '\0' && s2[i] != '\0'; i++){
        if(s1[i] == s2[i]){
            count++;  
        } else {
            break; 
        }
    }
    return count; 
}

int maiorSufixo (char s1 [], char s2 []) {
    int count = 0;
    int i,m;
    for(i = strlen(s1)-1 , m = strlen(s2)-1 ; i >= 0 , m >= 0 ; i--, m-- ){
        if (s1[i] == s2[m]){
            count++;
        }
        else{
            break;
        }
    }
    return count;
}

int sufPref (char s1[], char s2[]){
    int count = 0;
    int i,m;
    for(i = strlen(s1)-1 , m = 0; i>=0, s2[m] != '\0' ; i-- , m++){
        if (s1[i] == s2[m]){
            count++;
        }
        else{
            break;
        }
    }
    return count;
}

int sufPref(char s1[], char s2[]) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    int maxLength = 0;
    int i;
    for (i = 0; i < len1; i++) {
        if (strncmp(s1 + i, s2, len1 - i) == 0) {
            maxLength = len1 - i;
            break;  
        }
    }
    return maxLength;
}

int sufPref2(char s1[], char s2[]) {
    int len1 = strlen(s1);
    int len2 = strlen(s2);
    int maxLength = 0;
    for (int i = 0; i < len1; i++) {
        int j = 0;
        while (s1[i + j] == s2[j] && (i + j) < len1 && j < len2) {
            j++;
        }
        
        if (j == len1 - i) {
            maxLength = len1 - i;
            break;  
        }
    }
    
    return maxLength;
}
#include <ctype.h>
int contaPal (char s[]){
    int i;
    int count = 1;
    if (s[0] == '\0'){
        return 0;
    }
    for(i = 0; s[i] != '\0' ; i++){
        if(isspace(s[i]) && s[i+1]!= '\0' && !isspace(s[i+1])){
            count++;
        }
    }
    return count;
}

int contaVogais (char s[]){
    int count=0;
    int i;
    for(i = 0; s[i] != '\0'; i++){
        if (s[i] == 'A' || s[i] == 'E' || s[i] == 'I' || s[i] == 'O' || s[i] == 'U' ||
            s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u'){
            count++;
        }
    }
    return count;
}
int contidasemprep (char a[], char b[]){
    int i,m;
    int tam = strlen(a);
    int r = 0;
    for(i = 0, m = 0; a[i]!= '\0'&& b[m] !='\0'; m++){
        if(a[i] == b[m]){
            r++;
            i++;
            m = 0;
        }
    }
    if(r == tam){
        return 1;
    }
    return 0;
}

int palindorome (char s[]){
    int inicio,fim;
    for(inicio = 0, fim = strlen(s)-1 ;inicio < fim; inicio++, fim--){
        if(s[inicio] != s[fim]){
            return 0;
        }
    }
    return 1;
}

int remRep (char x[]){
    int r = 1,i;
    int tam = strlen(x);
    char res[tam+1];
    res[0] = x[0];
    if (tam == 0) return 0;
    for(i = 1; i < tam ; i++){
        if(x[i] != x[i-1]){
            res[r] = x[i];
            r++;
        }
    }
    res[r] = '\0';
    strcpy(x,res);
    return r;
}

int limpaEspacos(char t[]) {
    int i = 0, c = 0;
    int tam = strlen(t);
    int espaco = 0; 

    while (t[i] != '\0') {
        if (!isspace(t[i])) { 
            t[c++] = t[i];
            espaco = 0;
        } else if (!espaco) { 
            t[c++] = ' ';
            espaco = 1;
        }
        i++;
    }
    t[c] = '\0'; 
    return c; 
}

void insere(int v[], int N, int x) {
    int i = N - 1;
    while (i >= 0 && v[i] > x) {
        v[i + 1] = v[i];
        i--;
    }
    v[i + 1] = x;
}

void merge (int r [], int a[], int b[], int na, int nb){
    int i = 0, m = 0,j=0;
    while(i < na && m < nb){
        if(a[i] < b[m]){
            r[j++] = a[i++];
        }
        else{
            r[j++] = b[m++];
        }
    }

    while (i < na) {
        r[j++] = a[i++];
    }
    while (m < nb) {
        r[j++] = b[m++];
    }
    int k;
    for(k = 0; k < 20; k++){
        printf("%d ", r[k]);
    }
}

int crescente (int a[], int i, int j){
    int m;
    for(m = i; m < j; m++){
        if(a[m] > a[m+1]){
            return 0;
        }
    }
    return 1;
}

int retiraNeg (int v[], int N){
    int i,j = 0;
    for(i = 0; i < N; i++){
        if(v[i] >= 0){
            v[j++] = v[i];

        }
    }
    return j;
}

int menosFreq (int v[], int N){
    int i, atual = 1,max = N, menosfreq = v[0];
    for(i = 0; i < N-1 ; i++){
        if(v[i] == v[i+1]){
            atual++;
        }
        else{ if(atual < max){
            
            max =atual;
            menosfreq = v[i];
            
        }
        atual = 1;
    }
    }
    if(atual < max){
        menosfreq= v[N-1];
    }
    return menosfreq;
}

int maisFreq (int v[], int N){
    int i, atual = 1,max = 1, maisfreq = v[0];
    for(i = 0; i < N-1 ; i++){
        if(v[i] == v[i+1]){
            atual++;
        }
        else{ if(atual > max){
            max =atual;
            maisfreq = v[i];
        }
        atual = 1;
    }
    }
    if(atual > max){
        maisfreq= v[N-1];
    }
    return maisfreq;
}

int maxCresc (int v[], int N){
    int i, max = 0, atual = 1;
    for(i = 0; i < N-1 ; i++){
        if(v[i] <= v[i+1]){
            atual++;
        }
        else{
            if(atual > max){
                max = atual;
            }
            atual = 1;
        }
    }
    if(atual > max){
        max = atual;
    }
    return max;
}

int pertence(int elem, int v[], int n) {
    int i;
    for (i = 0; i < n; i++) {
        if (v[i] == elem) return 1; 
    }
    return 0; 
}

int elimRep(int v[], int n) {
    int arr[n]; 
    int index = 0;
    int i,j;
    for (i = 0; i < n; i++) {
        if (!pertence(v[i], arr, index)) { 
            arr[index++] = v[i];
        }
    }
    for (j = 0; j < index; j++) {
        v[j] = arr[j];
    }

    return index; 
}

int elimRepOrd(int v[], int n) {
    int i, j = 0;
    for (i = 1; i < n; i++) {
        if (v[i] != v[j]) { 
            v[++j] = v[i];  
        }
    }
    return j + 1; 
}

int comunsOrd(int a[], int na, int b[], int nb) {
    int i = 0, j = 0, count = 0;

    while (i < na && j < nb) {
        if (a[i] == b[j]) { 
            count++; 
            i++; 
            j++; 
        } else if (a[i] < b[j]) {
            i++; 
        } else {
            j++; 
        }
    }
    return count;
}
