interface Bar {
    void entra() throws InterruptedException;
    void sai();
}
/* 
Existem N lugares no bar
Cada cliente (thread) quer entrar
Se não houver lugar livre → espera
Quando um cliente sai → liberta um lugar e acorda alguém

máximo de clientes dentro = N
entra() bloqueia se não houver lugar
sai() liberta 1 lugar
evitar starvation (usar while, não if)
usar monitor (synchronized, wait, notifyAll)
*/
class BarImpl implements Bar{
    final int N;
    private int entrou = 0;
    public BarImpl(int N){
        this.N = N;
    }
    public synchronized void entra() throws InterruptedException{
        while(entrou > N){
            wait();
        }
        entrou++;
    }
    public synchronized void sai(){
        entrou--;
        notifyAll();
    }
}