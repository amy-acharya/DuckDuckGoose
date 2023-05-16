public class Level {
    private int num;
    private float fallSpeed;
    private int nSprites;
    private int scoreNeeded;

    public Level (int num, float fallSpeed, int nSprites, int scoreNeeded) {
        this.num = num;
        this.fallSpeed = fallSpeed;
        this.nSprites = nSprites;
        this.scoreNeeded = scoreNeeded;
    }

    public void display() {
        text("Level " + num, 0, 0);
    }
}