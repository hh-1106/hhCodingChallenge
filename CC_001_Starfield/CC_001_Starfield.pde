/*
  Code after going through Daniel Shiffman's tutorials.
  Author: hh
*/


PImage back;
Star[] stars = new Star[100];
float speed;

void setup() {
  size(800, 450);
  back = loadImage("back.png");
  //stroke(255);

  colorMode(HSB, 360, 100, 100);
  for (int i=0; i<stars.length; i++) {
    stars[i] = new Star();
  }
}

void draw() {
  speed = map(mouseX, 0, width, 50, 0);

  background(0);
  tint(255, 150);
  image(back, 0, 0);
  translate(width/2, height/2);

  for (int i=0; i<stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
}
