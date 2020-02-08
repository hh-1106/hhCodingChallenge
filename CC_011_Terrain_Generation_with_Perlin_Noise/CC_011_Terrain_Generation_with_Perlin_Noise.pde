/*
  Code after going through Daniel Shiffman's tutorials.
  Author: hh
*/


int cols, rows;    // 地形:列数,行数
int w = 1000;      //      宽
int h = 800;       //      高
int scl = 10;      //      缩放比例

float flying = 0;  // 飞行效果参数

float[][] terrain; // 存放地形高度数组

void setup() {
  size(500, 500, P3D);            // 大小500*500 P3D渲染器
  cols = w / scl;                 // 设置平面行列大小
  rows = h/ scl;
  terrain = new float[cols][rows];// 开辟地形空间
}


void draw() {
  lights();    // 开启环境光
  flying -= map(mouseY*mouseY, height*height,0, 0,0.55);
  // 飞行效果(前进速度) 与鼠标高度的平方成正比

  float yoff = flying; // 噪声空间量y
  for (int y = 0; y < rows; y++) {
    float xoff = 0;    // // 噪声空间量x
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      // 返回 关于(xoff, yoff) 的Perlin噪声值,并映射大小-100到100
      // 作为地形高度
      xoff += 0.2;
    }
    yoff += 0.2;
  }

  background(51);      // 背景色
  stroke(0,255,255);   // 描边色
  noFill();            // 不填充
  //fill(250,100);

  translate(width/2, height/2+100);  // 移动地形位置
  rotateX(PI/3.2);                   // 旋转地形平面
  translate(-w/2, -h/2);             // 再次移动

  // 绘制地形
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);      // 三角形状
    for (int x = 0; x < cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]);      // →(x,y,z)
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);// → y+1
    }
    endShape();
  }
}
