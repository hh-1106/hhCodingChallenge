import processing.video.*;

final int CAP_W = 1280;
final int CAP_H = 720;
final int RES_W = 480;

Movie mov;
BlueLineFilter BLF;

void settings() {
  size(RES_W, CAP_H);
  //fullScreen();
}

void setup() {
  frameRate(30);

  mov = new Movie(this, "yawn.mp4");
  mov.loop();

  BLF = new BlueLineFilter();
}

void draw() {
  background(0);

  BLF.update(mov);
  BLF.render();

  surface.setTitle("" + frameRate);
  showTimeLine();
}

void movieEvent(Movie m) {
  m.read();
}

void keyPressed() {
  if (key == ' ') {
    BLF.toScan();
  } else if (key == 'S' || key == 's') {
    saveFrame();
  }
}
