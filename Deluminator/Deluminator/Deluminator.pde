PShader metaballShader;
LumosSystem LS;

void settings() {
  size(1280, 720, P2D);
}

void setup() {
  LS = new LumosSystem();
  metaballShader = loadShader("metaball.glsl");
  metaballShader.set("u_resolution", width*1., height*1.);
}

void draw() {
  background(0);

  LS.update();
  LS.render(this.g);
  //LS.show();
  
  fps();
}
