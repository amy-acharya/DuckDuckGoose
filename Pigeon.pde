public class Pigeon extends Sprite {
    private float x;
    private float y;
    private float speed;
    private boolean alive;
    private int score;
    private ArrayList<PImage> duckStack;

    
    public Pigeon(float x, float speed)
    {
        super("pigeon.png", 0.2);
        this.x = x;
        this.y = height - 250;
        this.speed = speed; 
        this.alive = true;
        this.score = 0;
        duckStack = new ArrayList<PImage>();
    }
    
    public void display()
    {
        image(image, x, y, w, h);
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
    
    public boolean isAlive() {
        return alive;
    }
    
    public void setAlive(boolean a) {
        alive = a;
    }

    public float getPigeonY() {
        return y;
    }
    
    public boolean isTouchingDuck(Duck d) {
        float xPos = (x + super.getWidth() / 2);
        float yPos = y; 
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
        float yPos = y; 
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

    public void addToStack(Duck d) {
        PImage newDuck = loadImage("duck.jpg");
        duckStack.add(newDuck);
        y -= d.getHeight();
    }

    public void displayStack(Duck d) {
        if (duckStack.size() == 0) {
            return;
        }
        for (int i = 0; i < duckStack.size(); i++) {
            image(duckStack.get(i), x, y + (d.getHeight() * (i + 1)) + super.getHeight() / 2, d.getWidth(), d.getHeight());
        }
    }

    public void resetStack() {
        y = height - 250;
        duckStack.clear();
    }
}
