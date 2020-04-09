QTreeSystem QTS;

ParticleSystem PS;
PImage img;
int w=5;
int[] src;
GOL gol;

void setup() {
  //size(1920, 540, P2D);
  size(1600, 900, P2D);
  //size(960, 540, P2D);
  rectMode(CENTER);
  colorMode(HSB);

  img = loadImage("2.png");
  src = img.pixels.clone();

  PS = new ParticleSystem();
  QTS = new QTreeSystem();
  gol = new GOL();


  PS.init(gol.getPath());
  image(img, 0, 0);

  frameRate(30);
  //setFont();
}


void draw() {
  //background(0);
  fill(0, 20);
  rect(width*0.5, height*0.5, width, height);

  gol.show();
  gol.generate();

  //translate(width*0.5, 0);

  //int cap = floor(map(pow(mouseX, 0.1), 0, pow(width, 0.1), 10000, 2));

  QTS.refactor(2);
  PS.init(gol.getPath());
  PS.update();
  QTS.show();



  String txt_fps = String.format("[frame %d]   [fps %6.2f]", frameCount, frameRate);
  surface.setTitle(txt_fps);
}

void mousePressed() {
  isGlitch=!isGlitch;
}
