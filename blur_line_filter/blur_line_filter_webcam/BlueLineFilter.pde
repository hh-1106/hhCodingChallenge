class BlueLineFilter {

  PImage    src;
  PGraphics res;
  PGraphics blPG;
  int lineY = -10;
  int lineH = 6;
  int speed = 2;
  boolean scanning = false;

  BlueLineFilter() {
    res  = createGraphics(CAP_W, CAP_H);
    blPG = createBlueLine(RES_W, lineH);
  }

  void update(PImage frame) {
    src = frame.get(400, 0, RES_W, CAP_H);

    if (scanning) {
      timeWarp();

      if (lineY >= frame.height) {
        scanning = false;
      }
    }
  }

  void timeWarp() {
    src.loadPixels();
    res.beginDraw();

    for (int i=0; i<speed; i++) {
      if (lineY >=0 && lineY <= src.height) {
        PImage row = src.get(0, lineY, src.width, 1);
        res.set(0, lineY, row);
      }
      lineY++;
    }

    res.endDraw();
  }

  void render() {
    set(0, 0, src);
    image(res, 0, 0);
    image(blPG, 0, lineY-lineH*0.5);
  }

  void toScan() {
    scanning = true;
    lineY = -10;
    res.beginDraw();
    res.clear();
    res.endDraw();
  }

  PGraphics createBlueLine(int w, int h) {
    PGraphics pg = createGraphics(w, h);

    pg.beginDraw();
    pg.rectMode(CENTER);
    pg.translate(w*.5, h*.5);
    pg.noStroke();

    for (int i=h; i>=1; i-=2) {
      float alpha = map(i, 1, h, 255, 10);
      pg.fill(0, 255, 255, alpha);
      pg.rect(0, 0, w, i);
    }

    pg.endDraw();

    return pg;
  }
}
