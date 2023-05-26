// declare global variables
Pigeon player;
Duck[] ducks;
Goose[] geese;
int numSprites, level;
PFont title, sub;
PImage startscreen;
boolean started, levelStarted, isDuckStarted = false;
Level gameLevel;
PowerUps powerUpManager;

// initialize them in setup().

void setup() {
    // for (int z = 0; z < PFont.list().length; z++) {
    //     System.out.println(PFont.list()[z]);
    // }
    size(1400, 750); // reserved variables width = 800, height = 600

    player = new Pigeon(width / 2.0, 8.0);

    // can be changed depending on how many ducks/geese we want
    numSprites = 5;

    level = 1;

    ducks = new Duck[numSprites];
    geese = new Goose[numSprites];

    for (int i = 0; i < numSprites; i++) {
        ducks[i] = new Duck(3);
        geese[i] = new Goose(2);
    }

    gameLevel = new Level(level, 1.0, numSprites);
    powerUpManager = new PowerUps();
    startscreen = loadImage("farmScreen.jpg");
    image(startscreen, 0,0, width, height);
    initScreen();

} 

// modify and update them in draw().
void draw() {
  if (started) {    
    colorMode(HSB, 360, 100, 100);
    background(186, 15 + (level * 20), 100 - ((level - 1) * 10));
    //colorMode(RGB);

    gameLevel.initLevel(player);

    // if (!levelStarted) {
    //   colorMode(HSB, 360, 100, 100);
    //   background(186, 15 + (level * 10), 100);
    //   colorMode(RGB);

    //   gameLevel.initLevel(player);
    //   levelStarted = true;
    // }
    
    player.display();
    gameLevel.display();
    gameLevel.displayScore(player.getScore());

    for (int i = 0; i < numSprites; i++) {
        ducks[i].display();
        ducks[i].update();

        geese[i].display();
        geese[i].update();

        if (player.isTouching(ducks[i])) {
            ducks[i].reset();
            player.addToStack(ducks[i]);
            player.incrementScore();
        }

        if (player.isTouching(geese[i])) {
            geese[i].reset();

            if (!powerUpManager.isPowerActive(PowerUpType.INVINCIBILITY)) {
              // consolidate all into function - endGame()
              //player.setScore(0);
              player.setAlive(false);
              //player.resetStack();
              //player.resetSpeed();
            }
        }
    }
    powerUpManager.displayExtraSprites();
    if (isDuckStarted) {
        powerUpManager.endDuck(player, level);
    }

    player.displayStack(ducks[0]); 
  }
  
  if (player.getPigeonY() <= 0) {
    level++;

    // reset speed
    for (int i = 0; i < numSprites; i++) {
      ducks[i].setMaxSpeed(ducks[i].getMaxSpeed() / gameLevel.getFallSpeedMultiplier());
      geese[i].setMaxSpeed(geese[i].getMaxSpeed() / gameLevel.getFallSpeedMultiplier());
    }

    gameLevel = new Level(level, 1 + 0.5 * (level - 1), numSprites);
    player.resetStack();

    // update speed
    for (int i = 0; i < numSprites; i++) {
      ducks[i].setMaxSpeed(ducks[i].getMaxSpeed() * gameLevel.getFallSpeedMultiplier());
      geese[i].setMaxSpeed(geese[i].getMaxSpeed() * gameLevel.getFallSpeedMultiplier());
    }

    // increase pigeon speed
    player.setSpeed(player.getSpeed() + 1);

    if (level >= 0) {
      PowerUpType newPower = PowerUpType.getRandomPower();
      System.out.println(newPower);
      
      switch (newPower) {
        case RAINING_DUCKS:
          powerUpManager.resetDuckRain();
          powerUpManager.addPowerUp(newPower);
          isDuckStarted = powerUpManager.rainDucks(ducks[0].getMaxSpeed()); 
          break;
        case FREEZE_GEESE:
          powerUpManager.addPowerUp(newPower);
          // add code
          System.out.println("gooses");
          break;
        case INVINCIBILITY:
          powerUpManager.addPowerUp(newPower);
          powerUpManager.invincibilityTimer();
          break;
      }
    }
  }
}

// control pigeon using arrow keys
void keyPressed() {
  if (!started){
    if (key == ENTER || key == RETURN){
      started = true;
    }
  }
  
  if (key == CODED) {
    if (keyCode == LEFT) {
      player.moveLeft();
    }
    else if (keyCode == RIGHT) {
      player.moveRight();
    }
  }
}

void initScreen() {
  title = createFont("Times New Roman", 80, true);
  textFont(title);
  textAlign(CENTER);
  fill(0);
  text ("Duck Duck Goose", 950, 210);
  sub = createFont("Times New Roman", 25, true);
  textFont(sub);
  text ("press enter to start", 950, 255);
}


/*
TO DO:
- splash screen w/ three buttons - start, how to play (i), history (h) - creative twist
  - character select if we have time?
- animate sprites
- fancy graphics
  - fade in/out for screens
  - screen between levels
- check class management
- figure out the font
- audrey wants to add guns
- power ups
  - test raining ducks
- add game over screen!!!
- delete sprites from duck rain

- nested for loop
*/