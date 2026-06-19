public class Linhadeencomenda {
    private String reference;
    private String description;
    private double price;
    private Integer quantity;
    private double tax;
    private double discount;

    public Linhadeencomenda(){
        this.reference = "We don't know";
        this.description = "We don't know";
        this.price = 0;
        this.quantity = 0;
        this.tax = 0;
        this.discount = 0;
    }

    public String getReference(){
        return this.reference;
    }

    public void setReference(String reference){
        this.reference = reference;
    }

    public String getDescription(){
        return this.description;
    }

    public void setDescription(String description){
        this.description = description;
    }

    public double getPrice(){
        return this.price;
    }

    public void setPrice(double price){
        this.price = price;
    }

    public Integer getQuantity(){
        return this.quantity;
    }

    public void setQuantity(Integer quantity){
        this.quantity = quantity;
    }

    public double getTax(){
        return this.tax;
    }

    public void setTax(double tax){
        this.tax = tax;
    }
    
    public double getDiscount(){
        return this.discount;
    }

    public void setDiscount(double discount){
        this.discount = discount;
    }

    public Linhadeencomenda(String reference, String description, double price, Integer quantity, double tax, double discount){
        this.setReference(reference);
        this.setDescription(description);
        this.setPrice(price);
        this.setQuantity(quantity);
        this.setTax(tax);
        this.setDiscount(discount);;
    }

    public boolean equals(Object o){
        if (this == o){
            return true;
        }
        if(o == null || this.getClass() != o.getClass()){
            return false;
        }
        Linhadeencomenda s = (Linhadeencomenda) o;
        return this.getReference().equals(s.getReference()) && this.getDescription().equals(s.getDescription()) && this.getPrice() == s.getPrice()
         && this.getQuantity() == s.getQuantity() && this.getTax() == s.getTax() && this.getDiscount() == s.getDiscount();
    }

/*100% ---------- 20
 * 80%----------- x
 * x= 20*80/100 = 16
 * 20-16 = 4-> produto ao fim de estar em 80%
 */

    public double calculaValorLinhaEnc(){
        double h = ((this.getPrice() + ((this.getTax()*this.getPrice())/100)) * this.getDiscount()) / 100;
        return this.getPrice()-h;
    }

    public double calculaValorDesconto(){
        double h = (this.getPrice() * this.getTax()) / 100;
        return h;
    }

    public String toString(){
        return "The following :" + this.getReference() +" \n" + " with the description: " + this.getDescription() +"\n" + 
        "has a original price of :" + this.getPrice() +"\n" + "with tax and discount :" + calculaValorLinhaEnc();
    }

    public Linhadeencomenda(Linhadeencomenda other){
        this(other.getReference(), other.getDescription(), other.getPrice(),other.getQuantity(),other.getTax(),other.getDiscount());
    }

    public Linhadeencomenda clone(){
        return new Linhadeencomenda(this);
    }
}
