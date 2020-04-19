public class FlowField {
  PVector[] vectors;
  int cols, rows;
  float inc = 0.1;
  float zoff = 0;
  int scl;

  FlowField(int scl_) {
    scl = scl_;
    cols = floor(width / scl_) + 1;
    rows = floor(height / scl_) + 1;
    vectors = new PVector[cols * rows];
  }

  void update() {
    float xoff = 0;
    for (int y = 0; y < rows; y++) {
      float yoff = 0;
      for (int x = 0; x < cols; x++) {
        float angle = noise(xoff, yoff, zoff) * TWO_PI * 4;

        PVector v = PVector.fromAngle(angle);
        int index = x + y * cols;
        v.setMag(1);
        vectors[index] = v;

        xoff += inc;
      }
      yoff += inc;
    }
    zoff += 0.001 ;
  }

  void display() {
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        int index = x + y * cols;
        PVector v = vectors[index];
        stroke(0, 5);
        strokeWeight(5);
        pushMatrix();
        translate(x * scl, y * scl);
        rotate(v.heading());
        line(0, 0, v.mag()*scl, 0);
        popMatrix();
      }
    }
  }
}
