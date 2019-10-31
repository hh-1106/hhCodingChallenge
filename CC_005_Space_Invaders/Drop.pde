class Drop extends Object {
  boolean toDelete;

  Drop(float x, float y) {
    super(x, y);
    this.r = 10;
    this.toDelete = false;
  }

  void show() {
    noStroke();
    fill(0,255,255);
    //ellipse(this.x, this.y, this.r*2, this.r*2);
    rect(this.x, this.y, this.r/3, this.r*2);
  }

  void evaporate() {
    this.toDelete = true;
  }

  boolean hits(Flower flower) {
    float d = dist(this.x, this.y, flower.x, flower.y);
    if (d < this.r + flower.r) {
      return true;
    } else {
      return false;
    }
  }

  void move() {
    this.y = this.y - 5;
  }
}
