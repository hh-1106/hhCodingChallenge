class GOL {

  int cols, rows;
  int w = 4;
  Cell[][] board;

  GOL() {
    cols = img.width/w;
    rows = img.height/w;
    board = new Cell[cols][rows];

    init();
  }


  void init() {

    for (int x=0; x<cols; x++) {
      for (int y=0; y<rows; y++) {
        board[x][y]=new Cell(x*w, y*w);
        board[x][y].state=int(random(2));
      }
    }
  }

  void generate() {
    for (int x=0; x<cols; x++) {
      for (int y=0; y<rows; y++) {
        board[x][y].pre = board[x][y].state;
      }
    }

    for (int x=1; x<cols-1; x++) {
      for (int y=1; y<rows-1; y++) {

        int neighbors=0;
        for (int i=-1; i<=1; i++) {
          for (int j=-1; j<=1; j++) {
            int c = (x + i + cols) % cols;
            int r = (y + j + rows) % rows;
            neighbors += board[c][r].pre;
          }
        }
        neighbors -= board[x][y].pre;

        if       ((board[x][y].pre==1)&&(neighbors<2))   board[x][y].state=0;
        else if  ((board[x][y].pre==1)&&(neighbors>3))   board[x][y].state=0;
        else if  ((board[x][y].pre==0)&&(neighbors==3))  board[x][y].state=1;
        else                              board[x][y].state = board[x][y].pre;
      }
    }
  }

  void show() {
    for (int x=0; x<cols; x++) {
      for (int y=0; y<rows; y++) {
        board[x][y].show(w);
      }
    }
  }

  ArrayList<PVector> getPath() {
    ArrayList<PVector> points = new ArrayList<PVector>();
    for (int x=0; x<cols; x++) {
      for (int y=0; y<rows; y++) {
        if (board[x][y].state == 1)
          points.add(new PVector(x*w, y*w));
      }
    }
    return points;
  }
}
