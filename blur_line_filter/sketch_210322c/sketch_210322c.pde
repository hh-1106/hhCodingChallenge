import processing.video.*;
final int CAP_W = 1280;
final int CAP_H = 720;
final int RES_W = 480;


Capture        cap;
BlueLineFilter BLF;

void setup() {
  size(640, 480);
  printArray(Capture.list());
  cap = new Capture(this, 640, 480);
  cap.start();

  BLF = new BlueLineFilter();
}

void draw() {
  background(0);

  BLF.update(cap);
  BLF.render();
}

void captureEvent(Capture c) {
  c.read();
}
