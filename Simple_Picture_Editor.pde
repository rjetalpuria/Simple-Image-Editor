//Rushi Jetalpuria
//Image Filter project

//*************Declaration of Variables**************
boolean PicLoaded = false;
int picWidth = 0;
int picHeight = 0;
PImage img;
PImage img1;
boolean Hue1 = false;
boolean Hue2 = false;
boolean Hue3 = false;
boolean sort1 = false;
boolean sort2 = false;
int index = 0;

void setup() {
  size(400, 400);
  background(185);
  textAlign(LEFT);
  textSize(16);
  //asks the user to select an image to load
  selectInput("Select a file to process:", "infileSelected");
}

void draw() {
  background(100);
  noStroke();
  rectMode(CENTER);
  int picStart = 0;
  int picEnd = 0;

  noStroke();
  textSize(16);

  //The following loads and displays an image file.
  //The image is resized to best fit in a 400x400 frame.
  if (PicLoaded)
  {     
    picWidth = img.width;
    picHeight = img.height;

    if (picWidth > 400)
    {
      picHeight = (int)(picHeight*(400.0/picWidth));
      picWidth = 400;
    }
    if (picHeight > 400)
    {
      picWidth = (int)(picWidth*(400.0/picHeight));
      picHeight = 400;
    }

    picStart = 0;
    picEnd = picStart+width*picHeight;
    image(img, 0, 0, picWidth, picHeight);
    image(img1, 0, 0, picWidth, picHeight);
    loadPixels();
    img.loadPixels();
    img1.loadPixels();

    /***** Effects Code *****/

    //creates an effect by setting the blue value to red, red value to green
    //green value to blue
    if (Hue1)
    {
      int i = picStart;
      while (i < picEnd) 
      { 
        color c = pixels[i];
        pixels[i] = color(blue(c), red(c), green(c));
        i = i + 1;
        if (i % width >= picWidth)        // This will ignore anything on the line that 
          i = i + width - picWidth;       // after the image (such as buttons)
      }
    }
    //create an effect by setting green value to red, blue value to green
    // and red to blue
    if (Hue2)
    {
      int i = picStart;
      while (i < picEnd) 
      {
        color c = pixels[i];
        pixels[i] = color(green(c), blue(c), red(c));
        i = i + 1;
        if (i % width >= picWidth)        // This will ignore anything on the line that 
          i = i + width - picWidth;       // after the image (such as buttons)
      }
    }
    //creates an effect by switching out the red and blue values
    if (Hue3)
    {

      int i = picStart;
      while (i < picEnd) 
      {
        color c = pixels[i];
        pixels[i] = color(blue(c), green(c), red(c));
        i = i + 1;
        if (i % width >= picWidth)        // This will ignore anything on the line that 
          i = i + width - picWidth;       // after the image (such as buttons)
      }
    }
    //sorts the image by brightness
    if (sort1)
    { 
      // Selection sort!
      for (int n = 0; n < 5; n++) {
        float record = -1;
        int selectedPixel = index;
        for (int j = index; j < img1.pixels.length; j++) {
          color pix = img1.pixels[j];
          float b = brightness(pix);
          if (b > record) {
            selectedPixel = j;
            record = b;
          }
        }

        // Swap selectedPixel with i
        color temp = img1.pixels[index];
        img1.pixels[index] = img1.pixels[selectedPixel];
        img1.pixels[selectedPixel] = temp;

        if (index < img1.pixels.length -1) {
          index++;
        }
      }
      println("sort1");
    }
    //sorts the image by the hue
    if (sort2)
    { 
      // Selection sort!
      for (int n = 0; n < 5; n++) {
        float record = -1;
        int selectedPixel = index;
        for (int j = index; j < img1.pixels.length; j++) {
          color pix = img1.pixels[j];
          float b = hue(pix);
          if (b > record) {
            selectedPixel = j;
            record = b;
          }
        }

        // Swap selectedPixel with i
        color temp = img1.pixels[index];
        img1.pixels[index] = img1.pixels[selectedPixel];
        img1.pixels[selectedPixel] = temp;

        if (index < img1.pixels.length -1) {
          index++;
        }
      }
      println("sort2");
    } 

    updatePixels();
    img.updatePixels();
    img1.updatePixels();

    redraw();
  }
  //draws all the buttons for the effect
  //with a green rounded rectangle when ON.
  if (Hue1) {
    fill(#3fff00);
    rect(28, 375, 50, 20, 10);
    fill(0);
    text("Hue1", 10, 380);
  } else {
    fill(180);
    text("Hue1", 10, 380);
  }

  if (Hue2) {
    fill(#3fff00);    
    rect(85, 375, 50, 20, 10);
    fill(0);
    text("Hue2", 65, 380);
  } else {
    fill(180);
    text("Hue2", 65, 380);
  }
  if (Hue3) {
    fill(#3fff00);   
    rect(140, 375, 50, 20, 10);
    fill(0);
    text("Hue3", 120, 380);
  } else {
    fill(180);
    text("Hue3", 120, 380);
  }

  if (sort1) {
    fill(#3fff00);    
    rect(220, 367, 80, 45, 10);
    fill(0);
    text("Brightness", 180, 360);
    text("Sort", 180, 380);
  } else {
    fill(180);
    text("Brightness", 180, 360);
    text("Sort", 180, 380);
  }
  if (sort2) {
    fill(#3fff00);    
    rect(300, 367, 50, 45, 10);
    fill(0);
    text("Hue", 280, 360);
    text("Sort", 280, 380);
  } else {
    fill(180);
    text("Hue", 280, 360);
    text("Sort", 280, 380);
  }

  fill(255);
  noStroke();
}

void keyPressed() {
  if (key == '1') {
    Hue1 = !Hue1;
  }
  if (key == '2') {
    Hue2 = !Hue2;
  }
  if (key == '3') {
    Hue3 = !Hue3;
  }
  if (key == '4') {
    sort1 = !sort1;
  }
  if (key == '5') {
    sort2 = !sort2;
  }
}

//function that loads an image
void infileSelected(File selection) 
{
  if (selection == null) 
  {
    println("IMAGE NOT LOADED: Window was closed or the user hit cancel.");
  } else 
  {
    println("IMAGE LOADED: User selected " + selection.getAbsolutePath());
    img = loadImage(selection.getAbsolutePath());
    img1 = createImage(img.width, img.height, RGB);
    img1= img.get();
    PicLoaded = true;
    Hue1 = false;
    Hue2 = false;
    Hue3 = false;
    sort1 = false;
    sort2 = false;
    redraw();
  }
}
