public class Duck extends FallingSprite
{

  public Duck (float x, float speed)
  {
    super("duck.png", 0.07, x, speed);
  }
  
  public Duck (float maxSpeed) {
    super("duck.png", 0.07, maxSpeed);
  }
  
}
