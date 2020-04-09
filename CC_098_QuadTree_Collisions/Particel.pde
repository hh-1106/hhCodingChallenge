class Particle extends UserData {
  float x;
  float y;
  float r = 1;
  boolean highlight = false;

  Particle(float x, float y) {
    this.x = x;
    this.y = y;
  }

  public boolean intersects(Particle other) {
    float d = dist(this.x, this.y, other.x, other.y);
    return (d < this.r + other.r);
  }

  public void setHighlight(boolean value) {
    this.highlight = value;
  }

  public void move() {
    this.x += random(-1, 1);
    this.y += random(-1, 1);
  }

  public void show() {
    noStroke();
    fill(this.highlight ?255 :100);
    ellipse(this.x, this.y, this.r * 2, this.r * 2);
  }
}
