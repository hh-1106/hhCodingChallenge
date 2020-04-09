int CELL_SIZE = 4;
int columns;
int rows;


Cell[][] cells;

boolean getNextState(int x, int y, boolean alive) {
  int count = 0;
  boolean xm1 = x > 0;
  boolean xp1 = x+1 < columns;
  boolean ym1 = y > 0;
  boolean yp1 = y+1 < rows;

  if (xm1) {
    if (ym1 && cells[x-1][y-1].lastAlive) {
      count++;
    }
    if (cells[x-1][y].lastAlive) {
      count++;
    }
    if (yp1 && cells[x-1][y+1].lastAlive) {
      count++;
    }
  }
  if (xp1) {
    if (ym1 && cells[x+1][y-1].lastAlive) {
      count++;
    }
    if (cells[x+1][y].lastAlive) {
      count++;
    }
    if (yp1 && cells[x+1][y+1].lastAlive) {
      count++;
    }
  }
  if (ym1 && cells[x][y-1].lastAlive) {
    count++;
  }
  if (yp1 && cells[x][y+1].lastAlive) {
    count++;
  }

  return (alive && (count == 2 || count == 3)) || (!alive && count == 3);
}

void setup() {
  size(1024, 768);
  background(0);

  // initialize grid params
  columns = width / CELL_SIZE;
  rows = height / CELL_SIZE;
  cells = new Cell[columns][rows];

  // seed the grid
  for (int x = 0; x < columns; x++) {
    for (int y = 0; y < rows; y++) {
      boolean alive = Math.random() >= 0.3;
      cells[x][y] = new Cell(x, y, alive);
    }
  }
}

void draw() {
  // render current generation
  for (int x = 0; x < columns; x++) {
    for (int y = 0; y < rows; y++) {
      Cell cell = cells[x][y];

      // save the state
      cell.lastAlive = cell.alive;
    }
  }

  // build next generation
  background(0);
  fill(255);
  for (int x = 0; x < columns; x++) {
    for (int y = 0; y < rows; y++) {
      Cell cell = cells[x][y];
      cell.alive = getNextState(x, y, cell.lastAlive);
      if (cell.alive) cell.draw();
    }
  }
}
