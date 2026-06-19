import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Collectors;


public class CarRental {
    private Map<String, Carro> carros;

    public CarRental(Map<String, Carro> carros) {
        this.carros = carros;
    }

    public Map<String, Carro> getCarros() {
        return this.carros;
    }

    public void setCarros(Map<String, Carro> carros) {
        this.carros = carros;
    }

    public Carro CarroComMaiskms() {
        carros.values().stream().map(Carro::clone).max((c1,c2) ->
        {         if (c1.getKmtotais() != 0) {
            return c2.getMatricula().compareTo(c1.getMatricula());
        }
                if (c1.getKmtotais() > c2.getKmtotais()) {
                    return 1;
                } else {
                    return -1;
                }
            });
        return null;
        }

    /*public Set<Carroeletrico> comBateriaDe() {
        return carros.values().stream().filter(c -> c instanceof Carroeletrico).map(Carro::clone).collect(Collectors.toCollection(TreeSet::new));
    }
    */

    public Set<Carroeletrico> comBateriaDe() {
        return carros.values().stream()
                .filter(c -> c instanceof Carroeletrico)
                .map(c -> (Carroeletrico) c.clone()) // Faz o cast após clonar
                .collect(Collectors.toCollection(TreeSet::new));
    }

    public Map <Double, List<Carro>> CarrosPorAutonomia(){
        if(this.carros.isEmpty()){
            return null;
        }
        return this.carros.values()
                .stream()
                .map(Carro::clone)
                .collect(Collectors.groupingBy(Carro::getAutonomia));
    }
}