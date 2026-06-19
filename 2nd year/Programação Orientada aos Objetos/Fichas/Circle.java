public class Circle {
    private double x;
    private double y;
    private double radius;

    public void changeCenter(double x, double y){
        this.x = x;
        this.y = y;
    }
    public double calculateArea(){
        return Math.PI * Math.pow(this.radius,2);
    }

    public double calculatePerimeter(){
        return 2* Math.PI *this.radius;
    }

    public Circle(){ //vazio
        this.x = 0;
        this.y = 0;
        this.radius = 1;
    }

    public double getX(){
        return this.x;
    }

    public void setX(double x){
        this.x = x;
    }

    public double getY(){
        return this.y;
    }

    public void setY(double y){
        this.y = y;
    }

    public double getRadius(){
        return this.radius;
    }

    public void setRadius(double radius){
        this.radius = radius;
    }
    public Circle(double x, double y, double radius){ //parametrizado
        this.x = x;
        this.y = y;
        this.radius = radius;
    }
    public Circle(Circle other){ //copia
        this.x = other.x;
        this.y = other.y;
        this.radius = other.radius;
    }

    public boolean equals(Object o){
        if(this == o) return true;
        if (o == null || this.getClass() != o.getClass()) return false;

        Circle c = (Circle) o;

        return this.x == c.x && this.y == c.y && this.radius == c.radius;
    }
    
    public String toString(){
        return "Circle[x"+ this.x + ",y=" + this.y + ",radius=" + this.radius + "]";
    }

    public Circle clone(){
        return new Circle(this);
    }

}
