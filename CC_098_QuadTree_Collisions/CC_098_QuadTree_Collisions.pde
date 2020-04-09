ArrayList<Particle> particles;
QTreeSystem QTS;

void setup() {
  size(1200, 800);
  rectMode(CENTER);
  QTS = new QTreeSystem();

  particles = new ArrayList<Particle>();
  for (int i = 0; i < 10000; i++) {
    particles.add(new Particle(random(width), random(height)));
  }
  frameRate(100);
}

void draw() {
  background(0);

  QTS.refactor();

  for (Particle p : particles) {
    Node node = new Node(p.x, p.y, p);
    QTS.insert(node);

    p.move();
    p.show();
    p.setHighlight(false);
  }
  //QTS.show();

  for (Particle p : particles) {
    Circle range = new Circle(p.x, p.y, p.r * 2);
    ArrayList<Node> nodes = QTS.query(range, null);
    for (Node n : nodes) {
      if (n.userData instanceof Particle) {
        Particle other = (Particle)n.userData;

        //for (Particle other : particles) {
        if (p != other && p.intersects(other))
          p.setHighlight(true);
      } else println("should your particle class extends UserData");
    }
  }

  String txt_fps = String.format("[frame %d]   [fps %6.2f]", frameCount, frameRate);
  surface.setTitle(txt_fps);
}
