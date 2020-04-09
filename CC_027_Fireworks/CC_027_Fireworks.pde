/*
  Code after going through Daniel Shiffman's tutorials.
 Author: hh
 */


ArrayList<Firework> fireworks;
PImage back, girl;
PVector gravity = new PVector(0, 0.3);

void setup() {
  size(1600, 900, P2D);
  back = loadImage("back.png");
  girl = loadImage("girl.png");
  fireworks = new ArrayList<Firework>();
  colorMode(HSB, 360, 100, 100, 100);
  background(0);
  smooth();
  frameRate(30);
}

void draw() {

  noStroke();
  fill(0, 25);
  rect(0, 0, width, height);


  //println(frameRate);
  //println(fireworks.size());

  if (random(1) < 0.01) {
    fireworks.add(new Firework());
  }

  for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework f = fireworks.get(i);
    f.run();
    if (f.done()) {
      fireworks.remove(i);
    }
  }

  tint(360, 8*fireworks.size());
  image(girl, 276, 371, 160*7, 90*7);
}

void keyPressed() {
  fireworks.add(new Firework());
}

void mousePressed(){
  fireworks.add(new Firework(mouseX));
}
