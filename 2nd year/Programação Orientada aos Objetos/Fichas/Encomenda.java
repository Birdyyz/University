import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Encomenda {
    private String client;
    private String NIF;
    private String adress;
    private Integer ordernumber;
    private LocalDateTime date;
    private List <Linhadeencomenda> orderlines;

    public Encomenda(){
        this.client = "We don't know";
        this.NIF = "We don't know";
        this.adress = "We don't know";
        this.ordernumber = 0;
        this.date = LocalDateTime.now();
        this.orderlines = new ArrayList <Linhadeencomenda> ();
    }

    public String getClient(){
        return this.client;
    }

    public void setClient(String client){
        this.client = client;
    }

    public String getNIF(){
        return this.NIF;
    }

    public void setNif(String NIF){
        this.NIF = NIF;
    }

    public String getAdress(){
        return this.adress;
    }

    public void setAdress(String adress){
        this.adress = adress;
    }

    public Integer getOrdernumber(){
        return this.ordernumber;
    }

    public void setOrdernumber(Integer ordernumber){
        this.ordernumber = ordernumber;
    }

    public LocalDateTime getDate(){
        return this.date;
    }

    public void setDate(LocalDateTime date){
        this.date = date;
    }

    public List <Linhadeencomenda> getEncomendas() {
        List <Linhadeencomenda> array = new ArrayList<Linhadeencomenda> (orderlines.size());
        for (int i = 0; i < this.orderlines.size(); i++) array.add(new Linhadeencomenda(this.orderlines.get(i)));
        return array;
    }
    
    public void setEncomendas(List <Linhadeencomenda> e) {
        this.orderlines = new ArrayList <Linhadeencomenda> (e.size());
        for (int i = 0; i < e.size(); i++) this.orderlines.add( new Linhadeencomenda(e.get(i)));
    }

    public double calculaValorTotal(){
        List <Linhadeencomenda> array = this.getEncomendas();
        double r = 0;
        for(int i = 0; i < array.size(); i++){
            r += (array.get(i)).calculaValorLinhaEnc();
        }
        return r;
    }

    public double calculaValorDesconto(){
        List <Linhadeencomenda> array = this.getEncomendas();
        double r = 0;
        for(int i = 0; i < array.size(); i++){
            r += (array.get(i)).calculaValorDesconto();
    }
    return r;
    }

    public int numeroTotalProdutos(){
        List <Linhadeencomenda> array = this.getEncomendas();
        int r = 0;
        for(int i =0; i < array.size() ; i++){
            r += (array.get(i)).getQuantity();
        }
        return r;
    }

    public boolean existeProdutoEncomenda(String refProduto){
        List <Linhadeencomenda> array= this.getEncomendas();
        for(int i = 0; i< array.size(); i++){
            if((array.get(i)).getReference().equals(refProduto)){
                return true;
            }
        }
        return false;
    }

    public void adicionaLinha(Linhadeencomenda linha){
        List <Linhadeencomenda> array= this.getEncomendas();
        List <Linhadeencomenda> arrayclinhanova = new ArrayList <Linhadeencomenda> (array.size() + 1);
        arrayclinhanova.addAll(array);
        arrayclinhanova.add(linha);
        this.setEncomendas(arrayclinhanova);
    } 

    public void removeProduto(String codProd){
        List <Linhadeencomenda> array = this.getEncomendas();
        ArrayList <Linhadeencomenda> arrayfinal = new ArrayList <Linhadeencomenda> (array.size() - 1);
        int j = 0;
        for(int i = 0; i < array.size() ; i++){
            if(!(array.get(i).getReference().equals(codProd))){
                arrayfinal.set(j, array.get(i));
                j++;
            }
        }
        this.setEncomendas(arrayfinal);
    }

    public Encomenda(String client, String NIF, String adress, Integer ordernumber, LocalDateTime date, List<Linhadeencomenda> orderlines){
        this.setClient(client);
        this.setAdress(adress);
        this.setOrdernumber(ordernumber);
        this.setDate(date);
        this.setEncomendas(orderlines);
    }

    public boolean equals(Object o){
        if(this == o){
            return true;
        }
        if(o == null || this.getClass() != o.getClass()){
            return false;
        }
        Encomenda s = (Encomenda) o; 
        return this.getClient().equals(s.getClient()) && this.getNIF().equals(s.getNIF()) && this.getAdress().equals(s.getAdress()) &&
        this.getOrdernumber().equals(s.getOrdernumber()) && this.getDate().equals(s.getDate()) && this.getEncomendas().equals(s.getEncomendas());
    }

    public Encomenda(Encomenda other){
        this(other.getClient(), other.getNIF(), other.getAdress(), other.getOrdernumber(), other.getDate(), other.getEncomendas());
    }

    public Encomenda clone(){
        return new Encomenda(this);
    }
}