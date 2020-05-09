class Lumos {
  PVector pos, vel;
  float r;
  float phase;
  Timer timer;

  Lumos() {
    init();
    pos = new PVector(random(r, width - r), random(r, height - r));
  }

  Lumos(float x, float y) {
    init();
    pos = new PVector(x, y);
  }

  private void init() {
    timer = new Timer();
    r = random(10, 20) * 2;
    phase = random(TWO_PI);
    float spd = random(1, 5);
    float dir = random(TWO_PI);
    vel = PVector.fromAngle(dir).mult(spd);
  }

  void update() {
    timer.update();
    pos.add(vel);
    edges();
  }

  void update(float dt) {
    timer.update();
    pos.add(vel.copy().mult(dt));
    edges();
  }

  private void edges() {
    if (pos.x <= r || pos.x >= width - r) {
      vel.x *= -1;
      pos.x += vel.x;
    }
    if (pos.y <= r || pos.y >= height - r) {
      vel.y *= -1;
      pos.y += vel.y;
    }
  }

  boolean isDead() {
    return timer.isDead();
  }

  void show() {
    pushStyle();
    noFill();
    strokeWeight(1);
    stroke(0, 255, 255);
    ellipse(pos.x, pos.y, r*2, r*2);
    popStyle();
  }
}
