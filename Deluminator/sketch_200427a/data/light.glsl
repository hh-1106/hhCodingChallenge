#ifdef GL_ES
precision mediump float;    // 精度 lowp mediump highp
#endif

uniform vec2 u_resolution;  
uniform vec2 u_mouse;       
uniform float u_time;       

uniform vec2 u_pos;         // 位置
uniform vec3 u_color;       // 颜色
uniform float u_radius;     // 半径
uniform float u_power;      // 力量
uniform float u_phase;      // 闪烁的初相

// #define u_pos u_mouse
// float u_radius = 10.;
// float u_power = 0.8;   
// vec3 u_color = vec3(0.6863, 0.1333, 0.7608);
// const float u_phase = 0.0;

float dMax = pow(0.707107, u_power);
const float PI = 3.141592;
const float HALF_PI = PI * 0.5;

float remapTo01(float v, float low, float high){
	return clamp((v - low)/(high-low),0.0,1.0);
}

float plot(vec2 uv, float pct){
  return  smoothstep( pct-0.01, pct, uv.y) -
          smoothstep( pct, pct+0.01, uv.y);
}

float cicle(vec2 pos, vec2 center, float radius){
	//求出点到圆心距离，如果为正则在圆外 负在圆内 我们需要对圆内的点进行上色 即对负值进行处理
	float d = length(pos-center)-radius;
	//smoothstep(a, b, t) 判断t t<a返回0，t>b返回1，t在a-b之间反差值返回0-1 
	float t = smoothstep(0., 0.02, d);
	return 1.0-t;
}

void main(){
  vec2 uv = gl_FragCoord.xy/u_resolution.x;
  vec2 sm = u_pos/u_resolution.x;

  float d = distance(uv, sm);
  d = pow(d, u_power);
  d = remapTo01(d, 0., dMax);

  // 半径随时间变化
  float r = u_radius + abs(sin(u_time + u_phase))* u_radius;
  
  // 亮度调整
  float i = 1.0 / (r * d);
  i *= cicle(uv, sm, 0.5);
  vec3 col = u_color *i;

  // 画出d的范围
  // float pct = plot(uv, d);
  // col += pct*vec3(1.0);

	gl_FragColor = vec4(col, i);
}