/*
  Code after going through Daniel Shiffman's tutorials.
  Author: hh
*/


Drop[] drops = new Drop[800];
PImage back;

void setup() {
  size(800, 600);
  back = loadImage("back.png");
  for (int i = 0; i < drops.length; i++) {
    drops[i] = new Drop();
  }
}

void draw() {
  image(back,0,0);

  int de = floor(map(mouseY, 0, height, 100, 0));
  delay(de);
  //background(161, 237, 214);
  for (int i = 0; i < drops.length; i++) {
    drops[i].fall();
    drops[i].show();
  }
}
