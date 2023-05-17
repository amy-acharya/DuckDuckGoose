// declare global variables
Pigeon player;
Duck[] ducks;
Goose[] geese;
int numSprites;

// initialize them in setup().
void setup() {
    size(1400, 750); // reserved variables width = 800, height = 600
    imageMode(CENTER);

    player = new Pigeon(width / 2.0, 3.0);

    // can be changed depending on how many ducks/geese we want
    numSprites = 5;

    ducks = new Duck[numSprites];
    geese = new Goose[numSprites];

    for (int i = 0; i < numSprites; i++) {
        ducks[i] = new Duck(3);
        geese[i] = new Goose(2);
    }
}

// modify and update them in draw().
void draw() {
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
    } 
    // System.out.println(player.getScore());
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