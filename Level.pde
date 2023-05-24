public class Level {
    private int num;
    private float fallSpeedMultiplier;
    private int nSprites;

    public Level (int num, float fallSpeedMultiplier, int nSprites) {
        this.num = num;
        this.fallSpeedMultiplier = fallSpeedMultiplier;
        this.nSprites = nSprites;
    }

    public void display() {
        PFont lvlText = createFont("Times New Roman", 48, true);
        textFont(lvlText);
        textAlign(CENTER);
        fill(0);
        text ("Level " + num, 100, 50);
    }

    public void displayScore(int s) {
        PFont scoreText = createFont("Times New Roman", 36, true);
        textFont(sub);
        text ("score: " + s, 100, 75);
    }

    public void initLevel(Pigeon p) {
        noStroke();
        colorMode(RGB, 255, 255, 255);
        fill(198, 255, 138);
        // hardcode for now until I can find a fix
        rect(0, height - 150, width, 250);
        //rect(0, p.getPigeonY() + 100, width, height - p.getPigeonY());
    }

    public float getFallSpeedMultiplier() {
        return fallSpeedMultiplier;
    }
}