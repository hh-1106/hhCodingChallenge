PImage result;
PShape globe;
GOL gol;
int w=4;
int[] src;

void setup() {
  size(1080, 540, P3D);
  frameRate(24);
  //colorMode(HSB);
  result = loadImage("earth.png");
  src = result.pixels.clone();

  gol = new GOL(w);
}

void draw() {
  image(result, 0, 0, width, height);

  gol.show();
  gol.generate();
}


void mousePressed() {
  gol.init();
}
