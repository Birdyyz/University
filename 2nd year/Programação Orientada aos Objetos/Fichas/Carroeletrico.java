public class Carroeletrico extends Carro{
    private double dimensaobateria;
    private double consumokwh100;
    private double precokwh;

    public Carroeletrico(){
        this.dimensaobateria = 0.0;
        this.consumokwh100 = 0.0;
        this.precokwh = 0.0;
    }
    public double getDimensaobateria() {
        return dimensaobateria;
    }

    public void setDimensaobateria(double dimensaobateria) {
        this.dimensaobateria = dimensaobateria;
    }

    public double getConsumokwh100() {
        return consumokwh100;
    }

    public void setConsumokwh100(double consumokwh100) {
        this.consumokwh100 = consumokwh100;
    }

    public double getPrecokwh() {
        return precokwh;
    }

    public void setPrecokwh(double precokwh) {
        this.precokwh = precokwh;
    }

    public Carroeletrico(double dimensaobateria, double consumokwh100, double precokwh){
        this.setDimensaobateria(dimensaobateria);
        this.setConsumokwh100(consumokwh100);
        this.setPrecokwh(precokwh);
    }

    public boolean equals(Object o){
        if (o == this){
            return true;
        }
        if(o == null || this.getClass() != o.getClass()){
            return false;
        }
        Carroeletrico s = (Carroeletrico) o;
        return this.getDimensaobateria() == s.getDimensaobateria() && this.getConsumokwh100() == s.getConsumokwh100() && this.getPrecokwh() == s.getPrecokwh();
    }

    public Carroeletrico(Carroeletrico other){
        this(other.getDimensaobateria(), other.getConsumokwh100(),other.getPrecokwh());
    }

    public Carroeletrico clone(){
        return new Carroeletrico(this);
    }

}
