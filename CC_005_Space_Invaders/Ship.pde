class Ship extends Object {

  Ship() {
    this.x = width/2;
    this.y = height-20;
    this.xdir = 0;
  }

  void show() {
    fill(255);
    //rect(this.x, this.y, 20, 60);
    triangle(this.x, this.y-20, this.x-20, this.y+20, this.x+20, this.y+20);
  }

  void setDir(float xdir, float ydir) {
    this.xdir = xdir;
    this.ydir = ydir;
  }

  void move() {
    this.x += this.xdir*5;
    this.y += this.ydir*5;
  }
}
