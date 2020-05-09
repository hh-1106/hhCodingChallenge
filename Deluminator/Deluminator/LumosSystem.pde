int MB_ATTR_LEN = 4;
int MB_LEN = 100;

class LumosSystem {
  ArrayList<Lumos> lumos;
  float[] mbs = new float[MB_LEN * MB_ATTR_LEN];  // metaballs
  float halo = 0.5;

  LumosSystem( ) {
    lumos = new ArrayList<Lumos>();
    for (int i = 0; i < MB_LEN; i++) {
      lumos.add(new Lumos());
    }
    metaballShader.set("u_resolution", width*1., height*1.);
    metaballShader.set("halo", 0.8);
  }

  void update() {
    for (Lumos lu : lumos) {
      lu.update();
    }
    setAttr();
  }

  private void setAttr() {
    for (int i = 0; i < MB_LEN; i++) {
      mbs[i*MB_ATTR_LEN] = lumos.get(i).pos.x;
      mbs[i*MB_ATTR_LEN + 1] = lumos.get(i).pos.y;
      mbs[i*MB_ATTR_LEN + 2] = lumos.get(i).r;
      mbs[i*MB_ATTR_LEN + 3] = lumos.get(i).phase;
    }
    metaballShader.set("metaballs", mbs, MB_ATTR_LEN);
  }

  void render(PGraphics pg) {
    pg.shader(metaballShader);
    pg.beginShape(QUADS);
    pg.vertex(0, 0);
    pg.vertex(width, 0);
    pg.vertex(width, height);
    pg.vertex(0, height);
    pg.endShape();
  }

  void show() {
    for (Lumos lu : lumos) {
      lu.show();
    }
  }

  public void turnOn() {
    for (Lumos lu : lumos) {
      lu.moveTo();
    }
  }

  public void turnOff() {
    for (Lumos lu : lumos) {
      lu.keep = false;
    }
  }

  void controlOne(float x, float y) {
    lumos.get(0).pos.set(x, y);
  }
}
