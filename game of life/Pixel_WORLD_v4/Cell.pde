class Cell {
  float x, y;

  int state;
  int pre;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
  }

  void show(int w) {
    noStroke();

    int a = 255;


    if (pre==0 && state==1)
      a = 151;
    else if (state == 1)
      a = 255;
    else if (pre==1 && state==0)
      a = 51;
    else
      a = 10;

    color c = color(src[int(y*width + x)], a);

    stroke(c);
    strokeWeight(w);
    pushMatrix();
    translate(-w*0.5, -w*0.5);
    translate(x, y);
    point(0, 0);

    popMatrix();
    //result.set(int(x), int(y), c);

    //result.set(int(x), int(y), 20);
  }
}
