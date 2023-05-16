public class Pigeon extends Sprite {
    private float x;
    private float speed;
    private boolean alive;
    int score;

    public Pigeon (float x, float speed)
    {
        super("pigeon.png", 0.2);
        this.x = x;
        this.speed = speed; 
        this.alive = true;
        this.score = 0;
    }
  
    public void display()
    {
        image(image, x, height - 100, w, h);
    }
  
    public void moveLeft()
    {
        x -= speed + change_x;

        // collision with wall
        if (x >= width) {
            x = width;
        }
    }

    public void moveRight()
    {
        x += speed + change_x;

        // collision with wall
        if (x <= 0) {
            x = 0;
        }
    }

    public void incrementScore() {
        score++;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int s) {
        score = s;
    }
}
