/*
Cherry blossom fractals
 Author:  Jason Labbe 
 Site:    jasonlabbe3d.com
 */

ArrayList<Branch> branches = new ArrayList<Branch>();
ArrayList<Leaf> leaves = new ArrayList<Leaf>();
int maxLevel = 9;
PImage back;

void setup() {
  frameRate(100);
  size(960, 640, P2D);
  colorMode(HSB, 100);
  //smooth();
  generateNewTree();
  back = loadImage("back.png");
  gui = new GUI(this);
  gui.setup();
  //back.resize(width, 0);
}


void draw() {
  image(back, 0, 0);

  for (Branch b : branches) {
    b.update();
    b.show();
  }

  for (int i = leaves.size()-1; i > -1; i--) {
    Leaf leaf = leaves.get(i);
    leaf.update();
    leaf.show();
    leaf.destroyIfOutBounds();
  }

  seasonChange();
}


void keyPressed() {
  if (key == ' ') {
    generateNewTree();
    force = 1;
  }
}

int force = 1;
void mouseReleased() {
  explod();
  force*=2;
}
