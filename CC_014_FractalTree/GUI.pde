import controlP5.*;
GUI gui;

class GUI {
  ControlP5 cp5;
  Slider sliderS;
  Slider sliderW;
  Slider sliderR;

  GUI(PApplet thePApplet) {
    cp5 = new ControlP5(thePApplet);
  }

  void setup() {
    cp5.setColorBackground(0x141414);
    sliderS = cp5.addSlider("season")
      .setPosition(10, height-60)
      .setRange(0, 0.1)
      .setValue(0.01)
      .setSize(75, 12)
      .setSensitivity(0.1);

    sliderW = cp5.addSlider("winter")
      .setPosition(10, height-40)
      .setRange(0, 0.1)
      .setValue(0.01)
      .setSize(75, 12)
      .setSensitivity(0.1);

    sliderR = cp5.addSlider("rate")
      .setPosition(10, height-20)
      .setRange(1, 300)
      .setValue(100)
      .setSize(75, 12)
      .setSensitivity(1.0);
  }
}


public void season(float value) {
  season_rate = value;
}

public void winter(float value) {
  winter_rate = value;
}

public void rate(float value) {
  frameRate(value);
}
