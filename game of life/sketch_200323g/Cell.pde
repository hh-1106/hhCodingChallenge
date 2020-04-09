class Cell {
  PVector pos;
  float x, y;
  boolean state;
  boolean nextState;
  float cellSize = 5;
  Cell[] neighbours;

  int trueNeighbours;
  int age;

  Cell(float x_, float y_) {
    x = x_;
    y = y_;
    state = random(2) > 1;
    nextState = random(2) > 1;
    neighbours = new Cell[0];

    trueNeighbours = 0;
    age = 0;
  }

  void addNeighbours(Cell c) {
    neighbours = (Cell[])append(neighbours, c);
  }

  void calcNextState() {
    trueNeighbours = 0;
    for (int i = 0; i < neighbours.length; i ++) {
      if (neighbours[i].state) {
        trueNeighbours ++;
      }
    }
    if (state) {
      if (trueNeighbours == 2 || trueNeighbours == 3) {
        nextState = true;
      } else {
        nextState = false;
      }
    } else {
      if (trueNeighbours == 3) {
        nextState = true;
      } else {
        nextState = false;
      }
    }
  }

  void display(float r) {
    //float u = map(x, 0, w, 0, TWO_PI);
    //float v = map(y, 0, h, -HALF_PI, HALF_PI);

    float u = (360/w) * x -180;
    float v = (180/h) * y -90;

    pos = uv2xyz(u, v, r);

    int h = min(age, 500);
    PVector xaxis = new PVector(1, 0, 0);
    float angleb = PVector.angleBetween(xaxis, pos);
    PVector raxis = xaxis.cross(pos);

    fill(255, min(age, 250));
    pushMatrix();

    translate(width*0.5, height*0.5);
    translate(pos.x, pos.y, pos.z);
    rotate(angleb, raxis.x, raxis.y, raxis.z);
    pushStyle();
    emissive(46, random(50,100),96);
    box(h, 2, 2);
    popStyle();

    //stroke(255,0,0);
    //point(0,0,0);
    popMatrix();
  }

  private PVector uv2xyz(float u, float v, float r) {
    float lat = (u + 90) * PI / 180;
    float lon = v * PI / 180;
    float x = -r * cos(lon) * cos(lat);
    float y = -r * sin(lon);
    float z = r * cos(lon) * sin(lat);
    return new PVector(x, y, z);
  }

  void update() {
    calcNextState();

    state = nextState;
    if (state) {
      age ++;
    } else {
      age = 0;
    }
    if (age > 800) {
      //randomReborn();
      age = 0;
    }
  }

  void display() {


    if (age > 0) {
      display(r);
      fill(360, min(age, 360));
      noStroke();
      int h = min(age, 800);
      pushMatrix();
      translate(x+cellSize/2, y+cellSize/2, h/2+1);
      pushStyle();
      emissive(0);
      box(cellSize, cellSize, h*3);
      popStyle();
      popMatrix();
    } else {
      fill(15, 20);
      rect(x, y, cellSize, cellSize);
    }
  }
}
