
ParticleSystem PS;            // 粒子系统

void setup() {
  size(1200, 800);
  rectMode(CENTER);
  PS = new ParticleSystem();
  
  frameRate(100);
}

void draw() {
  background(0);

  PS.run();                
  PS.collisi();
  
  String txt_fps = String.format("[frame %d]   [fps %6.2f]", frameCount, frameRate);
  surface.setTitle(txt_fps);
}
