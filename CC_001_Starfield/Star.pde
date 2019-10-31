class Star {
  float x, y, z, pz;
  color c;

  Star() {
    x = random(-width/2, width/2);
    y = random(-height/2, height/2);
    z = random(width);
    c = color(random(360),(random(1)<0.1)?random(50,100) :0, map(z, 0,width, 20,200));
    pz = z;
  }

  void update() {
    z = z - speed;
    if (z < 1) {//edge
      z = width;
      x = random(-width/2, width/2);
      y = random(-height/2, height/2);
      pz = z;
    }
  }

  void show() {

    float sx = map(x/z, 0, 1, 0, width/2);
    //println(x,z,sx);
    float sy = map(y/z, 0, 1, 0, height/2);

    float r = map(z, 0, width, 31, 0);
    strokeWeight(r);

    float px = map(x/pz, 0, 1, 0, width/2);
    float py = map(y/pz, 0, 1, 0, height/2);

    pz = z;
    stroke(c);
    
    line(px, py, sx, sy);
    //point(sx, sy);
  }
}
