/* autogenerated by Processing revision 1292 on 2023-05-26 */
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
int numSprites, level;
PFont title, sub;
PImage startscreen;
boolean started, levelStarted, isDuckStarted = false;
Level gameLevel;
PowerUps powerUpManager;

// initialize them in setup().

public void setup() {
    // for (int z = 0; z < PFont.list().length; z++) {
    //     System.out.println(PFont.list()[z]);
    // }
    /* size commented out by preprocessor */; // reserved variables width = 800, height = 600

    player = new Pigeon(width / 2.0f, 8.0f);

    // can be changed depending on how many ducks/geese we want
    numSprites = 5;

    level = 1;

    ducks = new Duck[numSprites];
    geese = new Goose[numSprites];

    for (int i = 0; i < numSprites; i++) {
        ducks[i] = new Duck(3);
        geese[i] = new Goose(2);
    }

    gameLevel = new Level(level, 1.0f, numSprites);
    powerUpManager = new PowerUps();
    startscreen = loadImage("farmScreen.jpg");
    image(startscreen, 0,0, width, height);
    initScreen();

} 

// modify and update them in draw().
public void draw() {
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
        if (!powerUpManager.isPowerActive(PowerUpType.FREEZE_GEESE)) {
          geese[i].update();
        }

        if (player.isTouching(ducks[i])) {
            ducks[i].reset();
            player.addToStack(ducks[i]);
            player.incrementScore();
        }

        if (player.isTouching(geese[i])) {
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

    gameLevel = new Level(level, 1 + 0.5f * (level - 1), numSprites);
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
public void keyPressed() {
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

public void initScreen() {
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
- add game over screen!!!

- nested for loop
*/
public class Duck extends FallingSprite
{

  public Duck (float x, float speed)
  {
    super("duck.png", 0.07f, x, speed);
  }
  
  public Duck (float maxSpeed) {
    super("duck.png", 0.07f, maxSpeed);
  }
  
}
public class FallingSprite extends Sprite {
    private float x;
    private float speed; 
    private float maxSpeed;
    private boolean random;
    
    public FallingSprite (String filename, float scale, float x, float speed)
    {
        super(filename, scale);
        this.x = x;
        this.speed = speed;
        this.maxSpeed = speed;
        this.random = false;
    }
    
    public FallingSprite (String filename, float scale, float maxSpeed) {
        super(filename, scale);
        this.maxSpeed = maxSpeed;
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
        if (center_y >= height - 150) {
            reset();
        } 
    }

    public void reset() {
        center_y = 0;
        if (random) {
            x = random(0, width);
            speed = random(1, maxSpeed);
        }
    }

    // TEST THIS FUNCTION
    public void hide() {
        tint(255, 0);
    }

    public float getSpeed() {
        return speed;
    }

    public void setSpeed(float s) {
        speed = s;
    }

    public float getMaxSpeed() {
        return maxSpeed;
    }

    public void setMaxSpeed(float s) {
        maxSpeed = s;
    }

    public float getXPos() {
        return x;
    }

    public float getYPos() {
        return center_y;
    }
}
public class Goose extends FallingSprite
{
  
  public Goose (float x, float speed)
  {
     super("goose.png", 0.07f, x, speed);
  }
  
  public Goose (float maxSpeed) {
    super("goose.png", 0.07f, maxSpeed);
  }
  
}
public class Level {
    private int num;
    private float fallSpeedMultiplier;
    private int nSprites;

    public Level (int num, float fallSpeedMultiplier, int nSprites) {
        this.num = num;
        this.fallSpeedMultiplier = fallSpeedMultiplier;
        this.nSprites = nSprites;
    }

    public void display() {
        PFont lvlText = createFont("Times New Roman", 48, true);
        textFont(lvlText);
        textAlign(CENTER);
        if (level > 5) {
            fill(255);
        }
        else {
            fill(0);
        }
        text ("Level " + num, 100, 50);
    }

    public void displayScore(int s) {
        PFont scoreText = createFont("Times New Roman", 36, true);
        textFont(sub);
        text ("score: " + s, 100, 75);
    }

    public void initLevel(Pigeon p) {
        noStroke();
        colorMode(RGB, 255, 255, 255);
        fill(198, 255, 138);
        // hardcode for now until I can find a fix
        rect(0, height - 150, width, 250);
        //rect(0, p.getPigeonY() + 100, width, height - p.getPigeonY());
    }

    public float getFallSpeedMultiplier() {
        return fallSpeedMultiplier;
    }
}
public class Pigeon extends Sprite {
    private float x;
    private float y;
    private float speed;
    private boolean alive;
    private int score;
    private ArrayList<PImage> duckStack;

    
    public Pigeon(float x, float speed)
    {
        super("pigeon.png", 0.07f);
        this.x = x;
        this.y = height - 250;
        this.speed = speed; 
        this.alive = true;
        this.score = 0;
        duckStack = new ArrayList<PImage>();
    }
    
    public void display()
    {
        image(image, x, y, w, h);
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
    
    public boolean isAlive() {
        return alive;
    }
    
    public void setAlive(boolean a) {
        alive = a;
    }

    public float getPigeonY() {
        return y;
    }

    public float getSpeed() {
        return speed;
    }

    public void setSpeed(float s) {
        speed = s;
    }

    public void resetSpeed() {
        speed -= (level - 1);
    }

    public boolean isTouching(Sprite s) {
        float xPos = (x + super.getWidth() / 2);
        float yPos = y; 
        float spriteXPos = s.getXPos();
        float spriteYPos = s.getYPos() + s.getHeight() / 2;
        float xBuffer = super.getWidth() / 2 + s.getWidth() / 2;
        
        if (Math.abs(xPos - spriteXPos) < xBuffer) {
            if (Math.abs(yPos - spriteYPos) < 10) {
                return true;
            }
        }
        return false;

        // loadPixels(d);
        // color c = pixels[yPos * width + xPos];
        // color c = get(xPos, yPos);
    }
    
    public void addToStack(Duck d) {
        PImage newDuck = loadImage("duck.png");
        duckStack.add(newDuck);
        y -= d.getHeight();
    }

    public void displayStack(Duck d) {
        if (duckStack.size() == 0) {
            return;
        }
        for (int i = 0; i < duckStack.size(); i++) {
            // AAAAAAAAAAAAAAAAAAA
            image(duckStack.get(i), x + super.getWidth() / 4, y + (d.getHeight() * (i + 1)) + super.getHeight() / 2, d.getWidth(), d.getHeight());
        }
    }

    public void resetStack() {
        y = height - 250;
        duckStack.clear();
    }
}
enum PowerUpType {
    RAINING_DUCKS,
    FREEZE_GEESE,
    INVINCIBILITY,
    NONE;

    public static PowerUpType getRandomPower() {
        PowerUpType[] vals = PowerUpType.values();
        int randIndex = (int) (Math.random() * vals.length);
        return vals[randIndex];
    }
}
public class PowerUps {
    private ArrayList<PowerUpType> activePowerUps;
    private ArrayList<Duck> extraSprites;

    public PowerUps() {
        activePowerUps = new ArrayList<PowerUpType>();
        extraSprites = new ArrayList<Duck>();
    }

    public String getPowerUpName(PowerUpType t) {
        switch (t) {
            case RAINING_DUCKS:
                return "It's raining ducks!";
            case FREEZE_GEESE:
                return "Geese are frozen!";
            case INVINCIBILITY:
                return "Geese do no damage!";
            default:
                return "No power ups active!";
        }
    }

    public boolean isPowerActive(PowerUpType p) {
        for (PowerUpType s : activePowerUps) {
            if (p.equals(s)) {
                return true;
            }
        }
        return false;
    }

    public void addPowerUp(PowerUpType p) {
        activePowerUps.add(p);
    }

    public void removePowerUp(PowerUpType p) {
        activePowerUps.remove(p);
    }

    public ArrayList<PowerUpType> getActivePowerUps() {
        return activePowerUps;
    }

    public void resetPowerUps() {
        activePowerUps.clear();
    }

    public int calculateDuckNum(int lvl) {
        if (lvl == 1) {
            return 1;
        }
        else {
            return lvl + calculateDuckNum(lvl - 1);
        }
    }

    public boolean rainDucks(float currentMaxSpeed) {
        if (!(isPowerActive(PowerUpType.RAINING_DUCKS))) {
            return false;
        }

        int duckNum = calculateDuckNum(level);
        for (int i = 0; i < duckNum; i++) {
            extraSprites.add(new Duck(currentMaxSpeed));
        }

        return true;
    }

    public void displayExtraSprites() {
        for (int i = 0; i < extraSprites.size(); i++) {
            extraSprites.get(i).display();
            extraSprites.get(i).update();
            if (player.isTouching(extraSprites.get(i))) {
                extraSprites.get(i).reset();
                player.addToStack(extraSprites.get(i));
                player.incrementScore();
            }
        }
    }

    public void endDuck(Pigeon p, int duckLvl) {
        if (isPowerActive(PowerUpType.RAINING_DUCKS)) {
            int duckNum = calculateDuckNum(duckLvl);

            if ((p.getScore() - 8 * (duckLvl - 1)) >= duckNum) {
                resetDuckRain();
            }
        }
    }

    public void resetDuckRain() {
        if (isPowerActive(PowerUpType.RAINING_DUCKS)) {
            extraSprites.clear();
            removePowerUp(PowerUpType.RAINING_DUCKS);
        }
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
