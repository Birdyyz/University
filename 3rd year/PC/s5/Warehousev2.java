import java.util.*;
import java.util.concurrent.locks.*;

class Warehousev2 {
    private Map<String, Product> map =  new HashMap<String, Product>();
// se aq fosse static ja n fariamos o cond aq
    private class Product { 
        int quantity = 0; 
        Condition cond = l.newCondition();        
    }
    private Lock l = new ReentrantLock();
    
    // como é private assumimos que o lock e unlock ja estao adquiridos
    private Product get(String item) {
        Product p = map.get(item);
        if (p != null) return p;
        p = new Product();
        map.put(item, p);
        return p;
    }

    public void supply(String item, int quantity){
        l.lock();
        Product p = get(item);
        try {
            p.quantity += quantity;
        } finally {
            // temos de fazer signal all pq nao sabemos quantas threads estao a espera de um produto
            p.cond.signalAll();
            l.unlock();
        }
    }
    private Product missing(Product[] prods){
        for (Product p : prods)
            if (p.quantity == 0)
                return p;
        return null;
    }

    // Errado se faltar algum produto...
    public void consume(Set<String> items) throws InterruptedException {
        l.lock();
        try {
            Product[] products = new Product[items.size()];
             int i = 0;
            for (String s : items){
                products[i++] = get(s);
                }
            for(;;){
                Product p = missing(products);
                if(p == null) break;
                p.cond.await();
            }
            for(Product p : products){
                p.quantity--;
            }
            }
        finally{
            l.unlock();
        }
    }
}