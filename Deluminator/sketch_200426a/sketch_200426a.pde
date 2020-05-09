void setup() {
  size(1000, 1000);
}

void draw() {
  // 遍历画布每个像素点
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      // 每个点到鼠标的距离
      float d = dist(x, y, mouseX, mouseY);
      // 光圈半径
      float r = abs(sin(frameCount*0.02))*3. + 3.;
      // 光照强度
      float i = 255.0/(d*r);
      // 像素上色
      set(x, y, color(136*i, 172*i, 211*i, 255));
    }
  }
  
  // 窗口栏显示帧率
  String txt_fps = String.format("[frame %d]   [fps %6.2f]", frameCount, frameRate);
  surface.setTitle(txt_fps);
}
