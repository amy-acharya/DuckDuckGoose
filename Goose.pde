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
  
}
