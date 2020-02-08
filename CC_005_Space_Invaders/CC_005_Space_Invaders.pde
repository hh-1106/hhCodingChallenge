/*
  Code after going through Daniel Shiffman's tutorials.
  Author: hh
*/


Ship ship;
Flower[] flowers = new Flower[6];
ArrayList<Drop> drops = new ArrayList<Drop>();

void setup() {
  size(600, 400);
  rectMode(CENTER);
  ship = new Ship();
  // drop = new Drop(width/2, height/2);
  for (int i = 0; i < flowers.length; i++) {
    flowers[i] = new Flower(i*80+80, 60);
  }
}

void draw() {
  background(51);

  if (frameCount%10 ==0) {
    Drop drop = new Drop(ship.x, ship.y);
    drops.add(drop);
  }


  for (Drop d : drops) {
    d.show();
    d.move();
    for (int j = 0; j < flowers.length; j++) {
      if (d.hits(flowers[j])) {
        flowers[j].grow();
        d.evaporate();
      }
    }
  }

  ship.show();
  ship.move();


  boolean edge = false;

  for (int i = 0; i < flowers.length; i++) {
    flowers[i].show();
    flowers[i].move();
    if (flowers[i].x > width || flowers[i].x < 0) {
      edge = true;
    }
  }

  if (edge) {
    for (int i = 0; i < flowers.length; i++) {
      flowers[i].shiftDown();
    }
  }

  for (int i = drops.size()-1; i >= 0; i--) {
    Drop d = drops.get(i);
    if (d.toDelete) {
      drops.remove(i);
    }
  }
}


void keyReleased() {
  if (key != ' ') {
    ship.setDir(0, 0);
  }
}

void mouseMoved() {
  ship.x = mouseX;
  ship.y = mouseY;

}

void keyPressed() {

  for (Drop d : drops) {
    d.r = 520;
  }

  if (key == ' ') {
    Drop drop = new Drop(ship.x, ship.y);
    drops.add(drop);
  }

  if (keyCode == RIGHT) {
    ship.setDir(1, 0);
  } else if (keyCode == LEFT) {
    ship.setDir(-1, 0);
  }
  if (keyCode == UP) {
    ship.setDir(0, -1);
  } else if (keyCode == DOWN) {
    ship.setDir(0, 1);
  }
}
