/*
  Code after going through Daniel Shiffman's tutorials.
  Author: hh
*/


import geomerative.*;


float diameter;
float amplitude;
float time;
float interval;
float frequency;
float phase;

PVector pos;
PVector prev;

ArrayList<PVector> path;
//ArrayList<PVector> drawing;
ArrayList<Complex> x;
ArrayList<Complex> Fourier;

RShape grp;
RPoint[] drawing;


void setup() {
  //fullScreen();
  size(900, 600);

  pos = new PVector();
  prev = new PVector();

  x = new ArrayList<Complex>();
  Fourier = new ArrayList<Complex>();

  path = new ArrayList<PVector>();


  RG.init(this);
  RG.ignoreStyles(false);
  RG.setPolygonizer(RG.ADAPTATIVE);
  grp = RG.loadShape("1.svg");
  grp.centerIn(g, 100, 1, 1);
  drawing = grp.getPoints();


  int skip = 1;
  if (skip > 0) {
    for (int i = 0; i < drawing.length; i += skip) {
      RPoint point = drawing[i];
      Complex c = new Complex(point.x, point.y);
      x.add(c);
    }
    Fourier = dft(x);
    SortComplex(Fourier);
  }

}

void draw() {
  background(51);
  stroke(255);
  noFill();

  if (false) {
    PVector vertex = showfourier(width/2, height/2, Fourier);

    path.add(vertex.copy());

    beginShape();
    for (int i = path.size()-1; i > 0; i--) {
      PVector p = path.get(i);
      vertex(p.x, p.y);
    }
    endShape();

    time += interval;

    if (time > TWO_PI) {
      time = 0;
      path.clear();
    }
    stroke(255, 25);
  }

  // 展示SVG
  beginShape();
  for (RPoint p : drawing) {
    vertex(p.x + width/2, p.y + height/2);
  }
  endShape();
}





PVector showfourier(float x, float y, ArrayList<Complex> fourier) {
  pos.x = x;
  pos.y = y;
  interval = TWO_PI/fourier.size();

  for (int i = 0; i < fourier.size(); i++) {
    prev.x = pos.x;
    prev.y = pos.y;

    Complex epicycle = fourier.get(i);

    frequency = epicycle.freq;
    amplitude = epicycle.amp;
    phase = epicycle.phase;
    diameter = amplitude*2;

    float theta = frequency * time + phase;

    pos.x += amplitude * cos(theta);
    pos.y += amplitude * sin(theta);
    noFill();
    stroke(255, 150);
    ellipse(prev.x, prev.y, diameter, diameter);
    stroke(255);
    line(prev.x, prev.y, pos.x, pos.y);
  }
  return new PVector(pos.x, pos.y);
}



void SortComplex(ArrayList<Complex> c) {
  int n = c.size();

  for (int i = 0; i < n-1; i++) {
    int mindex = i;

    for (int j = i+1; j < n; j++) {
      if (c.get(j).amp > c.get(mindex).amp)
        mindex = j;
    }
    swap(c, mindex, i);
  }
}


void swap(ArrayList<Complex> c, int i, int j) {
  Complex temp = c.get(i);
  c.set(i, c.get(j));
  c.set(j, temp);
}
