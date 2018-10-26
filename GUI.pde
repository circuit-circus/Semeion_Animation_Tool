class GUI {

  Lamp lamp;
  AnimationGraph myAnimationGraph;

  int graphX;
  int graphY;

  GUI() {
    lamp = new Lamp();

    myAnimationGraph = new AnimationGraph(animation);

    graphX = 0;
    graphY = height/2;

    smooth();

    PFont font;
    font = createFont("Barlow", 22);
    textFont(font);
  }

  void display() {  
    lamp.display();
    myAnimationGraph.display();
  }

  void mouseDragged() {
  };


  void mouseReleased() {
  };

  void keyPressed() {
    myAnimationGraph.keyPressed();
  };


  class Lamp {

    int size = 300;

    Lamp() {
    }

    void display() {
      noStroke();
      ellipseMode(CENTER);

      fill(animation.animate() * 255);


      ellipse(width/2, height/4, size, size);
    }
  }

  class AnimationGraph {

    float graphX, graphY, graphW, graphH, padding;
    int draggingMode = -1;
    float pWidth = 20;
    boolean hidden = false;
    float scale = 0;
    boolean isActive = true;

    Animation myAnimation;  //<>// //<>// //<>// //<>// //<>//
    AnimationGraph(Animation a) {   //<>// //<>// //<>// //<>// //<>// //<>// //<>//
      myAnimation = a; 
 //<>// //<>//
      padding = 50;

      graphX = 0 + padding;
      graphY = height/2 + padding;
      graphW = width - padding*2;
      graphH = height/2 - padding*2;
    }

    void display() {

      float x = graphX;
      float y = graphY;
      float w; 
      float h = graphH; 

      for (int i = 0; i < myAnimation.myCurves.size(); i++) {
        w = graphW/myAnimation.getDuration() * myAnimation.myCurves.get(i).curve[8];

        noFill();
        stroke(255, 100);
        rect(x, graphY, w-1, h);

        fill(150);
        noStroke();
        if (!hidden) {
          ellipse(myAnimation.myCurves.get(i).curve[0] * w + x, map(myAnimation.myCurves.get(i).curve[1] * h, 0, height, height, 0), pWidth, pWidth);
          ellipse(myAnimation.myCurves.get(i).curve[2] * w + x, map(myAnimation.myCurves.get(i).curve[3] * h, 0, height, height, 0), pWidth, pWidth);
          ellipse(myAnimation.myCurves.get(i).curve[4] * w + x, map(myAnimation.myCurves.get(i).curve[5] * h, 0, height, height, 0), pWidth, pWidth);
          ellipse(myAnimation.myCurves.get(i).curve[6] * w + x, map(myAnimation.myCurves.get(i).curve[7] * h, 0, height, height, 0), pWidth, pWidth);
          stroke(105, 200, 200);
          line(myAnimation.myCurves.get(i).curve[0] * w + x, map(myAnimation.myCurves.get(i).curve[1] * h, 0, height, height, 0), myAnimation.myCurves.get(i).curve[2] * w + x, map(myAnimation.myCurves.get(i).curve[3] * h, 0, height, height, 0));
          line(myAnimation.myCurves.get(i).curve[4] * w + x, map(myAnimation.myCurves.get(i).curve[5] * h, 0, height, height, 0), myAnimation.myCurves.get(i).curve[6] * w + x, map(myAnimation.myCurves.get(i).curve[7] * h, 0, height, height, 0));
        }
        noFill();
        stroke(255);
        bezier(
          myAnimation.myCurves.get(i).curve[0] * w + x, map(myAnimation.myCurves.get(i).curve[1] * h, 0, height, height, 0), 
          myAnimation.myCurves.get(i).curve[2] * w + x, map(myAnimation.myCurves.get(i).curve[3] * h, 0, height, height, 0), 
          myAnimation.myCurves.get(i).curve[4] * w + x, map(myAnimation.myCurves.get(i).curve[5] * h, 0, height, height, 0), 
          myAnimation.myCurves.get(i).curve[6] * w + x, map(myAnimation.myCurves.get(i).curve[7] * h, 0, height, height, 0)
          );
        displayValues(i, x);

        x += w;
      }

      stroke(50, 200, 200);

      float lineX = graphW / myAnimation.getDuration() * myAnimation.getPosition();
      line(lineX + graphX, graphY + graphH, lineX + graphX, graphY);
    }

    void displayValues(int i, float x) {
      text("(" + myAnimation.myCurves.get(i).curve[1] + ", " + myAnimation.myCurves.get(i).curve[3] + ", " + myAnimation.myCurves.get(i).curve[5] + ", " + myAnimation.myCurves.get(i).curve[7] + ", " + myAnimation.myCurves.get(i).curve[8] + ")", x + 10, height - 10);
    }

    void mouseReleased()
    {
      draggingMode = -1;
    }

    void mouseDragged() {

      //float d;
      //d = dist(mouseX, mouseY, curve[0], curve[1]);
      //if ((d < pWidth/2) || (draggingMode == 1))
      //{
      //  curve[0] = mouseX;
      //  curve[1] = mouseY;
      //  draggingMode = 1;
      //  return;
      //}
      //d = dist(mouseX, mouseY, curve[2], curve[3]);
      //if ((d < pWidth/2) || (draggingMode == 2)) 
      //{
      //  curve[2] = mouseX;
      //  curve[3] = mouseY;
      //  draggingMode = 2;
      //  return;
      //}
      //d = dist(mouseX, mouseY, curve[4], curve[5]);
      //if ((d < pWidth/2) || (draggingMode == 3)) 
      //{
      //  curve[4] = mouseX;
      //  curve[5] = mouseY;
      //  draggingMode = 3;
      //  return;
      //}
      //d = dist(mouseX, mouseY, curve[6], curve[7]);
      //if ((d < pWidth/2) || (draggingMode == 4)) 
      //{
      //  curve[6] = mouseX;
      //  curve[7] = mouseY;
      //  draggingMode = 4;
      //  return;
      //}
    }

    void keyPressed() 
    {
      if (key == 'h') {
        hidden = !hidden;
      }
    }
  }

  class Handles {

    Handles() {
    }
  }
}
