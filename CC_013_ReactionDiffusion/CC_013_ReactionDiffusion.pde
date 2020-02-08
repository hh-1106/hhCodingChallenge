/*
  Code after going through Daniel Shiffman's tutorials.
  Author: hh
*/


CellSystem cs; //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
img2path wh;
nCoVSystem ns;

ArrayList<PVector> wh_target;

void setup() {
  size(640, 1024);
  colorMode(HSB);
  cs = new CellSystem();
  gui = new GUI(this);
  gui.setup();

  wh = new img2path(this, "wh.png");
  wh_target = new ArrayList();
  wh_target = wh.getPath();
  //println(wh_target.size());

  ns = new nCoVSystem();
}



void draw() {
  background(255);
  cs.feedSize = 1;

  cs.update();
  cs.show();
  cs.swap();

  ns.update();
  ns.show();
}

void mouseDragged() {

  if (mouseButton == LEFT) {
    for (int i=0; i<8; i++) {
      cs.feedSize = floor(random(1, 5));
      float x = random(width);
      float y = mouseY+random(-5, 5);
      cs.feed(x ,y);
      ns.virus.add(new nCoV(x, y));
    }
  } else {
    cs.feedSize = 20;
    cs.feed(mouseX, mouseY);
  }
}

void keyPressed() {
  ns.isLerping = !ns.isLerping;
  ns.i = 24563;
}
