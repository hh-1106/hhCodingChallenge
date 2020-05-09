class Lumos {
  PVector pos, vel;
  PVector loc;

  float r;
  float phase;
  boolean keep;

  Lumos() {
    init();
    loc = pos.copy();
  }

  Lumos(float x, float y) {
    init();
    loc = new PVector(x, y);
  }

  private void init() {
    pos = new PVector(random(r, width - r), random(r, height - r));
    r = random(10, 20);
    keep = false;
    phase = random(TWO_PI);
    vel = PVector.random2D();
    vel.mult(random(1, 5));
  }

  void update() {
    goBack();
    //pos.add(vel);
    //edges();
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

  public void moveTo() {
    float d = pos.dist(deluminator);
    if (d < 0.1) return;

    keep = true;
    pos.lerp(deluminator, 0.02);
  }

  public void goBack() {
    if (keep)  return;
    float d = pos.dist(loc);
    if (d < 0.1) return;
    
    pos.lerp(loc, 0.1);
  }

  public void show() {
    pushStyle();
    noFill();
    strokeWeight(1);
    stroke(0, 255, 255);
    ellipse(pos.x, height-pos.y, r*2, r*2);
    popStyle();
  }
}
