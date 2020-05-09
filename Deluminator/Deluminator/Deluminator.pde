PShader metaballShader;
LumosSystem LS;
PVector deluminator;

void settings() {
  size(1280, 720, P2D);
}

void setup() {
  metaballShader = loadShader("metaball.glsl");
  LS = new LumosSystem();
  deluminator = new PVector(0, 0);
  frameRate(60);
}

void draw() {
  background(0);

  LS.update();
  LS.render(this.g);
  LS.show();
  
  fps();
}


void mouseMoved(){
  deluminator = new PVector(mouseX, height-mouseY);
  LS.turnOn();
}


void keyPressed(){
  LS.turnOff();
}
