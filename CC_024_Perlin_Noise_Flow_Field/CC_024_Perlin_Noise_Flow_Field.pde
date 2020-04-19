/*
  Code after going through Daniel Shiffman's tutorials.
 Author: hh
 */


FlowField wind;
ArrayList<Firefly> fireflies;
PImage back;


int fScl = 5;
int pNum = 50;
int maxNum = 3000;
int mSensity = 20;

void settings() {
  size(800, 450);
  smooth();
}


void setup() {

  noCursor();
  back = loadImage("back.png");
  wind = new FlowField(fScl);
  wind.update();

  fireflies = new ArrayList<Firefly>();
  //for (int i = 0; i < pNum; i++) {
  //  PVector born = new PVector(random(width), random(height));
  //  fireflies.add(new Firefly(born, random(1)));
  //}
}

void draw() {

  if (pNum > 0 && frameCount%10==0) {
    PVector born = new PVector(random(width), random(height));
    fireflies.add(new Firefly(born, random(1)));

    pNum--;
  }

  //background(255);
  tint(255, 30);
  image(back, 0, 0);

  wind.update();
  //wind.display();

  for (Firefly f : fireflies) {
    f.follow(wind);
    f.update();
    f.edges();
    f.show();
  }

  if (fireflies.size()>=maxNum) {
    fireflies.remove(0);
  }
}

void mouseMoved() {
  PVector born = new PVector(mouseX, mouseY);
  fireflies.add(new Firefly(born, random(1)));
}

void keyPressed() {
  if (key == ' ')
    wind.zoff += 0.1;
}

void mousePressed(){
  mSensity *= 5;
}

void mouseReleased(){
  mSensity /= 5;
}
