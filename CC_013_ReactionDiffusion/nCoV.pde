class nCoV extends PVector {
  PVector target;

  nCoV (float x, float y) {
    super(x, y);

    int i = floor(random(wh_target.size()));
    target = wh_target.get(i);
  }
}
