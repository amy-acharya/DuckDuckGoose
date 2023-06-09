public class PowerUps {
    private ArrayList<PowerUpType> activePowerUps;
    private ArrayList<Duck> extraSprites;

    public PowerUps() {
        activePowerUps = new ArrayList<PowerUpType>();
        extraSprites = new ArrayList<Duck>();
    }

    public String getPowerUpName(PowerUpType t) {
        switch (t) {
            case RAINING_DUCKS:
                return "It's raining ducks!";
            case FREEZE_GEESE:
                return "Geese are frozen!";
            case INVINCIBILITY:
                return "Geese do no damage!";
            default:
                return "No power ups active!";
        }
    }

    // check if a power is active
    public boolean isPowerActive(PowerUpType p) {
        for (PowerUpType s : activePowerUps) {
            if (p.equals(s)) {
                return true;
            }
        }
        return false;
    }

    public void addPowerUp(PowerUpType p) {
        activePowerUps.add(p);
    }

    public void removePowerUp(PowerUpType p) {
        activePowerUps.remove(p);
    }

    public ArrayList<PowerUpType> getActivePowerUps() {
        return activePowerUps;
    }

    public void resetPowerUps() {
        activePowerUps.clear();
    }

    // return how many ducks will be added in duck rain
    public int calculateDuckNum(int lvl) {
        if (lvl == 1) {
            return 1;
        }
        else if (level >= 10) {
            return lvl + calculateDuckNum(lvl - 1);
        }
        else {
            return calculateDuckNum(lvl - 1);
        }
    }

    // add extra ducks
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

    // display extra ducks
    public void displayExtraSprites() {
        for (int i = 0; i < extraSprites.size(); i++) {
            extraSprites.get(i).display();
            extraSprites.get(i).update();
            if (player.isTouching(extraSprites.get(i))) {
                extraSprites.get(i).reset();
                player.addToStack(extraSprites.get(i));
                player.incrementScore();
            }
        }
    }

    // stop duck rain
    public void endDuck(Pigeon p, int duckLvl) {
        if (isPowerActive(PowerUpType.RAINING_DUCKS)) {
            int duckNum = calculateDuckNum(duckLvl);

            if ((p.getScore() - 8 * (duckLvl - 1)) >= duckNum) {
                resetDuckRain();
            }
        }
    }

    // remove sprites
    public void resetDuckRain() {
        if (isPowerActive(PowerUpType.RAINING_DUCKS)) {
            extraSprites.clear();
            removePowerUp(PowerUpType.RAINING_DUCKS);
        }
    }
}