public class Carro {
    private String matricula;
    private String marca;
    private String modelo;
    private int ano;
    private double vporkm;
    private double autonomia;
    private double kmtotais;

    public Carro(){
        this.matricula = new String();
        this.marca = new String();
        this.modelo = new String();
        this.ano = 0;
        this.vporkm = 0;
        this.autonomia = 0;
        this.kmtotais = 0;
    }

    public String getMatricula() {
        return this.matricula;
    }

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getMarca() {
        return this.marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }
    public String getModelo() {
        return this.modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public int getAno() {
        return this.ano;
    }

    public void setAno(int ano) {
        this.ano = ano;
    }

    public double getVporkm() {
        return this.vporkm;
    }

    public void setVporkm(double vporkm) {
        this.vporkm = vporkm;
    }

    public double getAutonomia() {
        return this.autonomia;
    }

    public void setAutonomia(double autonomia) {
        this.autonomia = autonomia;
    }

    public double getKmtotais() {
        return this.kmtotais;
    }
    public void setKmtotais(double kmtotais) {
        this.kmtotais = kmtotais;
    }

    public Carro(String matricula, String marca, String modelo, int ano, double vporkm, double autonomia, double kmtotais) {
        this.setMatricula(matricula);
        this.setMarca(marca);
        this.setModelo(modelo);
        this.setAno(ano);
        this.setVporkm(vporkm);
        this.setAutonomia(autonomia);
        this.setKmtotais(kmtotais);
    }

    public boolean equals(Object o){
        if (o == this){
            return true;
        }
        if(o == null || this.getClass() != o.getClass()){
            return false;
        }
        Carro s = (Carro) o;
        return this.getMatricula().equals(s.getMatricula()) && this.getMarca().equals(s.getMarca()) && this.getModelo().equals(s.getModelo())
                && this.getAno() == s.getAno() && this.getVporkm() == s.getVporkm() && this.getKmtotais() == s.getKmtotais();
    }
    public Carro(Carro other){
        this(other.getMatricula(), other.getMarca(), other.getModelo(), other.getAno(), other.getVporkm(), other.getAutonomia(), other.getKmtotais());
    }

    public Carro clone(){
        return new Carro(this);
    }
}
