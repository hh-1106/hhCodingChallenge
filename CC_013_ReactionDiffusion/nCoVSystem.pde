class nCoVSystem {

  ArrayList<nCoV> virus;
  boolean isLerping = true;

  nCoVSystem() {
    virus = new ArrayList();
  }


  void update() {
    if (isLerping)
      for (nCoV v : virus) {
        v.lerp(v.target, 0.1);
        if (dist(v.x, v.y, v.target.x, v.target.y) < 0.1) continue;
        cs.feed(v.x, v.y);
      }
  }


  int i = 24563;
  void show() {
    if (!isLerping) {

      for (int j=0; j<200; j++) {
        if (i-j<0) break;
        PVector v = wh_target.get(i-j);
        cs.feed(v.x, v.y);
      }
      i-=200;
    }
  }
}
