public class Goose extends FallingSprite
{
  
  public Goose (float x, float speed)
  {
     super("goose.png", 0.07, x, speed);
  }
  
  public Goose (float maxSpeed) {
    super("goose.png", 0.07, maxSpeed);
  }
  
}
