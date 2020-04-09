void setFont() {
  //String[] fontList = PFont.list();
  //printArray(fontList);
  PFont font = createFont("Mouse.otf", 48);
  textFont(font);
  textAlign(CENTER, CENTER);
}



boolean isGlitch = false;
void glitch(float w, float h, color c) {
  //pushMatrix();
  if (!isGlitch) return;

  fill(hue(c)+random(-100,100),
    random(200, 250),
    brightness(c) + random(10));
  rect(0, 0, w*2, h*2);


  //popMatrix();
}
