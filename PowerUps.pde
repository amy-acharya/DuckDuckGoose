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
            if (player.isTouching(extraSprites.get(i))) {
                extraSprites.get(i).reset();
                player.addToStack(extraSprites.get(i));
                player.incrementScore();
            }
        }
    }

    public void endDuck(Pigeon p, int duckLvl) {
        if (isPowerActive(PowerUpType.RAINING_DUCKS)) {
            int duckNum = calculateDuckNum(duckLvl);

            if ((p.getScore() - 8 * (duckLvl - 1)) >= duckNum) {
                resetDuckRain();
            }
        }
    }

    public void resetDuckRain() {
        if (isPowerActive(PowerUpType.RAINING_DUCKS)) {
            extraSprites.clear();
            removePowerUp(PowerUpType.RAINING_DUCKS);
        }
    }

    public void invincibilityTimer() {
        if (isPowerActive(PowerUpType.INVINCIBILITY)) {
            //Thread.sleep(30000);
            removePowerUp(PowerUpType.INVINCIBILITY);
        }
    }
}