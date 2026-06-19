public class Carrocombustao extends Carro{
    private double tamanhodeposito;
    private double consumolitros100km;
    private double precolitro;

    public Carrocombustao() {
        this.tamanhodeposito = 0;
        this.consumolitros100km = 0;
        this.precolitro = 0;
    }

    public double getTamanhodeposito() {
        return this.tamanhodeposito;
    }

    public void setTamanhodeposito(double tamanhodeposito) {
        this.tamanhodeposito = tamanhodeposito;
    }

    public double getConsumolitros100km() {
        return this.consumolitros100km;
    }

    public void setConsumolitros100km(double consumolitros100km) {
        this.consumolitros100km = consumolitros100km;
    }
    public double getPrecolitro() {
        return this.precolitro;
    }

    public void setPrecolitro(double precolitro) {
        this.precolitro = precolitro;
    }

    public Carrocombustao(double tamanhodeposito, double consumolitros100km, double precolitro) {
        this.setTamanhodeposito((tamanhodeposito));
        this.setConsumolitros100km(consumolitros100km);
        this.setPrecolitro((precolitro));
    }

    public boolean equals(Object o){
        if (o == this){
            return true;
        }
        if(o == null || this.getClass() != o.getClass()){
            return false;
        }
        Carrocombustao s = (Carrocombustao) o;
        return this.tamanhodeposito == s.tamanhodeposito && this.consumolitros100km == s.consumolitros100km && this.precolitro == s.precolitro;
    }
    public Carrocombustao(Carrocombustao other){
        this(other.tamanhodeposito, other.consumolitros100km, other.precolitro);
    }

    public Carrocombustao clone(){
        return new Carrocombustao(this);
    }
}
