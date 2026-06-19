public class Telemovel {
    private String marca;
    private String modelo;
    private String display;
    private int dimsms;
    private int armazenamento;
    private int armazenfotos;
    private int armazenapps;
    private int espocupado;
    private int numfotos;
    private int numapps;
    private String nomesapps;
    
    public Telemovel(){ //construtor por omissao
        this.marca = "Nao sabemos";
        this.modelo = "Nao sabemos";
        this.display = "Nao sabemos";
        this.dimsms = -1;
        this.armazenamento = -1;
        this.armazenfotos = -1;
        this.armazenapps = -1;
        this.espocupado = -1;
        this.numfotos = -1;
        this.numapps = -1;
        this.nomesapps = "Nao sabemos";
    }

    public String getMarca(){
        return this.marca;
    }

    public void setMarca(String marca){
        this.marca = marca;
    }

    public String getModelo(){
        return this.modelo;
    }

    public void setModelo(String modelo){
        this.modelo = modelo;
    }

    public String getDisplay(){
        return this.display;
    }

    public void setDisplay(String display){
        this.display = display;
    }

    public int getDimsms(){
        return this.dimsms;
    }

    public void setDimsms(int dimsms){
        this.dimsms = dimsms;
    }

    public int getArmazenamento(){
        return this.armazenamento;
    }

    public void setArmazenamento(int armazenamento){
        this.armazenamento = armazenamento;
    }

    public int getAArmazenfotos(){
        return this.armazenfotos;
    }

    public void setArmazenfotos(int armazenfotos){
        this.armazenfotos = armazenfotos;
    }
    public int getAArmazenapps(){
        return this.armazenapps;
    }
    
    public void setArmazenapps(int armazenapps){
        this.armazenapps = armazenapps;
    }

    public int getEspocupado(){
        return this.espocupado;
    }

    public void setEspocupado(int espocupado){
        this.espocupado = espocupado;
    }
    
    public int getNumfotos(){
        return this.numfotos;
    }

    public void setNumfotos(int numfotos){
        this.numfotos = numfotos;
    }

    public int getNumapps(){
        return this.getNumapps();
    }

    public void setNumapps(int numapps){
        this.numapps = numapps;
    }

    public String getNomesapps(){
        return this.nomesapps;
    }

    public void setNomesapps(String nomesapps){
        this.nomesapps = nomesapps;
    }
    //construtor parametrizado
    public Telemovel(String marca, String modelo, String display, int dimsms, int armazenamento,int armazenfotos, int armazenapps, 
    int espocupado, int numfotos, int numapps, String nomesapps){
        this.marca = marca;
        this.modelo = modelo;
        this.display = display;
        this.dimsms = dimsms;
        this.armazenamento = armazenamento;
        this.armazenfotos = armazenfotos;
        this.armazenapps = armazenapps;
        this.espocupado = espocupado;
        this.numfotos = numfotos;
        this.numapps = numapps;
        this.nomesapps = nomesapps;
    }

    public boolean equals(Object o){
        if(this == o){
            return true;
        }
        if(o == null || this.getClass() != o.getClass()){
            return false;
        }
        Telemovel s = (Telemovel) o;
        return this.marca == s.marca && this.modelo == s.modelo;
    }

    public boolean existeEspaco(int numeroBytes){
        return (numeroBytes <= (armazenamento - espocupado));
    }

    public void instalaApp(String nome, int tamanho) {
        if (existeEspaco(tamanho)) {
            if (nomesapps == null || nomesapps.isEmpty()) {
                nomesapps = nome;  
            } else {
                nomesapps += "," + nome;  
            }
        }
    }
    public void recebeMsg(String msg){
        
    }
    public String toString(){
        return "O seu " + marca + modelo + " com uma dimensao de " + display + " com " + dimsms + " de armazenamento para as mensagens de texto, com um armazenamento de " +
        armazenamento + " mais especificamente, para fotos: " + armazenfotos + " para aplicacoes: " + armazenapps + " tem " + espocupado + " ocupados porque tem, fotos, e numero de aplicacoes (respetivamente) " 
        + numfotos + " " + numapps;
    }
    public Telemovel(Telemovel outro){
        this.marca = marca;
        this.modelo = modelo;
        this.display = display;
        this.dimsms = dimsms;
        this.armazenamento = armazenamento;
        this.armazenfotos = armazenfotos;
        this.armazenapps = armazenapps;
        this.espocupado = espocupado;
        this.numfotos = numfotos;
        this.numapps = numapps;
        this.nomesapps = nomesapps;
    }

    public Telemovel clone(){
        return new Telemovel(this);
    }
}
