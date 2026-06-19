public class Banknosync {

    private static class Account {
        private int balance;
        Account(int balance) { this.balance = balance; }
        int balance() { return balance; }
        boolean deposit(int value) {
            balance += value;
            return true;
        }
        boolean withdraw(int value) {
            if (value > balance)
                return false;
            balance -= value;
            return true;
        }
    }

    // Bank slots and vector of accounts
    private int slots;
    private Account[] av; 

    public Banknosync(int n) {
        slots=n;
        av=new Account[slots];
        for (int i=0; i<slots; i++) av[i]=new Account(0);
    }

    // Account balance
    public int balance(int id) {
        if (id < 0 || id >= slots)
            return 0;
        return av[id].balance();
    }

    // Deposit
    public boolean deposit(int id, int value) {
        if (id < 0 || id >= slots)
            return false;
        return av[id].deposit(value);
    }

    // Withdraw; fails if no such account or insufficient balance
    public boolean withdraw(int id, int value) {
        if (id < 0 || id >= slots)
            return false;
        return av[id].withdraw(value);
    }

    public boolean transfer(int from, int to, int value){
        if(from < 0 || from >= slots || to < 0 || to >= slots){
            return false;
        }
        Account cfrom = av[from];
        Account cto = av[to];
        synchronized(cfrom){
            synchronized(cto){
                if(cfrom.withdraw(value)){
                    cto.deposit(value);
                    return true;
                }
            }
        }
        return false;
    }
    
    public int totalBalance() {
        int sum = 0;
        for (int i=0; i<slots; i++)
            sum += av[i].balance();
        return sum;
    }

}
