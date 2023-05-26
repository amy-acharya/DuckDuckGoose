// declare global variables
Pigeon player;
Duck[] ducks;
Goose[] geese;
int numSprites;
PImage startscreen;
boolean started, levelStarted, isDuckStarted = false;
Level gameLevel;
boolean levelStarted = false;
char h = 104;
char i = 105;
PFont title, sub, screenTitle; 

// initialize them in setup().

void setup() {
    // for (int z = 0; z < PFont.list().length; z++) {
    //     System.out.println(PFont.list()[z]);
    // }
    size(1400, 750); // reserved variables width = 800, height = 600
    title = createFont ("Times New Roman", 80, true);
    sub = createFont("Times New Roman", 25, true);
    screenTitle = createFont("Times New Roman", 60, true);

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

    // 14 ducks to reach the top

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
        if (!powerUpManager.isPowerActive(PowerUpType.FREEZE_GEESE)) {
          geese[i].update();
        }

        if (player.isTouching(ducks[i])) {
            ducks[i].reset();
            player.addToStack(ducks[i]);
            player.incrementScore();
        }

        if (player.isTouching(geese[i])) {
<<<<<<< HEAD
            geese[i].reset();
            player.setScore(0);
            player.setAlive(false);
            player.resetStack();
            player.resetSpeed();
=======
            if (!powerUpManager.isPowerActive(PowerUpType.FREEZE_GEESE)) {
              geese[i].reset();
            }

            if (!powerUpManager.isPowerActive(PowerUpType.INVINCIBILITY)) {
              // consolidate all into function - endGame()
              //if (level > 1) {
              //player.setScore(0);
              player.setAlive(false);
              
              //player.resetStack();
              //}
              player.resetSpeed();
            }
>>>>>>> 1b04ff74117d0d28f3856c800332aa7049ccd82c
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
    if (powerUpManager.isPowerActive(PowerUpType.INVINCIBILITY)) {
      powerUpManager.removePowerUp(PowerUpType.INVINCIBILITY);
    }
    if (powerUpManager.isPowerActive(PowerUpType.FREEZE_GEESE)) {
      powerUpManager.removePowerUp(PowerUpType.FREEZE_GEESE);
    }

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

    if (level >= 2) {
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
          break;
        case INVINCIBILITY:
          powerUpManager.addPowerUp(newPower);
          break;
        case NONE:
          powerUpManager.resetPowerUps();
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
  // h key for how to screen
  // i key for game info screen
   if (key == h){
      howToScreen();
      started = false;
  }
  if (key == i){
      historyScreen();
      started = false;
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

<<<<<<< HEAD
void initScreen(){
=======
void initScreen() {
  title = createFont("Times New Roman", 80, true);
>>>>>>> 1b04ff74117d0d28f3856c800332aa7049ccd82c
  textFont(title);
  textAlign(CENTER);
  fill(0);
  text ("Duck Duck Goose", 950, 210);
  textFont(sub);
  text ("press enter to start", 950, 255);
}

void gameOverScreen() {
  // title = createFont("Times New Roman", 80, true);
  // textFont(title);
  // textAlign(CENTER);
  // fill(0);
  // text ("Game Over", 950, 210);
  // sub = createFont("Times New Roman", 25, true);
  // textFont(sub);
  // text ("press [KEY] to play again", 950, 255);
}

void historyScreen(){
background(218, 247, 166);
textFont(screenTitle);
text ("The History of the Pigeon", 700, 200);
textFont(sub);
text ("The History of the Pigeon", 700, 280);

}

void howToScreen(){
 background(255, 173, 49);
 textFont(screenTitle);
 text ("How to Play", 700, 200);
 textFont(sub);
 text ("collect the ducks and avoid the geese", 700, 280);
 text ("use the arrow keys to move pigeon left and right", 700, 315);
 text ("once enough ducks are collected you will level up", 700, 350);
}

/*
TO DO:
- splash screen w/ three buttons - start, how to play (i), history (h) - creative twist
  - character select if we have time?
- animate sprites
- fancy graphics
  - fade in/out for screens
  - screen between levels
<<<<<<< HEAD
- unjankify collisions/stacking
  - lil space between the ground and the lowest duck
=======
>>>>>>> 1b04ff74117d0d28f3856c800332aa7049ccd82c
- check class management
- figure out the font
- audrey wants to add guns
- power ups
- add game over screen!!!

- search method for array
- nested for loop
<<<<<<< HEAD
- recursive formula/function
- execution of how game operates
- creative twist on history of game
*/
=======
*/
>>>>>>> 1b04ff74117d0d28f3856c800332aa7049ccd82c
