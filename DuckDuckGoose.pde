// declare global variables
Pigeon player;
Duck[] ducks;
Goose[] geese;
int numSprites;
PFont title, sub;
PImage startscreen;
int stage;
int level;
boolean started = false;
Level gameLevel;
boolean levelStarted = false;

// initialize them in setup().

void setup() {
    // for (int z = 0; z < PFont.list().length; z++) {
    //     System.out.println(PFont.list()[z]);
    // }
    size(1400, 750); // reserved variables width = 800, height = 600
  

    player = new Pigeon(width / 2.0, 5.0);

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
    startscreen = loadImage("farmScreen.jpg");
    image(startscreen, 0,0, width, height);
    initScreen();

} 

// modify and update them in draw().
void draw() {
  if (started) {    
    colorMode(HSB, 360, 100, 100);
    background(186, 15 + (level * 20), 100);
    colorMode(RGB);

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
        geese[i].update();

        if (player.isTouching(ducks[i])) {
            ducks[i].reset();
            player.addToStack(ducks[i]);
            player.incrementScore();
        }

        if (player.isTouching(geese[i])) {
            geese[i].reset();
            player.setScore(0);
            player.setAlive(false);
            player.resetStack();
        }
    }

    player.displayStack(ducks[0]); 
  }
  
  if (player.getPigeonY() <= 0) {
    float multiplier = gameLevel.getFallSpeedMultiplier();
    level++;

    // reset speed
    for (int i = 0; i < numSprites; i++) {
      ducks[i].setMaxSpeed(ducks[i].getMaxSpeed() / multiplier);
      geese[i].setMaxSpeed(geese[i].getMaxSpeed() / multiplier);
    }

    gameLevel = new Level(level, 1 + 0.5 * (level - 1), numSprites);
    player.resetStack();

    // update speed
    for (int i = 0; i < numSprites; i++) {
      ducks[i].setMaxSpeed(ducks[i].getMaxSpeed() * multiplier);
      geese[i].setMaxSpeed(geese[i].getMaxSpeed() * multiplier);
    }

    // increase pigeon speed
    player.setSpeed(player.getSpeed() + 1);
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

void initScreen(){
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
- splash screen w/ three buttons - start, how to play (i), history (h)
  - character select if we have time?
- animate sprites
- fancy graphics
- fix janky mechanics
- unjankify collisions/stacking
  - lil space between the ground and the lowest duck
- check class management
- figure out the font
- audrey wants to add guns
- power ups

- search method for array
- nested for loop
- recursive formula/function
- execution of how game operates
- creative twist on history of game
*/