public class Duck extends Sprite
{
  private float x;
  private int speed; 
  
  
  public Duck (float x, int speed)
  {
     super("/Users/miaandreu/Desktop/SpriteLab_Challenging/data/duck.png", 0.3);
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
  
}
