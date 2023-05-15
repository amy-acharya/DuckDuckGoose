public class Duck extends Sprite
{
  private float x;
  private float speed; 
  
  public Duck (float x, float speed)
  {
     super("duck.jpg", 0.3);
     this.x = x;
     this.speed = speed; 
  }
  
  public void display()
  {
    image(image, x, center_y, w, h);
  }
  
  public void update()
  {
     center_y += speed + change_y;
  }

  // TEST THIS FUNCTION
  public void hide() {
    image(image, 0, 0, 0, 0);
  }
  
}
