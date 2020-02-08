class Circle {
  float x;
  float y;
  float r;
  color c;
  long seed;

  boolean growing = true;
  boolean showing = true;

  Circle(float x_, float y_, color c_) {
    x = x_;
    y = y_;
    c = c_;
    r = 1;
    seed = (long)random(99999);
  }

  void grow() {
    if (growing) {
      r = r + 1;
    }
  }

  boolean edges() {
    return (x + r > width || x -  r < 0 || y + r > height || y -r < 0);
  }

  void show() {
    //stroke(255);
    //strokeWeight(2);
    //noFill();
    if (showing) {
      fill(c);
      randomSeed(seed);
      if (random(1)<0.8) {
        ellipse(x, y, r*2, r*2);
      } else {
        rect(x, y, r*random(1, 2), r*random(1, 2));
      }
    }
  }
}
