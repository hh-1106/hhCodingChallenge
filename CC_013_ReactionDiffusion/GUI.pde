import controlP5.*;
GUI gui;

class GUI {
  ControlP5 cp5;
  Slider sliderA;
  Slider sliderB;
  Slider sliderF;
  Slider sliderK;
  Slider sliderR;

  GUI(PApplet thePApplet) {
    cp5 = new ControlP5(thePApplet);
  }

  void setup() {
    cp5.setColorBackground(0x141414);
    sliderA = cp5.addSlider("dA")
      .setPosition(10, height-80)
      .setRange(0, 2)
      .setValue(1.0)
      .setSize(75, 12)
      .setSensitivity(0.5);

    sliderB = cp5.addSlider("dB")
      .setPosition(10, height-60)
      .setRange(0, 2)
      .setValue(0.9)
      .setSize(75, 12)
      .setSensitivity(0.5);

    sliderF = cp5.addSlider("feed")
      .setPosition(10, height-40)
      .setRange(0, 0.2)
      .setValue(0.055)
      .setSize(75, 12)
      .setSensitivity(0.2);

    sliderK = cp5.addSlider("k")
      .setPosition(10, height-20)
      .setRange(0, 0.2)
      .setValue(0.062)
      .setSize(75, 12)
      .setSensitivity(0.2);

    sliderR = cp5.addSlider("rate")
      .setPosition(10, height-100)
      .setRange(1, 300)
      .setValue(150)
      .setSize(75, 12)
      .setSensitivity(1.0);
  }
}


public void dA(float value) {
  cs.dA = value;
}

public void dB(float value) {
  cs.dB = value;
}

public void feed(float value) {
  cs.feed = value;
}

public void k(float value) {
  cs.k = value;
}

public void rate(float value) {
  frameRate(value);
}
