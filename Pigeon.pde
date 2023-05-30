public class Pigeon extends Sprite {
    private float x;
    private float y;
    private float speed;
    private boolean alive;
    private int score;
    private ArrayList<PImage> duckStack;
    PImage[] sprites;
    private int numFrames;
    //float xPos = 0;
    //float xSpeed = 2;

    
    public Pigeon(float x, float speed)
    {
        super("pigeon.png", 0.07);
        this.x = x;
        this.y = height - 250;
        this.speed = speed; 
        this.alive = true;
        this.score = 0;
        duckStack = new ArrayList<PImage>();
        this.numFrames = 4;
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

    public void setupAnimate() {
        sprites = new PImage[numFrames];
        for (int i = 0; i < numFrames; i++) 
        {
            sprites[i] = loadImage("sprite" + i + ".png");
        }
    }

    public void animate() {
        int index = frameCount % numFrames;
        image(sprites[index], x, y, super.getWidth(), super.getHeight());
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

    public float getSpeed() {
        return speed;
    }

    public void setSpeed(float s) {
        speed = s;
    }

    public void resetSpeed() {
        speed -= (level - 1);
    }

    public boolean isTouching(Sprite s) {
        float xPos = (x + super.getWidth() / 2);
        float yPos = y; 
        float spriteXPos = s.getXPos();
        float spriteYPos = s.getYPos() + s.getHeight() / 2;
        float xBuffer = super.getWidth() / 2 + s.getWidth() / 2;
        
        if (Math.abs(xPos - spriteXPos) < xBuffer) {
            if (Math.abs(yPos - spriteYPos) < 10) {
                return true;
            }
        }
        return false;

        // loadPixels(d);
        // color c = pixels[yPos * width + xPos];
        // color c = get(xPos, yPos);
    }
    
    public void addToStack(Duck d) {
        PImage newDuck = loadImage("duck.png");
        duckStack.add(newDuck);
        y -= d.getHeight();
    }

    public void displayStack(Duck d) {
        if (duckStack.size() == 0) {
            return;
        }
        for (int i = 0; i < duckStack.size(); i++) {
            // AAAAAAAAAAAAAAAAAAA
            image(duckStack.get(i), x + super.getWidth() / 4, y + (d.getHeight() * (i + 1)) + super.getHeight() / 2, d.getWidth(), d.getHeight());
        }
    }

    public void resetStack() {
        y = height - 250;
        duckStack.clear();
    }
}
