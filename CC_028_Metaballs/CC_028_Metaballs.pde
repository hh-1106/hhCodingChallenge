/*
  Code after going through Daniel Shiffman's tutorials.
  Author: hh
*/


Blob[] blobs = new Blob[25];
PImage back;

void setup() {
  size(800, 450);

  colorMode(HSB, 360, 100, 100, 100);
  back = loadImage("back.png");

  for (int i = 0; i < blobs.length; i++) {
    blobs[i] = new Blob(random(width), random(100, height*.4));
  }
}

void draw() {
  background(back);
  println(frameRate);

  loadPixels();
  boolean[] ke = new boolean[999999];
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int index = x + y * width;
      ke[index] = false;
      float sum = 0;
      float d = 100;
      for (Blob b : blobs) {
        d = dist(x, y, b.pos.x, b.pos.y);
        if ( d<random(110, 140) ||
          ( d>random(0, 30) && d<random(40, 100) )) {
          ke[index] = true;
        }
        sum += 21 * b.r / d;
      }
      if (ke[index])
        pixels[index] = color(constrain(sum, 75, 230), random(60, 100), 100, random(3, 9));
    }
  }

  updatePixels();

  tint(255, 20);
  image(back, 0, 0);

  for (Blob b : blobs) {
    b.update();
    //b.show();
  }
}
