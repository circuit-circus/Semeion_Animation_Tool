class Animation {
  ArrayList<Curve> myCurves;
  float duration;
  int iterator = 0;
  boolean hasEnded = false;
  float t;  //<>//

  Animation() {
    myCurves = new ArrayList();
    myCurves.add(new Curve()); 
    myCurves.add(new Curve(0, 0, 0, 1.5, 0.8, 0.5, 1, 0.5, 300));
    myCurves.add(new Curve(0, 0.5, 0.5, 0.13, 0.74, 1.7, 1, 0, 100));
  }

  void addCurve() {
    myCurves.add(new Curve());
  }

  void removeCurve() {
    myCurves.remove(new Curve());
  }

  boolean hasEnded() {
    return hasEnded;
  }

  void rewind() {
    hasEnded = false;
  }

  float getDuration() {
    duration = 0;
    for (int i = 0; i < myCurves.size(); i++) {
      duration += myCurves.get(i).curve[8];
    }
    return duration;
  }

  float getPosition() {
    float p = 0;

    for (int i = 0; i < iterator; i++) {
      p += myCurves.get(i).curve[8];
    }

    p += myCurves.get(iterator).curve[8] * t;

    return p;
  }

  float animate() {

    float y = 0;

    y = bezierPoint(myCurves.get(iterator).curve[1], myCurves.get(iterator).curve[3], myCurves.get(iterator).curve[5], myCurves.get(iterator).curve[7], t);

    if (isPlaying) {

      t += 1 / myCurves.get(iterator).curve[8];

      if (t > 1) {
        t = 0;  

        iterator++;
        if (iterator > myCurves.size() - 1) {
          iterator = 0;
          hasEnded = true;
        }
      } else {
        hasEnded = false;
      }
    }

    println(t + " " + iterator + " " + y );

    return y;
  }
}
