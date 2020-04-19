public class Firefly {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector prevPos;
  float maxSpeed;
  color col;

  Firefly(PVector born, float mSpeed) {
    maxSpeed = mSpeed;
    pos = born;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    prevPos = pos.copy();
    col = color(168, random(180, 220), 152, 50);
  }

  void update() {
    pos.add(vel);
    vel.limit(maxSpeed);
    vel.add(acc);
    acc.mult(0);
  }

  void applyForce(PVector force) {
    float d = dist(mouseX, mouseY, pos.x, pos.y);
    if (d<mSensity) {
      pos.x = lerp(pos.x, mouseX, 0.1);
      pos.y = lerp(pos.y, mouseY, 0.1);
    } else acc.add(force);
  }

  void show() {
    if (random(1)> 0.8) stroke(255, 20);
    else stroke(col);
    if (random(1)> 0.95) strokeWeight(random(10, 20));
    else strokeWeight(random(3, 10));
    //point(pos.x, pos.y);

    line(pos.x, pos.y, prevPos.x, prevPos.y);
 
  }

  void edges() {
    if (pos.x > width)  pos.x = 0;
    if (pos.x < 0)      pos.x = width;
    if (pos.y > height) pos.y = 0;
    if (pos.y < 0)      pos.y = height;
    updatePreviousPos();
  }

  void updatePreviousPos() {
    this.prevPos.x = pos.x;
    this.prevPos.y = pos.y;
  }

  void follow(FlowField flowfield) {
    int x = floor(pos.x / flowfield.scl);
    int y = floor(pos.y / flowfield.scl);
    int index = x + y * flowfield.cols;

    PVector force = flowfield.vectors[index];
    applyForce(force);
  }
}
