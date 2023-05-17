// declare global variables
Pigeon player;
Duck[] ducks;
Goose[] geese;
int numSprites;
PFont title, sub;
PImage startscreen;
int  stage;
boolean started = false;

// initialize them in setup().

void setup() {
    size(1400, 750); // reserved variables width = 800, height = 600
  

    player = new Pigeon(width / 2.0, 3.0);

    // can be changed depending on how many ducks/geese we want
    numSprites = 5;

    ducks = new Duck[numSprites];
    geese = new Goose[numSprites];
    
    for (int i = 0; i < numSprites; i++) {
        ducks[i] = new Duck(3);
        geese[i] = new Goose(2);
    
    ducks[i] = new Duck(random(width), random(1, 3));
    geese[i] = new Goose(random(width), random(1, 2));
    }



 
  startscreen = loadImage("farmScreen.jpg");
  image(startscreen, 0,0, 1400, 750);
  initScreen();

} 






// modify and update them in draw().
void draw(){
  if (started){
  background(255);

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

  if(started == false){
      if (key == RETURN || key == ENTER){
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

- collisions - FINISHED
  - stacking
- splash screen w/ three buttons - start, how to play, history
- level up when touching the top
  - how to make each progressive level harder
- animate sprites
- sprites can go off the screen - fix?
  - fixed for pigeon
- speed up pigeon/fix janky mechanics
- consolidate duck and goose classes into falling sprites?
  - better class management

- search method for array
- nested for loop
- recursive formula/function
- execution of how game operates
- creative twist on history of game
*/