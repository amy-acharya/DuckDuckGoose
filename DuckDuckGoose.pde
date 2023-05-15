// declare global variables
Pigeon player;
Duck[] ducks;
Goose[] geese;
int numSprites;

// initialize them in setup().
void setup(){
  size(800, 600); // reserved variables width = 800, height = 600
  imageMode(CENTER);

  player = new Pigeon(400.0, 3.0);

  // can be changed depending on how many ducks/geese we want
  numSprites = 5;

  ducks = new Duck[numSprites];
  geese = new Goose[numSprites];

  for (int i = 0; i < numSprites; i++) {

    ducks[i] = new Duck(random(800), random(1, 3));
    geese[i] = new Goose(random(800), random(1, 2));
  }
}

// modify and update them in draw().
void draw(){
  background(255);

  player.display();

  for (int i = 0; i < numSprites; i++) {
    ducks[i].display();
    ducks[i].update();

    geese[i].display();
    geese[i].update();
  } 
} 

// control pigeon using arrow keys
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      player.moveLeft();
    }
    else if (keyCode == RIGHT) {
      player.moveRight();
    }
  }
}


/*
TO DO:

- collisions
  - stacking
- track score
- splash screen w/ three buttons - start, how to play, history
- level up when touching the top
  - how to make each progressive level harder
- animate sprites
- sprites can go off the screen - fix?

- getter/setter methods
- search method for array
- nested for loop
- recursive formula/function
- execution of how game operates
- creative twist on history of game
*/