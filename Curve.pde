class Curve {
  
  float[] curve = {0.0, 0.5, 0.0, 0.2, 1.0, 0.2, 1.0, 0.5, 100};

  Curve() {

  }
  
  Curve(float x1, float y1, float cx1, float cy1, float x2, float y2, float cx2, float cy2, float d) {
    curve[0] = x1;
    curve[1] = y1;
    curve[2] = cx1;
    curve[3] = cy1;
    curve[4] = x2;
    curve[5] = y2;
    curve[6] = cx2;
    curve[7] = cy2;
    curve[8] = d;
  }

}
