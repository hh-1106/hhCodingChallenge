/*
  Code after going through Daniel Shiffman's tutorials.
  Author: hh
*/


import peasy.*;

float x = 0.01;
float y = 0;
float z = 0;

float a = 20;
float b = 32;
float c = 8.0/3.0;

ArrayList<PVector> points = new ArrayList<PVector>();

//PeasyCam cam;

void setup() {
  size(800, 600, P3D);
  colorMode(HSB);
  //ortho();
  //cam = new PeasyCam(this, 500);
}

void draw() {
  background(5);
  translate(width*0.5, height*0.5, 400);

  float dt = 0.01;
  float dx = (a * (y - x))*dt;
  float dy = (x * (b - z) - y)*dt;
  float dz = (x * y - c * z)*dt;

  x = x + dx;
  y = y + dy;
  z = z + dz;


  cameraFollow(new PVector(x, y, z));
  points.add(new PVector(x, y, z));

  scale(3);

  float hu = 0;
  //lights();
  beginShape();
  for (PVector v : points) {
    fill(hu, 255, 255);
    stroke(25, 128);
    vertex(v.x, v.y, v.z);
    PVector offset = PVector.random3D();
    offset.mult(0.005);
    v.add(offset);
    hu += 0.5;
    if (hu > 255) {
      hu = 0;
    }

  }
  endShape();


}


PVector eye = new PVector(width*0.5, height*0.5, (height/2.0) / tan(PI*30.0 / 180.0));
void cameraFollow(PVector target_) {

  camera(
    eye.x, eye.y, eye.z-map(mouseX, 0, width, 0, 100),
    target_.x, target_.y, target_.z, // target
    0, 1, 0
    );

  eye = eye.lerp(target_, 0.5);
}
