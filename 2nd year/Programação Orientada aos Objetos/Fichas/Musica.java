import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Musica {
    private String nome;
    private String interprete;
    private String autor;
    private String neditora;
    private String [] letra;
    private String [] musica;
    private int duracao;
    private int nescutada;

    public Musica(){ // construtor por omissao
        this.nome = "Nao sabemos";
        this.interprete = "Nao sabemos";
        this.autor = "Nao sabemos";
        this.neditora = "Nao sabemos";
        this.letra = new String[]{};
        this.musica = new String []{};
        this.duracao = 0;
        this.nescutada = 0;
    }
    public String getNome(){
        return this.nome;
    }

    public void setNome(String nome){
        this.nome = nome;
    }

    public String getInterprete(){
        return this.interprete;
    }

    public void setInterprete(String interprete){
        this.interprete = interprete;
    }
    
    public String getAutor(){
        return this.autor;
    }

    public void setAutor(String autor){
        this.autor = autor;
    }

    public String getNeditora(){
        return this.neditora;
    }

    public void setNeditora(String neditora){
        this.neditora = neditora;
    }

    public String[] getLetra(){
        return this.letra;
    }

    public void setLetra(String [] letra){
        this.letra = letra;
    }

    public String[] getMusica(){
        return this.musica;
    }

    public void setMusica(String[] musica){
        this.musica = musica;
    }

    public int getDuracao(){
        return this.duracao;
    }

    public void setDuracao(int duracao){
        this.duracao = duracao;
    }

    public int getNescutada(){
        return this.nescutada;
    }

    public void setNescutada(int nescutada){
        this.nescutada = nescutada;
    }

    public void incrementarNscutada(){
        this.nescutada++;
    }
    public Musica(String nome, String interprete, String autor, String neditora, String[] letra, String [] musica, int duracao){ // construtor parametrizado
        this.nome = nome;
        this.interprete = interprete;
        this.autor = autor;
        this.neditora = neditora;
        this.letra = letra;
        this.musica = musica;
        this.duracao = duracao;
        this.nescutada = 0;
    }

    public boolean equals(Object o){
        if (this == o){
            return true;
        }
        if(o == null || this.getClass() != o.getClass()){
            return false;
        }
        Musica s = (Musica) o;
        return this.nome ==s.nome && this.interprete == s.interprete; 
    }

    public int qtsLinhasPoema(String[] letra) {
        int count = 0;
        for (int i = 0; i < letra.length; i++) {
            if(letra[i] != null){
            String[] linhas = letra[i].split("\n");  
            count += linhas.length;  
            }}
        return count;
    }

    public int numeroCaracteres(String[] letra) {
        int count = 0;
            for (int i = 0; i < letra.length; i++) {
                if(letra[i] != null){
                    for (int j = 0; j < letra[i].length(); j++) {
                        char c = letra[i].charAt(j);  
                        if (Character.isLetter(c)) {  
                            count++;
                        }
                    }
                }}
        return count;
    }
    public void addLetra(int posicao, String novaLinha){
        int tamanho = letra.length;
        if (posicao < 0 || posicao > tamanho){
            return;
        }
        String [] novo = new String[tamanho + 1];
        for ( int i = 0 , m = 0 ; i < novo.length ; i++) {
                if (i == posicao){
                    novo[i] = novaLinha;
                }
                else{
                    novo[i] = letra[m];
                    m++;
                }
        }
        this.letra = novo;
    }

    public String linhaMaisLonga(){
        int atual = 0, max = 0 , maxlinha=0;
        for (int i = 0; i < letra.length ; i++){
            if(letra[i] != null){
                atual = 0;
                for(int j = 0; j < letra[i].length() ; j++){
                    char c = letra[i].charAt(j);
                    if(Character.isLetter(c)){
                        atual++;
                    }
                }
                if(atual > max ){
                    max = atual;
                    maxlinha = i;
                }
        }
    }
    return letra[maxlinha];
}
/*fazer um array com 26 letras q sao as letras do abcedario e em cada indice adicionar o numero de vezes em que ela repete
    public String[] letrasMaisUtilizadas(){

    }
*/
    public String toString(){
        return "Nome: " + nome + "\n" + "Intérprete: " + interprete + "\n" + "Autor: " + autor + "\n" + "Nome da editora: " + neditora +"\n"+
        "Vezes escutada: " + nescutada + "\n" + "Tem "+ qtsLinhasPoema(letra) + "linhas"+ "\n" + "numero caracteres "+ numeroCaracteres(letra)+"\n" + Arrays.toString(letra);
    }
    public Musica(Musica outro){
        this.nome = outro.nome;
        this.interprete = outro.interprete;
        this.autor = outro.autor;
        this.neditora = outro.neditora;
        this.letra = outro.letra;
        this.musica = outro.musica;
        this.duracao = outro.duracao;
        this.nescutada = outro.nescutada;
    }

    public Musica clone(){ //construtor de copia
        return new Musica(this);
    }
}
