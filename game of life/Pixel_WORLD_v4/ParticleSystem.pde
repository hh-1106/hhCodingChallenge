class ParticleSystem {

  private ArrayList<Particle> particles;


  ParticleSystem() {
    particles = new ArrayList<Particle>();
  }

  private void init(ArrayList<PVector> vs) {
    particles = new ArrayList<Particle>();
    for (PVector v : vs) {
      this.particles.add(new Particle(v.x, v.y));
    }
  }

  private void update() {
    for (Particle p : particles) {
      Node node = new Node(p.x, p.y, p);
      QTS.insert(node);

      p.move();
      p.show();
    }
  }
}
