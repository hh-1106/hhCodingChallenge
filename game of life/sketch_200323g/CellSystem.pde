class CellSystem {
  Cell[][] cells;
  float cellSize = 5;
  int COLS = 100;
  int ROWS = 50;

  CellSystem() {
    COLS = (int)(height / cellSize);
    ROWS = (int)(width / cellSize);
    init();
  }


  void init() {
    cells = new Cell[COLS][ROWS];
    for (int i = 0; i < COLS; i ++) {
      for (int j = 0; j < ROWS; j ++) {
        cells[i][j] = new Cell(j * cellSize, i * cellSize);
      }
    }

    for (int i = 0; i < COLS; i ++) {
      for (int j = 0; j < ROWS; j ++) {
        int below = i - 1;
        int above = i + 1;
        int left = j - 1;
        int right = j + 1;
        if (below < 0) {
          below += COLS;
        }
        if (above >= COLS) {
          above -= COLS;
        }
        if (left < 0) {
          left += ROWS;
        }
        if (right >= ROWS) {
          right -= ROWS;
        }

        cells[i][j].addNeighbours(cells[below][left]);
        cells[i][j].addNeighbours(cells[below][j]);
        cells[i][j].addNeighbours(cells[below][right]);
        cells[i][j].addNeighbours(cells[i][left]);
        cells[i][j].addNeighbours(cells[i][right]);
        cells[i][j].addNeighbours(cells[above][left]);
        cells[i][j].addNeighbours(cells[above][j]);
        cells[i][j].addNeighbours(cells[above][right]);
      }
    }
  }

  void show() {
    for (int i = 0; i < COLS; i ++) {
      for (int j = 0; j < ROWS; j ++) {
        cells[i][j].display();
      }
    }
  }

  void update() {
    for (int i = 0; i < COLS; i ++) {
      for (int j = 0; j < ROWS; j ++) {
        cells[i][j].update();
      }
    }
  }


  void randomReborn() {
    for (int t = 0; t < 20; t ++) {
      int i = (int)random(COLS);
      int j = (int)random(ROWS);

      cells[i][j].state = cells[i][j].nextState = !cells[i][j].state;
    }
  }


  
}
