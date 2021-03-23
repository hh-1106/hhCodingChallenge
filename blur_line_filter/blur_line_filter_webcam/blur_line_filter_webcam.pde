import processing.video.*;

final int CAP_W = 1280;
final int CAP_H = 720;
final int RES_W = 480;

Capture        cap;
BlueLineFilter BLF;

void setup() {
  size(480, 720);
  frameRate(30);

  printArray(Capture.list());
  cap = new Capture(this, CAP_W, CAP_H);
  cap.start();

  BLF = new BlueLineFilter();
}

void draw() {
  background(0);

  BLF.update(cap);
  BLF.render();

  surface.setTitle("" + frameRate);
}

void captureEvent(Capture c) {
  c.read();
}

void keyPressed() {
  if (key == ' ') {
    BLF.toScan();
  } else if (key == 'S' || key == 's') {
    saveFrame();
  }
}
