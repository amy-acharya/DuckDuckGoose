/* autogenerated by Processing revision 1292 on 2023-05-12 */
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


//declare global variables
Sprite duck, goose, ducky, gose;


//initialize them in setup().
public void setup(){
  /* size commented out by preprocessor */; // reserved variables width = 800, height = 600
  imageMode(CENTER);
  // create player sprite with small scale(e.g. 0.5).
  duck = new Sprite ("/Users/miaandreu/Desktop/SpriteLab_Challenging/data/duck.png", 0.3f, 100, 100);
  
  // create crate sprite with larger scale(e.g 2.0).
  goose = new Sprite ("/Users/miaandreu/Desktop/SpriteLab_Challenging/data/goose.png", 0.3f, 450, 50);
  // Use reserved variables width, height to position this sprite.
  
  ducky = new Duck(600, 3);
  gose = new Goose(200, 2);

}

// modify and update them in draw().
public void draw(){
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

public class Duck extends Sprite
{
  private float x;
  private int speed; 
  
  public Duck (float x, int speed)
  {
     super("/Users/miaandreu/Desktop/SpriteLab_Challenging/data/duck.png", 0.3f);
     this.x = x;
     this.speed = speed; 
  }
  
  public void display()
  {
    image(image, x, center_y, w, h);
  }
  
   public void update()
   {
     center_y += speed + change_y;
   }
  
}
public class Goose extends Sprite
{
  private float x;
  private int speed; 
  
  public Goose (float x, int speed)
  {
     super("/Users/miaandreu/Desktop/SpriteLab_Challenging/data/goose.png", 0.3f);
     this.x = x;
     this.speed = speed; 
    
  }
  
  
  public void display()
  {
    image(image, x, center_y, w, h);
  }
  
   public void update()
   {
     center_y += speed + change_y;
   }
  
}
public class Sprite{
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
}


  public void settings() { size(800, 600); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "DuckDuckGoose" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
