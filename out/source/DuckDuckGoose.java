/* autogenerated by Processing revision 1292 on 2023-05-17 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class DuckDuckGoose extends PApplet {

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
public void setup(){
 
 /* size commented out by preprocessor */;

  player = new Pigeon(width / 2.0f, 3.0f);

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
public void draw(){
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
public void keyPressed() {

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

public void initScreen(){
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

- collisions - TEST COLLISION CHECKING
  - stacking
- track score - FINISHED
  - increment when collision w/ duck
  - reset after collision w/ goose
- splash screen w/ three buttons - start, how to play, history
- level up when touching the top
  - how to make each progressive level harder
- animate sprites
- sprites can go off the screen - fix?
  - fixed for pigeon
- consolidate duck and goose classes into falling sprites?
  - better class management

- search method for array
- nested for loop
- recursive formula/function
- execution of how game operates
- creative twist on history of game
*/
public class Duck extends Sprite
{
  private float x;
  private float speed; 
  private boolean random;
  
  public Duck (float x, float speed)
  {
    super("duck.jpg", 0.3f);
    this.x = x;
    this.speed = speed;
    this.random = false;
  }
  
  public Duck (float maxSpeed) {
    super("duck.jpg", 0.3f);
    this.speed = random(1, maxSpeed);
    this.x = random(0, width);
    this.random = true;
  }
  
  public void display()
  {
    image(image, x, center_y, w, h);
  }
  
    public void update()
    {
        center_y += speed + change_y;
        if (center_y >= height) {
            reset();
        } 
    }

    public void reset() {
        center_y = 0;
        if (random) {
            x = random(0, width);
            speed = random(1, speed);
        }
    }

  // TEST THIS FUNCTION
  public void hide() {
    image(image, 0, 0, 0, 0);
  }

  public float getSpeed() {
    return speed;
  }

  public void setSpeed(int s) {
    speed = s;
  }

  public float getXPos() {
    return x;
  }

  public float getYPos() {
    return center_y;
  }
  
}
public class Goose extends Sprite
{
  private float x;
  private float speed; 
  private boolean random;
  
  public Goose (float x, float speed)
  {
     super("goose.jpg", 0.3f);
     this.x = x;
     this.speed = speed; 
     this.random = false;
  }
  
  public Goose (float maxSpeed) {
    super("goose.jpg", 0.3f);
    this.speed = random(1, maxSpeed);
    this.x = random(0, width);
    this.random = true;
  }
  
  public void display()
  {
    image(image, x, center_y, w, h);
    if (center_y >= height) {
      center_y = 0;
    }
  }
  
   public void update()
    {
        center_y += speed + change_y;
        if (center_y >= height) {
            reset();
        } 
    }

    public void reset() {
        center_y = 0;
        if (random) {
            x = random(0, width);
            speed = random(1, speed);
        }
    }

   public float getSpeed() {
    return speed;
  }

  public void setSpeed(int s) {
    speed = s;
  }

  public float getXPos() {
    return x;
  }

  public float getYPos() {
    return center_y;
  }
  
}
public class Level {
    private int num;
    private float fallSpeed;
    private int nSprites;
    private int scoreNeeded;

    public Level (int num, float fallSpeed, int nSprites, int scoreNeeded) {
        this.num = num;
        this.fallSpeed = fallSpeed;
        this.nSprites = nSprites;
        this.scoreNeeded = scoreNeeded;
    }

    public void display() {
        text("Level " + num, 0, 0);
    }
}
public class Pigeon extends Sprite {
    private float x;
    private float speed;
    private boolean alive;
    int score;
    
    public Pigeon(float x, float speed)
    {
        super("pigeon.png", 0.2f);
        this.x = x;
        this.speed = speed; 
        this.alive = true;
        this.score = 0;
    }
    
    public void display()
    {
        image(image, x, height - 130, w, h);
    }
    
    public void moveLeft()
    {
        x -= speed + change_x;
        
        // collision with wall
        if (x <= 0) {
            x = 0;
        }
    }
    
    public void moveRight()
    {
        x += speed + change_x;
        
        // collision with wall
        if (x >= width) {
            x = width;
        }
    }
    
    public void incrementScore() {
        score++;
    }
    
    public int getScore() {
        return score;
    }
    
    public void setScore(int s) {
        score = s;
    }
    
    public boolean getAlive() {
        return alive;
    }
    
    public void setAlive(boolean a) {
        alive = a;
    }
    
    public boolean isTouchingDuck(Duck d) {
        float xPos = (x + super.getWidth() / 2);
        float yPos = height - 100; 
        float duckXPos = d.getXPos();
        float duckYPos = d.getYPos() + d.getHeight() / 2;
        float xBuffer = super.getWidth() / 2 + d.getWidth() / 2;
        
        if (Math.abs(xPos - duckXPos) < xBuffer) {
            if (Math.abs(yPos - duckYPos) < 10) {
                return true;
            }
        }
        return false;
        
        // loadPixels(d);
        // color c = pixels[yPos * width + xPos];
        // color c = get(xPos, yPos);
    }
    
    public boolean isTouchingGoose(Goose g) {
        float xPos = (x + super.getWidth() / 2);
        float yPos = height - 100; 
        float gooseXPos = g.getXPos();
        float gooseYPos = g.getYPos() + g.getHeight() / 2;
        float xBuffer = super.getWidth() / 2 + g.getWidth() / 2;
        
        if (Math.abs(xPos - gooseXPos) < xBuffer) {
            if (Math.abs(yPos - gooseYPos) < 10) {
                return true;
            }
        }
        return false;
    }
}
public class Sprite {
  PImage image;
  float center_x, center_y;
  float change_x, change_y;
  float w, h; 
  
  public Sprite(String filename, float scale, float x, float y){
    // inititalize variables in this constructor.
    // initialize image by calling loadImage(filename)
    image = loadImage(filename);
    center_x = x;
    center_y = y;
    change_x = 1;
    change_y = 1;
    w = image.width * scale;
    h = image.height *scale;
  }
  // write constructor with filename and scale parameters only.
  public Sprite(String filename, float scale){

    image = loadImage(filename);
    center_x = 10;
    center_y = 10;
    change_x = 1;
    change_y = 1;
    w = image.width * scale;
    h = image.height *scale;
  
  }
  
  public void display(){
    // use image(image_file, x, y, width_image, height_image) to draw image.
    image(image, center_x, center_y, w, h);
    
  }
  public void update(){
    // update position by adding velocity in each direction

      center_y += 2 + change_y;
      
  }

  public float getWidth() {
    return w;
  }

  public float getHeight() {
    return h;
  }

  public float getXPos() {
    return center_x;
  }
  
  public float getYPos() {
    return center_y;
  }
}


  public void settings() { size(1400, 750); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DuckDuckGoose" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
