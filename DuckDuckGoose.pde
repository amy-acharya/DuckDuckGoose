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

// initialize them in setup().
void setup() {
    // for (int z = 0; z < PFont.list().length; z++) {
    //     System.out.println(PFont.list()[z]);
    // }
    size(1400, 750); // reserved variables width = 800, height = 600

    player = new Pigeon(width / 2.0, 5.0);

    // can be changed depending on how many ducks/geese we want
    numSprites = 5;

    ducks = new Duck[numSprites];
    geese = new Goose[numSprites];
    
    for (int i = 0; i < numSprites; i++) {
        ducks[i] = new Duck(3);
        geese[i] = new Goose(2);
    }
  startscreen = loadImage("farmScreen.jpg");
  image(startscreen, 0,0, width, height);
  initScreen();

} 

// modify and update them in draw().
void draw(){
  if (started) {
    colorMode(HSB, 360, 100, 100);
    background(186, 15 + (level * 10), 100);
    colorMode(RGB);
    player.display();

    for (int i = 0; i < numSprites; i++) {
        ducks[i].display();
        ducks[i].update();

        geese[i].display();
        geese[i].update();

        if (player.isTouchingDuck(ducks[i])) {
            ducks[i].reset();
            player.incrementScore();
        }
        if (player.isTouchingGoose(geese[i])) {
            geese[i].reset();
            player.setScore(0);
            player.setAlive(false);
        }
    //} 
    // System.out.println(player.getScore());
} 
}
}


// control pigeon using arrow keys
void keyPressed() {

  if(!started){
    if (key == ENTER || key == RETURN){
      started = true;
      level = 1; // find the best place to set the level
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
  title = createFont("Koho-Regular", 80, true);
  textFont(title);
  textAlign(CENTER);
  fill(0);
  text ("Duck Duck Goose", 950, 210);
  sub = createFont("Koho-Regular", 25, true);
  textFont(sub);
  text ("press enter to start", 950, 255);
}


/*
TO DO:

- collisions - FINISHED
  - stacking
- splash screen w/ three buttons - start, how to play (i), history (h)
  - character select if we have time?
- level up when touching the top
  - how to make each progressive level harder
  - ducks and geese fall faster
  - background gets darker the higher you go
- animate sprites
- sprites can go off the screen - fix?
  - fixed for pigeon
- speed up pigeon/fix janky mechanics
- consolidate duck and goose classes into falling sprites?
  - better class management
- figure out the font

- search method for array
- nested for loop
- recursive formula/function
- execution of how game operates
- creative twist on history of game
*/