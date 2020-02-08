class Particle {
  PVector pos;
  PVector prePos;
  PVector vel;
  PVector acc;
  float hu;
  float reviveTime = 15;
  float lifespan = 150 + reviveTime;  
  float size = 20;
  boolean spark = false;

  Particle(float x, float y, float hu_) {
    hu = hu_;
    pos = new PVector(x, y);
    vel = new PVector(noise(frameRate)*((random(1)<0.5) ?2 :-2), random(-22, -18));
    //vel = new PVector(noise(frameRate)*((random(1)<0.5) ?2 :-2), random(-20, -16));
    acc = new PVector(0, 0);
  }

  Particle(PVector p, float hu_, float size_) {
    hu = hu_ + random(-20, 20);
    pos = p.copy();
    vel = PVector.random2D();
    vel.mult(size_);
    acc = new PVector(0, 0);
    spark = true;
    size = size_;
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void run() {
    update();
    display();
  }

  boolean explode() {
    return (!spark && vel.y > 0) ? true : false;
  }

  void update() {
    if (spark) {
      prePos = pos.copy();
      lifespan -= (lifespan>15+reviveTime) ?3 : noise(frameRate)*1.2;

      // sphere
      float voff = (random(1)<0.1) ? random(0.9) 
        :(0.97 + random(-0.005, 0.005));
      vel.mult(voff);

      if (vel.heading() > -0.5*PI || vel.heading() < -0.8*PI) {
        //vel.mult(0);
      }

      // slow down
      acc.y = (lifespan > 20 + reviveTime) ?0 : 0.05;
    }

    vel.add(acc);
    pos.add(vel);
    acc.mult(0);

    revive();
  }

  void revive() {
    if (spark) {
      if (lifespan < reviveTime && noise(pos.x, pos.y)<0.4) {
        float br = map(noise(pos.x, pos.y), 0, 0.4, 20, 100);
        float sa = random(40, 60);

        if (noise(pos.x, pos.y)<0.18) {
          strokeWeight(size*2);
          br = 100;
          sa = 20;
        }

        stroke(hu, sa, br, lifespan*2);
        point(pos.x, pos.y);
      }
    }
  }

  void display() {
    if (!spark) {
      strokeWeight(size*0.1);
      stroke(hu, 30, size*4);
    } else {
      strokeWeight(4);
      float sa = noise(prePos.x*0.1, prePos.y*0.1);
      stroke(hu, sa, 100, (lifespan-reviveTime)*3);
      line(prePos.x, prePos.y, pos.x, pos.y);
      stroke(hu, 50 + size*5, random(100), lifespan-reviveTime);
    }
    point(pos.x, pos.y);
  }

  boolean fade() {
    return (lifespan < 0) ? true : false;
  }
}
