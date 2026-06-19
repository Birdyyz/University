public class Sensor {
    private double pressao;

    public Sensor(){ //vazio
        this.pressao=0;
    }
    public double getPressao(){
        return this.pressao;
    }
    public boolean setPressao(double pressao){
        if (pressao < 0){
            return false;
        }
        else{
            this.pressao=pressao;
            return true;
        }
    }

    public Sensor(double pressao){ //parametrizado
        this.pressao=pressao;
    }

    public Sensor(Sensor outro){
        this.pressao = outro.pressao;
    }

    public boolean equals(Object o){
        if (this == o){
            return true;
        }
        if (o == null || this.getClass() != o.getClass()){
            return false;
        }
        Sensor s= (Sensor) o;
        return this.pressao == s.pressao;
    }

    public String toString(){
        return "Sensor[pressao : " + this.pressao + "]";
    }
    public Sensor clone(){
        return new Sensor(this);
    }
}

