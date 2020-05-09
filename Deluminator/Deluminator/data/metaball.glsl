#ifdef GL_ES
precision mediump float;    // 精度 lowp mediump highp
#endif

#define METABLL_NUM 100

uniform vec2 u_resolution;  
uniform vec2 u_mouse;       
uniform float u_time;  
uniform vec4 metaballs[METABLL_NUM];
const vec4 u_color = vec4(0.5294, 0.7608, 0.8941, 1.0);
uniform float halo;  
// float halo = 0.8;

float remap(float min1, float max1, float min2, float max2, float value) {
  return min2 + (max2 - min2) * (value - min1) / (max1 - min1);
}

void main(){
  vec2 uv = gl_FragCoord.xy/u_resolution.x;
  float i = 0.0;
  for (int j = 0; j < METABLL_NUM; j++) {
    vec3 mb = metaballs[j].xyz/u_resolution.x;
    float r = mb.z;
    if(r < 0.001) continue;

    float d = distance(uv, mb.xy);
    float phase = metaballs[j].w;
    float wave = remap(-1., 1., 0.8, 1.2, sin(u_time + phase));
    r *= wave;
    i += r*r/(d*d);
  } 

  // 测试
  // if(halo == 0.8){
  //   float d = distance(uv, vec2(0.6, 0.4));
  //   float r = 0.1;
  //   i = r*r/(d*d);

  //   d = distance(uv, vec2(0.2, 0.7));
  //   r = 0.1;
  //   i += r*r/(d*d);

  //   d = distance(uv, u_mouse/u_resolution.x);
  //   r = 0.1;
  //   i += r*r/(d*d);
  // }

  i = pow(i, halo);
  gl_FragColor = vec4(u_color*i); 
}
