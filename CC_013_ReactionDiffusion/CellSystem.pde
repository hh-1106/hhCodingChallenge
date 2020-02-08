class CellSystem {
  Cell[][] grid, prev;
  float dA = 1.0;
  float dB = 0.5;
  float feed = 0.055;
  float k = 0.062;
  int feedSize = 1;

  CellSystem() {
    initCell();
    //feed(250, 250);
  }

  void swap() {
    //println(prev, grid);
    Cell[][] temp = prev;
    prev = grid;
    grid = temp;
    //println(prev, grid);
    //noLoop();
  }

  void update() {

    for (int i = 1; i < width-1; i++) {
      for (int j = 1; j < height-1; j ++) {
        Cell spot = prev[i][j];
        Cell newspot = grid[i][j];
        float a = spot.a;
        float b = spot.b;

        float laplaceA = 0;
        laplaceA += a*-1;
        laplaceA += prev[i+1][j].a*0.2;
        laplaceA += prev[i-1][j].a*0.2;
        laplaceA += prev[i][j+1].a*0.2;
        laplaceA += prev[i][j-1].a*0.2;
        laplaceA += prev[i-1][j-1].a*0.05;
        laplaceA += prev[i+1][j-1].a*0.05;
        laplaceA += prev[i-1][j+1].a*0.05;
        laplaceA += prev[i+1][j+1].a*0.05;

        float laplaceB = 0;
        laplaceB += b*-1;
        laplaceB += prev[i+1][j].b*0.2;
        laplaceB += prev[i-1][j].b*0.2;
        laplaceB += prev[i][j+1].b*0.2;
        laplaceB += prev[i][j-1].b*0.2;
        laplaceB += prev[i-1][j-1].b*0.05;
        laplaceB += prev[i+1][j-1].b*0.05;
        laplaceB += prev[i-1][j+1].b*0.05;
        laplaceB += prev[i+1][j+1].b*0.05;

        newspot.a = a + (dA*laplaceA - a*b*b + feed*(1-a))*1;
        newspot.b = b + (dB*laplaceB + a*b*b - (k+feed)*b)*1;
        newspot.a = constrain(newspot.a, 0, 1);
        newspot.b = constrain(newspot.b, 0, 1);
      }
    }
  }


  void show() {
    loadPixels();
    for (int i = 1; i < width-1; i++) {
      for (int j = 1; j < height-1; j ++) {
        Cell spot = grid[i][j];
        float a = spot.a;
        float b = spot.b;
        int pos = i + j * width;
        pixels[pos] = color((a-b)*255);
        //pixels[pos] = color(((a-b)*255 + 222 )%255, 255, 255);
      }
    }
    updatePixels();
  }

  void feed(float x_, float y_) {
    int x = (int)constrain(x_, feedSize, width-feedSize);
    int y = (int)constrain(y_, feedSize, height-feedSize);
    for (int i = x-feedSize; i < x+feedSize; i++) {
      for (int j = y-feedSize; j < y+feedSize; j ++) {
        prev[i][j].b++;
      }
    }
  }


  void initCell() {
    grid = new Cell[width][height];
    prev = new Cell[width][height];
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j ++) {
        prev[i][j] = new Cell(1, 0);
        grid[i][j] = new Cell(1, 0);
      }
    }
  }
}
