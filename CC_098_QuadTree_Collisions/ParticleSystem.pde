/**
 * 粒子系统
 * 使用四叉树进行碰撞检测
 * 四叉树的实现已封装
 */
class ParticleSystem {
  ArrayList<Particle> particles;
  QTreeSystem QTS;

  ParticleSystem() {
    QTS = new QTreeSystem();

    particles = new ArrayList<Particle>();
    for (int i = 0; i < 100; i++) {
      particles.add(new Particle(random(width), random(height)));
    }
  }


  void run() {
    // 更新四叉树
    QTS.refactor();

    for (Particle p : particles) {
      // 把particle信息置入四叉树
      Node node = new Node(p.pos.x, p.pos.y, p);
      QTS.insert(node);

      p.move();
      p.show();
      p.setHighlight(false);
    }
    //QTS.show();
  }

  // 碰撞检测
  void collisi() {
    for (Particle p : particles) {
      // 四叉树查询p周围的粒子
      // TODO: 待优化 四倍r检测范围
      Circle range = new Circle(p.pos.x, p.pos.y, p.r * 4);
      ArrayList<Node> nodes = QTS.query(range, null);

      for (Node n : nodes) {                      // 对p周围的每一个粒子:
        if (n.userData instanceof Particle) {     //
          Particle other = (Particle)n.userData;  //

          //for (Particle other : particles) {    // 如果不用四叉树卡死,可做对比
          if (p != other && p.intersects(other)) {
            p.setHighlight(true);
          }
        } else {
          println("should your particle class extends UserData");
        }
      }
    }
  }
}
