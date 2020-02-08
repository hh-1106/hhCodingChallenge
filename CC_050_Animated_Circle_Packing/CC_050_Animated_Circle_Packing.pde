/*
  Code after going through Daniel Shiffman's tutorials.
  Author: hh
*/


ArrayList<Circle> circles;
PImage img;
float alpha = 0;

void setup() {
  size(1080, 720, P2D);
  //size(480, 320);
  frameRate(100);

  rectMode(CENTER);
  //colorMode(HSB);
  img = loadImage("hh.png");
  circles = new ArrayList<Circle>();
}

void draw() {
  background(0);
  tint(255, alpha);
  image(img, 0, 0);

  if (alpha < 256) {
    alpha += (frameCount<700) ?.03 :1;
  }
  println(frameRate, frameCount, alpha);
  addCirlce();
  update();
}


void addCirlce() {
  int total = (int)random(10,50);
  int count = 0;

  while (count <  total) {
    Circle newC = newCircle();
    if (newC != null) {
      circles.add(newC);
      count++;
    }
  }
}

void update() {
  for (Circle c : circles) {
    if (c.growing) {
      if (c.edges()) {
        c.growing = false;
      } else {
        for (Circle other : circles) {
          if (c != other) {
            float d = dist(c.x, c.y, other.x, other.y);
            if (d < c.r + other.r) {
              c.growing = false;
              break;
            }
          }
        }
      }
    }
    c.show();
    c.grow();
  }
}



Circle newCircle() {
  float x = random(width);
  float y = random(height);

  boolean valid = true;
  for (Circle c : circles) {
    float d = dist(x, y, c.x, c.y);
    if (d < c.r) {
      valid = false;
      break;
    }
  }

  if (valid) {
    int index = int(x) + int(y) * img.width;
    color col = img.pixels[index];
    //color cola = color(red(col), green(col), blue(col), random(150,250));

    return new Circle(x, y, col);
  } else {
    return null;
  }
}


void mousePressed() {
  for (Circle c : circles) {
    float d = dist(mouseX, mouseY, c.x, c.y);
    if (d < c.r) {
      //circles.remove(c);
      c.showing = false;
      c.growing = false;
      c.r = 0;
    }
  }
}
