/*
  Code after going through Daniel Shiffman's tutorials.
  Author: hh
*/


Snake s;
float scl = 15;
PVector food;
PImage back;

void setup() {
  size(800, 600, P2D);
  frameRate(100);
  back = loadImage("back.png");

  s = new Snake();
  picklocation();
}

void draw() {
  background(205, 156, 116);
  tint(255,225);
  image(back,0,0);
  //s.death();
  s.update();
  s.show();


  if (s.eat(food)) {
    picklocation();
  }

  fill(246, 221, 209, 100);
  rect(food.x, food.y, scl, scl);
}

void picklocation() {
  int cols = floor(width/scl);
  int rows = floor(height/scl);

  food = new PVector(floor(random(cols)), floor(random(rows)));
  food.mult(scl);
}

void mousePressed() {
  s.total++;
}


void keyPressed() {
  if (keyCode == UP) {
    s.dir(0, -1);
  }
  if (keyCode == DOWN) {
    s.dir(0, 1);
  }
  if (keyCode == LEFT) {
    s.dir(-1, 0);
  }
  if (keyCode == RIGHT) {
    s.dir(1, 0);
  }
}
