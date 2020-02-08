 import gab.opencv.*;


class img2path {
  PImage src;
  OpenCV opencv;

  ArrayList<Contour> contours;
  ArrayList<PVector> points;


  img2path(PApplet thePApplet, String path) {
    src = loadImage(path); 
    opencv = new OpenCV(thePApplet, src);

    init();
  }
  
  public ArrayList<PVector> getPath(){    
    return this.points;
  }


  private void init() {
    opencv.gray();
    opencv.threshold(57);

    contours = opencv.findContours();
    println("found " + contours.size() + " contours");
    points = new ArrayList();

    for (Contour contour : contours) {
      for (PVector p : contour.getPolygonApproximation().getPoints()) {
        points.add(p);
      }
    }
  }
}
