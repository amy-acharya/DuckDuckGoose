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
}