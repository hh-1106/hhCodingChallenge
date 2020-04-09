class Cell {
  boolean alive;
  boolean lastAlive;
  int x;
  int y;

  Cell(int _x, int _y, boolean _alive) {
    alive = _alive;
    lastAlive = _alive;
    x = _x;
    y = _y;
  }

  void draw() {
    rect(x * CELL_SIZE, y * CELL_SIZE, CELL_SIZE, CELL_SIZE);
  }
}
