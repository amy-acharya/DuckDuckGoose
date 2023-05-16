public class Goose extends Sprite
{
  private float x;
  private float speed; 
  
  public Goose (float x, float speed)
  {
     super("goose.jpg", 0.3);
     this.x = x;
     this.speed = speed; 
    
  }
  
  public void display()
  {
    image(image, x, center_y, w, h);
    if (center_y >= height) {
      center_y = 0;
    }
  }
  
   public void update()
   {
     center_y += speed + change_y;
   }
   
    public boolean isTouchingGoose(Goose g) {
        float xPos = (x + super.getWidth() / 2);
        float yPos = height - 100; 
        float gooseXPos = g.getXPos();
        float gooseYPos = g.getYPos() + g.getHeight() / 2;
        float xBuffer = super.getWidth() / 2 + g.getWidth() / 2;

        if (Math.abs(xPos - gooseXPos) < xBuffer) {
            if (Math.abs(yPos - gooseYPos) < 10) {
                return true;
            }
        }
        return false;
    }
  
}
