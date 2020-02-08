class Branch {
  PVector start;
  PVector end;
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  int level;
  Branch parent = null;
  PVector restPos;
  float restLength;
  float branchWeight;

  Branch(float _x1, float _y1, float _x2, float _y2, int _level, Branch _parent) {
    this.start = new PVector(_x1, _y1);
    this.end = new PVector(_x2, _y2);
    this.level = _level;
    this.restLength = dist(_x1, _y1, _x2, _y2);
    this.restPos = new PVector(_x2, _y2);
    this.parent = _parent;
    this.branchWeight = map(pow(this.level, 0.7)
      , 0, pow(maxLevel, 0.7), 20, 1);
  }

  void show() {
    stroke(10, 57+winter, 20+this.level*4);

    strokeWeight(branchWeight);

    if (this.parent != null) {
      line(this.parent.end.x, this.parent.end.y, this.end.x, this.end.y);
    } else {
      line(this.start.x, this.start.y, this.end.x, this.end.y);
    }
  }

  Branch newBranch(float angle, float mult) {
    // Calculate new branch's direction and length
    PVector dir = new PVector(this.end.x, this.end.y);
    dir.sub(this.start);
    float branchLength = dir.mag();

    // Java doesn't have PVector.rotate() method
    // so need to manually get its new angle.
    float worldAngle = degrees(atan2(dir.x, dir.y))+angle;
    dir.x = sin(radians(worldAngle));
    dir.y = cos(radians(worldAngle));
    dir.normalize();
    dir.mult(branchLength*mult);

    PVector newEnd = new PVector(this.end.x, this.end.y);
    newEnd.add(dir);

    return new Branch(this.end.x, this.end.y, newEnd.x, newEnd.y, this.level+1, this);
  }

  void applyForce(PVector force) {
    PVector forceCopy = force.get();

    // Smaller branches will be more bouncy
    float divValue = map(this.level, 0, maxLevel, 8.0, 2.0);
    forceCopy.div(divValue);

    this.acc.add(forceCopy);
  }

  void sim() {
    PVector airDrag = new PVector(this.vel.x, this.vel.y);
    float dragMagnitude = airDrag.mag();
    airDrag.normalize();
    airDrag.mult(-1);
    airDrag.mult(0.05*dragMagnitude*dragMagnitude); 
    this.applyForce(airDrag);

    PVector spring = new PVector(this.end.x, this.end.y);
    spring.sub(this.restPos);
    float stretchedLength = dist(this.restPos.x, this.restPos.y, this.end.x, this.end.y);
    spring.normalize();
    float elasticMult = map(this.level, 0, maxLevel, 0.1, 0.2); 
    spring.mult(-elasticMult*stretchedLength);
    this.applyForce(spring);
  }

  void update() {
    this.sim();

    this.vel.mult(0.95);

    // Kill velocity below this threshold to reduce jittering
    if (this.vel.mag() < 0.05) {
      this.vel.mult(0);
    }

    this.vel.add(this.acc);
    this.end.add(this.vel);
    this.acc.mult(0);
  }
}
