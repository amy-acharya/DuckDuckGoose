public class PowerUps {
    private ArrayList<PowerUpType> activePowerUps;
    private ArrayList<Sprite> extraSprites;

    public PowerUps() {
        activePowerUps = new ArrayList<PowerUpType>();
        extraSprites = new ArrayList<Sprite>();
    }

    public String getPowerUpName(PowerUpType t) {
        switch (t) {
            case RAINING_DUCKS:
                return "It's Raining Ducks!";
            default:
                return "No power ups active!";
        }
    }

    public boolean isPowerActive(PowerUpType p) {
        for (PowerUpType s : activePowerUps) {
            if (p.equals(s)) {
                return true;
            }
        }
        return false;
    }

    public int calculateDuckNum(int lvl) {
        if (lvl == 1) {
            return 1;
        }
        else {
            return lvl + calculateDuckNum(lvl - 1);
        }
    }

    public boolean rainDucks(float currentMaxSpeed) {
        if (!(isPowerActive(PowerUpType.RAINING_DUCKS))) {
            return false;
        }

        int duckNum = calculateDuckNum(level);
        for (int i = 0; i < duckNum; i++) {
            extraSprites.add(new Duck(currentMaxSpeed));
        }

        return true;
    }

    public void displayExtraSprites() {
        for (int i = 0; i < extraSprites.size(); i++) {
            extraSprites.get(i).display();
            extraSprites.get(i).update();
        }
    }
}