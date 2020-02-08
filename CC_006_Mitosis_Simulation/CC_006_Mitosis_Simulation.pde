/*
  Code after going through Daniel Shiffman's tutorials.
  Author: hh
*/


ArrayList<Cell> cells = new ArrayList<Cell>();

void setup() {
  size(600, 400);
  for (int i=0; i<10; i++)
    cells.add(new Cell());
}

void draw() {
  background(185, 218, 197);
  for (Cell c : cells) {
    c.move();
    c.show();
  }
}

void mouseMoved() {
  for (int i = cells.size()-1; i >= 0; i--) {
    Cell c = cells.get(i);
    if (c.r > 2) {
      if (c.clicked(mouseX, mouseY)) {
        cells.add(c.mitosis());
        cells.add(c.mitosis());
        cells.remove(i);
      }
    }
  }
}

void keyPressed() {
  cells.add(new Cell());
}
