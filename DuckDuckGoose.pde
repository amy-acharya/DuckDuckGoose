// declare global variables
Pigeon player;
Duck[] ducks;
Goose[] geese;
int numSprites, level;
PImage startscreen;
boolean started, isDuckStarted = false;
Level gameLevel;
char h = 104;
char i = 105;
PFont title, sub, screenTitle; 
PowerUps powerUpManager;

// initialize them in setup().

void setup() {
    size(1400, 750); 
    title = createFont ("Times New Roman", 80, true);
    sub = createFont("Times New Roman", 25, true);
    screenTitle = createFont("Times New Roman", 60, true);

    player = new Pigeon(width / 2.0, 8.0);
    player.setupAnimate();

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

    // Nested for loop:
    int [][] example2D = new int[3][5];
    for (int r = 0; r < example2D.length; r++) {
      for (int c = 0; c < example2D[0].length; c++) {
        example2D[r][c] = r + c;
      }
    }

} 

// modify and update them in draw().
void draw() {
  if (started) {
    
    tint(255, 255);
    colorMode(HSB, 360, 100, 100);
    background(186, 15 + (level * 20), 100 - ((level - 1) * 10));

    gameLevel.initLevel(player, level);
     
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

            tint(255, 0);
            gameOverScreen();
            started = false;
            geese[i].reset();
            player.setScore(0);
            player.setAlive(false);
            player.resetStack();
            player.resetSpeed();

            if (!powerUpManager.isPowerActive(PowerUpType.FREEZE_GEESE)) {
              geese[i].reset();
            }

            if (!powerUpManager.isPowerActive(PowerUpType.INVINCIBILITY)) {
              player.setScore(0);
              player.setAlive(false);
              player.resetStack();
              player.resetSpeed();
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
      player.animate();
    }
    else if (keyCode == RIGHT) {
      player.moveRight();
      player.animate();
    }
    
  }
}


void initScreen() {
  title = createFont("Times New Roman", 80, true);
  textFont(title);
  textAlign(CENTER);
  fill(0);
  text ("Duck Duck Goose", 950, 200);
  textFont(sub);
  text ("press enter to start", 950, 255);
  textSize(15);
  text ("press h to learn how to play", 1000, 285);
  text ("press i for history of the game ", 1005, 305);
}

void gameOverScreen() {
  background(0);
  textFont(title);
  fill(255);
  text ("Game Over", 700, 300);
  textFont(sub);
  text("your score was " + player.getScore(), 700, 360);
  text ("press ENTER to play again", 700, 410);
}

void historyScreen(){
background(218, 255, 63);
textFont(screenTitle);
text ("The History of the Pigeon", 700, 200);
textFont(sub);
text ("for years and years, kids have been sitting in a circle tapping heads", 700, 280);
text ("the ducks and geese, having heard their names, came to watch and soon joined in on the merry game ", 700, 320);
text ("on the side lines, poor pigeon watched, wishing to be included in all the fun", 700, 360);
text ("this game is his revenge. ", 700, 400);

}

void howToScreen(){
 background(255, 209, 101);
 textFont(screenTitle);
 text ("How to Play", 700, 200);
 textFont(sub);
 text ("move the pigeon under a duck to form a stack", 700, 320);
 text ("use the arrow keys to move pigeon left and right", 700, 280);
 text ("hitting a goose will end the game ", 700, 360);
 text ("you will level up once you stack up to the top of the screen ", 700, 400);
}

/*
TO DO:
- character select if we have time?
- animate sprites
- fancy graphics
  - fade in/out for screens
*/
