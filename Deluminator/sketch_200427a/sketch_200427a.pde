LumosSystem lumoSys;

void setup() {
  size(1280, 720, P2D);
  colorMode(ARGB, 1.);

  lumoSys = new LumosSystem(); 
  frameRate(60);
  background(30);
}

void draw() {
  background(0);
  lumoSys.update();
  lumoSys.show();

  String txt_fps = String.format("[frame %d]   [fps %6.2f]", frameCount, frameRate);
  surface.setTitle(txt_fps);
}
