public class Level {
    private int num;
    private float fallSpeedMultiplier;
    private int nSprites;
    private int scoreNeeded;

    public Level (int num, float fallSpeedMultiplier, int nSprites, int scoreNeeded) {
        this.num = num;
        this.fallSpeedMultiplier = fallSpeedMultiplier;
        this.nSprites = nSprites;
        this.scoreNeeded = scoreNeeded;
    }

    public void display() {
        text("Level " + num, 0, 0);
    }

    public void initLevel(Pigeon p) {
        noStroke();
        colorMode(RGB, 255, 255, 255);
        fill(198, 255, 138);
        // hardcode for now until I can find a fix
        rect(0, height - 150, width, 250);
        //rect(0, p.getPigeonY() + 100, width, height - p.getPigeonY());
    }

    public int getScoreNeeded() {
        return scoreNeeded;
    }
}