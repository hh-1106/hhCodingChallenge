/**
 * 一个简易的 随机运动碰撞就会高亮 的DEMO
 *
 *
 */

class Particle implements UserData, Fluid {
  PVector pos;
  PVector vel;
  float r;
  boolean highlight = false;

  Particle(float x, float y) {
    this.pos = new PVector(x, y);
    this.r = random(10, 50);
    this.vel = new PVector(random(-1, 1), random(-1, 1));
  }

  public boolean intersects(Particle other) {
    float d = dist(this.pos.x, this.pos.y, other.pos.x, other.pos.y);
    return (d < this.r + other.r);
  }

  public void setHighlight(boolean value) {
    this.highlight = value;
  }

  public void move() {
    this.pos.add(this.vel);
  }

  public void show() {
    noStroke();
    fill(this.highlight ?255 :100);
    ellipse(this.pos.x, this.pos.y, this.r * 2, this.r * 2);
  }

  public void draw() {
  }
}
