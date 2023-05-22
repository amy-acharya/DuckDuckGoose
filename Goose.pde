public class Goose extends Sprite
{
  private float x;
  private float speed; 
  private float maxSpeed;
  private boolean random;
  
  public Goose (float x, float speed)
  {
     super("goose.jpg", 0.3);
     this.x = x;
     this.speed = speed; 
     this.maxSpeed = speed;
     this.random = false;
  }
  
  public Goose (float maxSpeed) {
    super("goose.jpg", 0.3);
    this.maxSpeed = maxSpeed;
    this.speed = random(1, maxSpeed);
    this.x = random(0, width);
    this.random = true;
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
        if (center_y >= height) {
            reset();
        } 
    }

    public void reset() {
        center_y = 0;
        if (random) {
            x = random(0, width);
            speed = random(1, maxSpeed);
        }
    }

   public float getSpeed() {
    return speed;
  }

  public void setSpeed(float s) {
    speed = s;
  }

  public float getMaxSpeed() {
    return maxSpeed;
  }
  
  public void setMaxSpeed(float s) {
    maxSpeed = s;
  }

  public float getXPos() {
    return x;
  }

  public float getYPos() {
    return center_y;
  }
  
}
