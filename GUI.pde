class GUI {

  Lamp lamp;
  ArrayList<AnimationGraph> myAnimations;

  int posX;
  int posY;

  GUI() {
    lamp = new Lamp();

    for (int i = 0; i < animations.size(); i++) {
      myAnimations.add(new AnimationGraph(animations.get(i)));
    }

    posX = 0;
    posY = height/2;

    smooth();
    noStroke();

    PFont font;
    font = createFont("Barlow", 22);
    textFont(font);
  }

  void display() {  
    lamp.display();
    for (int i = 0; i < myAnimations.size(); i++) {
      myAnimations.get(i).display();
    }
  }

  void mouseDragged() {
  };


  void mouseReleased() {
  };

  void keyPressed() {
  };


  class Lamp {

    int size = 100;

    Lamp() {
    }

    void display() {
      ellipseMode(CENTER);
      fill(255);

      ellipse(width/2, height/4, size, size);
    }

    void animate() {
    }
  }

  class AnimationGraph {

    float posX, posY;
    int draggingMode = -1;
    float pWidth = 0.1;
    boolean hidden = false;
    float scale = 300;
    boolean isActive = true;
    Animation myAnimation;

    AnimationGraph(Animation a) {
      myAnimation = a;

      posX = 0;
      posY = height/2;
    }

    void display() {
      //  fill(150); 
      //  if (!hidden) {
      //    ellipse(myCurve.curve[0] * scale + posX, myCurve.curve[1] * scale + posY, pWidth * scale, pWidth * scale);
      //    ellipse(myCurve.curve[2] * scale + posX, myCurve.curve[3] * scale + posY, pWidth * scale, pWidth * scale);
      //    ellipse(myCurve.curve[4] * scale + posX, myCurve.curve[5] * scale + posY, pWidth * scale, pWidth * scale);
      //    ellipse(myCurve.curve[6] * scale + posX, myCurve.curve[7] * scale + posY, pWidth * scale, pWidth * scale);
      //    line(myCurve.curve[0] * scale + posX, myCurve.curve[1] * scale + posY, myCurve.curve[2] * scale + posX, myCurve.curve[3] * scale + posY);
      //    line(myCurve.curve[4] * scale + posX, myCurve.curve[5] * scale + posY, myCurve.curve[6] * scale + posX, myCurve.curve[7] * scale + posY);
      //  }
      //  noFill();
      //  stroke(255);
      //  bezier(
      //    myCurve.curve[0] * scale + posX, myCurve.curve[1] * scale + posY, 
      //    myCurve.curve[2] * scale + posX, myCurve.curve[3] * scale + posY, 
      //    myCurve.curve[4] * scale + posX, myCurve.curve[5] * scale + posY, 
      //    myCurve.curve[6] * scale + posX, myCurve.curve[7] * scale + posY
      //    );
    }
  }

  class CurveGraph {
    
    int draggingMode;
    int pWidth = 10;

    CurveGraph() {
    }  

    void display() {
    }

    void mouseDragged() {

      float d;
      d = dist(mouseX, mouseY, curve[0], curve[1]);
      if ((d < pWidth/2) || (draggingMode == 1))
      {
        curve[0] = mouseX;
        curve[1] = mouseY;
        draggingMode = 1;
        return;
      }
      d = dist(mouseX, mouseY, curve[2], curve[3]);
      if ((d < pWidth/2) || (draggingMode == 2)) 
      {
        curve[2] = mouseX;
        curve[3] = mouseY;
        draggingMode = 2;
        return;
      }
      d = dist(mouseX, mouseY, curve[4], curve[5]);
      if ((d < pWidth/2) || (draggingMode == 3)) 
      {
        curve[4] = mouseX;
        curve[5] = mouseY;
        draggingMode = 3;
        return;
      }
      d = dist(mouseX, mouseY, curve[6], curve[7]);
      if ((d < pWidth/2) || (draggingMode == 4)) 
      {
        curve[6] = mouseX;
        curve[7] = mouseY;
        draggingMode = 4;
        return;
      }
    }

    void mouseReleased()
    {
      draggingMode = -1;
    }

    void keyPressed() 
    {
      if (key == ' ') hidden = !hidden;
    }
  }
}
