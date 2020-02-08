class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  float lifespan;

  boolean seed = false;

  float hu;

  Particle(float x, float y, float h) {
    hu = h;
    acc = new PVector(0, 0);
    vel = new PVector(0, random(-15, -11));
    pos =  new PVector(x, y);
    seed = true;
    lifespan = 255.0;
  }

  Particle(PVector p, float h) {
    hu = h;
    acc = new PVector(0, 0);
    vel = PVector.random2D();
    //vel.mult(random(4, 8));
    //vel.mult(5);
    vel.mult(random(5));
    pos = p.copy();
    lifespan = 255.0;
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void run() {
    update();
    display();
  }

  boolean explode() {
    if (seed && vel.y > 0) {
      lifespan = 0;
      return true;
    }
    return false;
  }

  // Method to update location
  void update() {

    vel.add(acc);
    pos.add(vel);
    if (!seed) {
      lifespan -= 5.0;
      vel.mult(0.95);
    }
    acc.mult(0);
  }

  // Method to display
  void display() {
    stroke(hu, 255, 255, lifespan);
    //stroke(hu, lifespan);
    if (seed) {
      strokeWeight(4);
    } else {
      strokeWeight(2);
    }
    point(pos.x, pos.y);
    //ellipse(location.x, location.y, 12, 12);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
