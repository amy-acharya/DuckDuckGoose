public class Level {
    private int num;
    private float fallSpeedMultiplier;
    private int nSprites;

    public Level (int num, float fallSpeedMultiplier, int nSprites) {
        this.num = num;
        this.fallSpeedMultiplier = fallSpeedMultiplier;
        this.nSprites = nSprites;
    }

    // display level number
    public void display() {
        PFont lvlText = createFont("Times New Roman", 48, true);
        textFont(lvlText);
        textAlign(CENTER);
        if (level > 5) {
            fill(255);
        }
        else {
            fill(0);
        }
        text ("Level " + level, 100, 50);
    }

    // display score
    public void displayScore(int s) {
        PFont scoreText = createFont("Times New Roman", 36, true);
        textFont(sub);
        text ("score: " + s, 100, 75);
    }

    // draw ground
    public void initLevel(Pigeon p, int lvl) {
        noStroke();
        colorMode(HSB, 360, 100, 100);
        fill(89, 46 - (lvl - 1) * 10, 100);
        rect(0, height - 150, width, 250);
    }

    public float getFallSpeedMultiplier() {
        return fallSpeedMultiplier;
    }
}