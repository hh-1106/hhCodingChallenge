void mouseClicked() {
  int frame = (int)map(mouseX, 0, width, 0, getLength());
  setFrame(frame);
}

void mouseReleased() {
  BLF.toScan();
}

void setFrame(int n) { 
  float frameDuration = 1.0 / mov.frameRate;
  float where = (n + 0.5) * frameDuration; 
  float diff = mov.duration() - where;
  if (diff < 0) {
    where += diff - 0.25 * frameDuration;
  }  
  mov.jump(where);
}  

int getLength() {
  return int(mov.duration() * mov.frameRate);
}

void showTimeLine() {
  if (mouseX > 0 || mouseX < width) {
    cursor(HAND);
    if (mov == null) return;
    pushStyle();
    pushMatrix();
    strokeWeight(2);
    stroke(255, 80);
    translate(0, -1);
    line(0, height, width, height);
    stroke(255);
    float x = mov.time()*1.0 / (float)mov.duration() * width;
    line(0, height, x, height);
    popMatrix();
    popStyle();
  }
}
