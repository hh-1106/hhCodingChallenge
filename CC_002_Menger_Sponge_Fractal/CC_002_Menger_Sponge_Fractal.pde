/*
  Code after going through Daniel Shiffman's tutorials.
  Author: hh
*/


import peasy.*;

float a = 0;
Box b;
PeasyCam cam;

ArrayList<Box> sponge;
void setup()
{
  size(800, 800, P3D);
  cam = new PeasyCam(this, 1000);

  sponge = new ArrayList<Box>();

  Box b = new Box(0, 0, 0, 200);
  sponge.add(b);
}

void keyPressed() {
  ArrayList<Box> next = new ArrayList<Box>();

  for (Box b : sponge) {
    ArrayList<Box> newBoxes = b.generate();
    next.addAll(newBoxes);
  }

  sponge = next;
}


void draw()
{
  background(55);
  stroke(255);
  noFill();
  lights();

  //translate(width/2, height/2);
  rotateX(a);
  //rotateY(a*0.4);
  //rotateZ(a*0.2);

  for (Box b : sponge) {
    b.show();
  }

  a += 0.01;
}
