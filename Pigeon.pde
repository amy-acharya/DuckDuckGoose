public class Pigeon extends Sprite {
    private float x;
    private float speed;
    private boolean alive;
    int score;
    
    public Pigeon(float x, float speed)
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
        if (x <= 0) {
            x = 0;
        }
    }
    
    public void moveRight()
    {
        x += speed + change_x;
        
        // collision with wall
        if (x >= width) {
            x = width;
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
    
    public boolean getAlive() {
        return alive;
    }
    
    public void setAlive(boolean a) {
        alive = a;
    }
    
    public boolean isTouchingDuck(Duck d) {
        float xPos = (x + super.getWidth() / 2);
        float yPos = height - 100; 
        float duckXPos = d.getXPos();
        float duckYPos = d.getYPos() + d.getHeight() / 2;
        float xBuffer = super.getWidth() / 2 + d.getWidth() / 2;
        
        if (Math.abs(xPos - duckXPos) < xBuffer) {
            if (Math.abs(yPos - duckYPos) < 10) {
                return true;
            }
        }
        return false;
        
        // loadPixels(d);
        // color c = pixels[yPos * width + xPos];
        // color c = get(xPos, yPos);
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
