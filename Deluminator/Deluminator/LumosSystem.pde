int MB_ATTR_LEN = 4;
int MB_NUM = 20;

class LumosSystem {
  ArrayList<Lumos> lumos;
  float[] mbs = new float[MB_NUM * MB_ATTR_LEN];  // metaballs

  LumosSystem( ) {
    lumos = new ArrayList<Lumos>();
    for (int i = 0; i < MB_NUM; i++) {
      lumos.add(new Lumos());
    }
  }

  void update() {
    for (Lumos lu : lumos) {
      lu.update();
    }
    setAttr();
  }

  void setAttr() {
    for (int i = 0; i < MB_NUM; i++) {
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
}
