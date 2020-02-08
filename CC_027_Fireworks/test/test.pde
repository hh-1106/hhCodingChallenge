ArrayList<Firework> fireworks;

PVector gravity = new PVector(0, 0.2);

void setup() {
  size(400, 600, P2D);
  fireworks = new ArrayList<Firework>();
  colorMode(HSB);
  background(0);
}

void draw() {
  if (random(1) < 0.01) {
    //fireworks.add(new Firework());
  }

  fill(10, 30);
  noStroke();
  rect(0,0,width,height);
  //background(0);


  for (int i = fireworks.size()-1; i >= 0; i--) {
    Firework f = fireworks.get(i);
    f.run();
    if (f.done()) {
      fireworks.remove(i);
    }
  }
}


void keyPressed() {
  fireworks.add(new Firework());
}
