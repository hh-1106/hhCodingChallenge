/*
  Code after going through Daniel Shiffman's tutorials.
  Author: hh
*/


import peasy.*;
Planet sun;

PeasyCam cam;

PImage sunTexture, stars;
PImage[] textures = new PImage[8];

void setup() {
  size(1365, 600, P3D);
  stars = loadImage("stars.jpg");
  sunTexture = loadImage("sun.jpg");
  textures[0] = loadImage("mars.jpg");
  textures[1] = loadImage("earth.jpg");
  textures[2] = loadImage("mercury.jpg");
  textures[3] = loadImage("jupiter.jpg");
  textures[4] = loadImage("neptune.jpg");
  textures[5] = loadImage("pluto.jpg");
  textures[6] = loadImage("saturn.jpg");
  textures[7] = loadImage("venus.jpg");

  cam = new PeasyCam(this, 3000);
  sun = new Planet(300, 0, 0, sunTexture);
  sun.spawnMoons(10, 1);
}

void draw() {
  background(stars);
  ambientLight(255, 255, 255);
  pointLight(255, 255, 255, 0, 0, 0);
  sun.show();
  sun.orbit();
}

CameraState state;

void keyReleased() {
  if (key == '1') state = cam.getState();
  if (key == '2') cam.setState(state, 1000);
}
