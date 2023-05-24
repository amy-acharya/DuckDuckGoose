public class Duck extends FallingSprite
{

  public Duck (float x, float speed)
  {
    super("duck.png", 0.3, x, speed);
  }
  
  public Duck (float maxSpeed) {
    super("duck.png", 0.3, maxSpeed);
  }
  
}
