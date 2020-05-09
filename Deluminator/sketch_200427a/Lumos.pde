public class Lumos {
  private PGraphics pg;
  private PShader shader;
  private PVector col;
  private float phase = random(10);
  private float power = random(0.7, 0.9);
  private float radius = random(0.05, 0.1);
  private PVector pos;
  private float w = 300.0;
  private float h = 300.0;


  Lumos() {
    this.col = new PVector(random(0.5, 1), random(0.5, 1), random(0.5, 1));
    this.pos = new PVector(random(width), random(height));
    this.pg = createGraphics(int(w), int(h), P2D);
    this.shader = loadShader("light.glsl");
    this.shader.set("u_resolution", w, h);
    this.shader.set("u_color", this.col);
    this.shader.set("u_radius", 1/this.radius);
    this.shader.set("u_power", this.power);
    this.shader.set("u_phase", this.phase);
  }

  public void update() {
    this.shader.set("u_time", 0.001*millis());
    //this.shader.set("u_pos", this.pos.x, h-this.pos.y);
    this.shader.set("u_pos", w*0.5, h*0.5);
  }

  public void show() {
    this.pg.beginDraw();
    this.pg.filter(this.shader);
    this.pg.endDraw();
    //image(this.pg, 0, 0);
    image(this.pg, pos.x-w*0.5, pos.y-h*0.5   , w, h);
  }

  public void followMouse() {
    this.shader.set("u_pos", float(mouseX), float(height-mouseY));
  }
}
