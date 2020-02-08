class Leaf {
  PVector pos;
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float diameter;
  float hue;
  float sat;
  float opacity;
  PVector offset;
  boolean dynamic = false;
  Branch parent;

  Leaf(float _x, float _y, Branch _parent) {
    this.pos = new PVector(_x, _y);
    this.diameter = random(2.0, 8.0);
    this.opacity = random(5.0, 50.0);
    this.parent = _parent;
    this.offset = new PVector(_parent.restPos.x-this.pos.x, _parent.restPos.y-this.pos.y);

    if (leaves.size() % 5 == 0) {
      this.hue = 5;
      this.sat = 100;
    } else {
      this.hue = random(20);
      this.sat = 70;
    }
  }

  void show() {
    noStroke();
    fill(this.hue+season, sat+winter, 100, this.opacity);
    ellipse(this.pos.x, this.pos.y, this.diameter, this.diameter);
  }

  void bounds() {
    if (! this.dynamic) {
      return;
    }

    float ground = height-this.diameter*0.5;

    if (this.pos.y > ground) {
      this.vel.y = 0;
      this.vel.x *= 0.95;
      this.pos.y = ground;
    }
  }

  void applyForce(PVector force) {
    this.acc.add(force);
  }

  void update() {
    if (this.dynamic) {
      // Sim leaf

      PVector gravity = new PVector(0, 0.025);
      this.applyForce(gravity);

      this.vel.add(this.acc);
      this.pos.add(this.vel);
      this.acc.mult(0);

      this.bounds();
    } else {
      // Follow branch
      this.pos.x = this.parent.end.x+this.offset.x;
      this.pos.y = this.parent.end.y+this.offset.y;
    }
  }

  void destroyIfOutBounds() {
    if (this.dynamic) {
      if (this.pos.x < 0 || this.pos.x > width) {
        leaves.remove(this);
      }
    }
  }
}
