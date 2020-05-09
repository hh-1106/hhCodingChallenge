public class LumosSystem {
  private ArrayList<Lumos> lumos;

  LumosSystem() {
    this.lumos = new ArrayList<Lumos>();

    for (int i=0; i<100; i++) {
      this.lumos.add(new Lumos());
    }
  }

  public void update() {
    for (Lumos lumo : this.lumos) {
      lumo.update();
    }
    lumos.get(0).followMouse();
  }

  public void show() {
    for (Lumos lumo : this.lumos) {
      lumo.show();
    }
  }
}
