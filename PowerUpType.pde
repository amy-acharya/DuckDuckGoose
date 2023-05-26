enum PowerUpType {
    RAINING_DUCKS,
    FREEZE_GEESE,
    INVINCIBILITY,
    NONE;

    public static PowerUpType getRandomPower() {
        PowerUpType[] vals = PowerUpType.values();
        int randIndex = (int) (Math.random() * vals.length);
        return vals[randIndex];
    }
}