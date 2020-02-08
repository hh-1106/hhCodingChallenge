/*
  Code after going through Daniel Shiffman's tutorials.
  Author: hh
*/


FlowField wind;
ArrayList<Firefly> fireflies;
PImage back;


int fScl = 20;
int pNum = 1000;
int mSensity = 10;

void setup() {
  //size(1200, 720);
  size(800, 450);
  noCursor();
  back = loadImage("back.png");
  wind = new FlowField(fScl);
  wind.update();

  fireflies = new ArrayList<Firefly>();
  for (int i = 0; i < pNum; i++) {
    PVector born = new PVector(random(width), random(height));
    fireflies.add(new Firefly(born, random(1)));
  }
}

void draw() {
  //background(255);
  tint(255,20);
  image(back,0,0);

  wind.update();
  //wind.display();

  for (Firefly f : fireflies) {
    f.follow(wind);
    f.update();
    f.edges();
    f.show();
  }
}

void mouseMoved() {
  PVector born = new PVector(mouseX, mouseY);
  fireflies.add(new Firefly(born, random(1)));
}

void keyPressed() {
  wind.zoff += 0.1;
}
