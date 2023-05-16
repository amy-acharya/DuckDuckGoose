public class Duck extends Sprite
{
  private float x;
  private float speed; 
  private boolean random;
  
  public Duck (float x, float speed)
  {
    super("duck.jpg", 0.3);
    this.x = x;
    this.speed = speed;
    this.random = false;
  }
  
  public Duck (float maxSpeed) {
    super("duck.jpg", 0.3);
    this.speed = random(1, maxSpeed);
    this.x = random(0, width);
    this.random = true;
  }
  
  public void display()
  {
    image(image, x, center_y, w, h);
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
            speed = random(1, speed);
        }
    }

  // TEST THIS FUNCTION
  public void hide() {
    image(image, 0, 0, 0, 0);
  }

  public float getSpeed() {
    return speed;
  }

  public void setSpeed(int s) {
    speed = s;
  }

  public float getXPos() {
    return x;
  }

  public float getYPos() {
    return center_y;
  }
  
}
