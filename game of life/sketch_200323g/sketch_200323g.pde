import peasy.*;
PeasyCam cam;
PShape globe;
PImage earth;
float r = 100;
float w = 1000;
float h = 500;
CellSystem CS;


void setup() {
  size(1000, 500, P3D);
  cam = new PeasyCam(this, 300);
  //earth = loadImage("earth.jpg");
  CS = new CellSystem();
  noStroke();
  globe = createShape(SPHERE, r);
  //globe.setTexture(earth);
  colorMode(HSB, 360, 100, 100, 100);
}


void draw() {
  background(33);
  fill(255);
  lights();
  pushStyle();
  //shape(globe);
  popStyle();
  translate(-width*0.5, -height*0.5);
  //translate(width/2, height/2, -100);
  //rotateX(PI/3);
  ////rotate(frameCount / 400.0);
  //translate(-width/2, -height/2);

  println(frameRate);

  CS.update();
  CS.show();
}
