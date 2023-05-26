
//declare global variables
Sprite duck, goose, ducky, gose;

//initialize them in setup().
void setup() {
  size(800, 600); // reserved variables width = 800, height = 600
  imageMode(CENTER);
  // create player sprite with small scale(e.g. 0.5).
  duck = new Sprite ("duck.png", 0.3, 100, 100);
  
  // create crate sprite with larger scale(e.g 2.0).
  goose = new Sprite ("goose.png", 0.3, 450, 50);
  // Use reserved variables width, height to position this sprite.
  
  ducky = new Duck(600, 3);
  gose = new Goose(200, 2);

}

// modify and update them in draw().
void draw(){
  background(255);
  
  // display and update s1 and s2.
  duck.display();
  duck.update();
  
  ducky.display();
  ducky.update();
   
  goose.display();
  goose.update();
  
  gose.display();
  gose.update();
  
} 




