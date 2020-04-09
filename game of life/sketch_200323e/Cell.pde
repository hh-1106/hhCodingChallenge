class Cell {
  float x, y;
  int w;
  int state;
  int pre;

  Cell(float _x, float _y) {
    x = _x;
    y = _y;
  }

  void show(int _w) {
    w = _w;
    // noStroke();

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

    fill(c);

    rect(x, y, w, w);
    //result.set(int(x), int(y), c);

    //result.set(int(x), int(y), 20);
  }
}
