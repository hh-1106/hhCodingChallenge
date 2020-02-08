class Snake {
  float x = 0;
  float y = 0;
  float xspeed = 1;
  float yspeed = 0;
  int total = 0;
  ArrayList<PVector> tail = new ArrayList<PVector>();

  Snake() {
  }

  void update() {
    if (total > 0) {
      if (total == tail.size() && !tail.isEmpty()) {
        tail.remove(0);
      }
      tail.add(new PVector(x, y));
    }

    x = (x<=food.x)
      ?lerp(ceil(x/scl), food.x/scl, 0.005)*scl
      :lerp(floor(x/scl), food.x/scl, 0.005)*scl;
    if (dist(x, 0, food.x, 0) == 0) {
      y = (y<=food.y)
      ?lerp(ceil(y/scl), food.y/scl, 0.005)*scl
      :lerp(floor(y/scl), food.y/scl, 0.005)*scl;
    }

    //x = x + xspeed*scl;
    //y = y + yspeed*scl;


    x = constrain(x, 0, width-scl);
    y = constrain(y, 0, height-scl);
  }


  boolean eat(PVector pos) {
    float d = dist(x, y, pos.x, pos.y);
    if (d < 1) {
      total++;
      return true;
    } else {
      return false;
    }
  }

  void dir(float x, float y) {
    xspeed = x;
    yspeed = y;
  }

  void death() {
    for (int i = 0; i < tail.size(); i++) {
      PVector pos = tail.get(i);
      float d = dist(x, y, pos.x, pos.y);
      if (d < 1) {
        total = 0;
        tail.clear();
      }
    }
  }



  void show() {
    fill(41, 57, 12, 180);
    for (PVector v : tail) {
      rect(v.x, v.y, scl, scl);
    }
    rect(x, y, scl, scl);
  }
}
