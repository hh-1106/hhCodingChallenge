class Firework {

  ArrayList<Particle> particles;
  Particle firework;
  float hu;
  float size = random(2, 8);
  float exTime = 999;
  float fx, fy;

  Firework() {
    hu = random(360);
    firework = new Particle(random(100, width-100), height, hu);
    //firework = new Particle(width/2+ 10, height, hu);
    particles = new ArrayList<Particle>();
  }
  
  Firework(float x) {
    hu = random(360);
    firework = new Particle(x, height, hu);
    particles = new ArrayList<Particle>();
  }

  boolean done() {
    return (firework == null && particles.isEmpty()) ?
      true :false;
  }

  void lighting(float time) {
    loadPixels();
    for (int x=0; x<width; x++) {
      for (int y=0; y<height; y++) {
        int index = x + y * width;
        float d = dist(fx, fy, x, y);
        if (d < 64*size*time)
          pixels[index] = color(hu, 200*size / d, time*64*size / d);
      }
    }        
    updatePixels();
    tint(360, time*size*0.5);
    image(back, 0, 0, 1600, 900);
  }

  void run() {
    if (firework != null) {
      firework.applyForce(gravity);
      firework.update();
      firework.display();

      if (firework.explode()) {
        exTime = 30;
        for (int i = 0; i < size*80; i++) {
          particles.add(new Particle(firework.pos, hu, size));
        }   
        fx = firework.pos.x;
        fy = firework.pos.y;
        firework = null;
      }
    }

    // lighting
    if (exTime < 39) {
      lighting(exTime-30);
      exTime += 1;
      //println("ex", exTime);
    }

    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.applyForce(gravity);
      p.run();
      if (p.fade()) {
        particles.remove(i);
      }
    }
  }
}
