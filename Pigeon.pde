public class Pigeon extends Sprite {
    private float x;
    private float speed;
    private boolean alive;

    public Pigeon (float x, float speed)
    {
        super("pigeon.png", 0.2);
        this.x = x;
        this.speed = speed; 
        this.alive = true;
    }
  
  public void display()
  {
    image(image, x, 500, w, h);
  }
  
   public void moveLeft()
   {
     x -= speed + change_x;
   }

   public void moveRight()
   {
     x += speed + change_x;
   }
}
