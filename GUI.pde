class GUI {

  ControlP5 cp5;
  CheckBox checkbox;

  Lamp lamp;
  AnimationGraph myAnimationGraph;
  PApplet papp;
  float translateX, translateY;
  boolean isDragging = false;

  GUI(PApplet t) {
    papp = t;
    cp5 = new ControlP5(papp);
    checkbox = cp5.addCheckBox("checkBox")
      .setPosition(50, 50)
      .setSize(40, 40)
      .setItemsPerRow(1)
      .setSpacingColumn(0)  
      .setSpacingRow(20)
      .addItem("Saturation", 0)
      .addItem("Brightness", 0)
      .addItem("Position", 0)
      ;

    lamp = new Lamp();
    myAnimationGraph = new AnimationGraph(animation);

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
    myAnimationGraph.mouseDragged();
  };

  void keyPressed() {
    myAnimationGraph.keyPressed();
  };
  
  void controlEvent(ControlEvent theEvent){
    myAnimationGraph.controlEvent(theEvent);
  }


  class Lamp {

    int size = 300;

    Lamp() {
    }

    void display() {
      noStroke();
      ellipseMode(CENTER);
      
      float hue = 0;
      float brightness;
      float x;
      float saturation;
      
      float val = animation.animate() * 255;
      
      if (checkbox.getItem(0).getState()){
        saturation = val;
      } else {
        saturation = 0;
      }
      
      if (checkbox.getItem(1).getState()){
        brightness = val;
      } else {
        brightness = 255;
      }
      
      if (checkbox.getItem(2).getState()){
        x = val;
      } else {
        x = 0;
      }

      fill(hue, saturation, brightness);
      ellipse(width/2 + x, height/4, size, size);
    }
  }

  class AnimationGraph {  //<>//
  //<>//
    float graphX, graphY, graphW, graphH, padding, graphXOffset; 
    float pWidth = 20; 
    ArrayList<CurveGraph> myCurves;     
    
    Animation myAnimation;    //<>//
 
    AnimationGraph(Animation a) {     

      myAnimation = a;     

      myCurves = new ArrayList();
 
      for (int i = 0; i < myAnimation.myCurves.size(); i++) {
        myCurves.add(new CurveGraph(this, myAnimation.myCurves.get(i)));
      }

      padding = 50; 

      graphX = 0 + padding;
      graphY = height/2 + padding;
      graphW = width - padding*2;
      graphH = height/2 - padding*2;
      graphXOffset = 0;
    }                    
                               
    void display() {              
      translateX = graphX;
      translateY = graphY;        
      graphXOffset = 0;        
                        
              
      //Draw all curves  
      for (int i = 0; i < myCurves.size(); i++) {  
        myCurves.get(i).display();        
      }
      translateX = graphX;

      //Draw indicator line
      stroke(50, 200, 200);
      strokeWeight(1);
      float lineX = graphW / myAnimation.getDuration() * myAnimation.getPosition();
      line(lineX + translateX, graphH + translateY, lineX + translateX, 0 + translateY);
    }

    void mouseDragged() {
      for (CurveGraph c : myCurves) {
        c.mouseDragged();
      }
    }

    void keyPressed() {
      for (CurveGraph c : myCurves) {
        c.keyPressed();
      }
    }
    
    void controlEvent(ControlEvent theEvent){
      for (CurveGraph c : myCurves) {
        c.controlEvent(theEvent);
      }
    }
  }

  class CurveGraph {

    ControlP5 cp;
    ArrayList<Handle> handles;
    Curve curve;
    boolean hidden;  //<>//
    AnimationGraph superGraph;
    float w, h;  //<>//
    Numberbox numbox;

    CurveGraph(AnimationGraph a, Curve c) {
      cp = new ControlP5(papp);
      handles = new ArrayList();
      curve = c;
      superGraph = a; 
      for (int i = 0; i < 4; i++) { //Using 4 because there are four handles to each curve 
        handles.add(new Handle(this, curve.curve[(i*2)], curve.curve[(i*2)+1], i));     
      }
      numbox = cp.addNumberbox("Duration")   
        .setPosition(10, h + 40)
        .setSize(100, 20) 
        .setScrollSensitivity(0.8)
        .setValue(curve.curve[8])
        .setMin(0)
        .setMax(1000)
        ;
    }

    void display() {
      
      w = superGraph.graphW/superGraph.myAnimation.getDuration() * curve.curve[8];                     
      h = superGraph.graphH;          
      translateX += superGraph.graphXOffset;                    
      
      cp.setPosition(round(translateX), round(translateY) - 80);
      
      noFill(); 
      stroke(255, 100);
      strokeWeight(1);
      rect(translateX, translateY, w-1, h); 

      noFill();
      stroke(255);          //<>//
      strokeWeight(2);
      bezier(        
        curve.curve[0] * w + translateX, map(curve.curve[1] * h, 0, h, h, 0) + translateY, 
        curve.curve[2] * w + translateX, map(curve.curve[3] * h, 0, h, h, 0) + translateY, 
        curve.curve[4] * w + translateX, map(curve.curve[5] * h, 0, h, h, 0) + translateY, 
        curve.curve[6] * w + translateX, map(curve.curve[7] * h, 0, h, h, 0) + translateY
        );
      
      fill(255,0,0);
      for (int i = 0; i < curve.curve[8]; i++){   
        point((w / curve.curve[8] * i) + translateX, map(bezierPoint(curve.curve[1], curve.curve[3], curve.curve[5], curve.curve[7], (i *( 1/curve.curve[8]))) * h, 0, h, h, 0) + translateY);  
        //println(i + " " + w/curve.curve[8]*i + " " + (map(bezierPoint(curve.curve[1], curve.curve[3], curve.curve[5], curve.curve[7], (i *( 1/curve.curve[8]))) * h, 0, h, h, 0) + translateY));  
      }

      fill(200);  
      text("(" + nf(curve.curve[1],1,3) + ", " + nf(curve.curve[3],1,3) + ", " + nf(curve.curve[5],1,3) + ", " + nf(curve.curve[7],1,3) + ", " + nf(curve.curve[8],3,0) + ")", 10 + translateX, h + 30 + translateY);

      //speed ValueBox

      if (!hidden) {
        strokeWeight(1);
        stroke(105, 200, 200);
        line(curve.curve[0] * w + translateX, map(curve.curve[1] * h, 0, h, h, 0) + translateY, curve.curve[2] * w + translateX, map(curve.curve[3] * h, 0, h, h, 0) + translateY);
        line(curve.curve[4] * w + translateX, map(curve.curve[5] * h, 0, h, h, 0) + translateY, curve.curve[6] * w + translateX, map(curve.curve[7] * h, 0, h, h, 0) + translateY);

        for (int j = 0; j < 4; j++) {
          handles.get(j).display();          
        }    
      }   
      superGraph.graphXOffset = w; 
    }

    void mouseDragged() {
      for (Handle h : handles) {
        h.mouseDragged();
      }
    }        

    void keyPressed() {
      if (key == 'h') {
        hidden = !hidden;
      }
    }
    
    void controlEvent(ControlEvent theEvent){
      if(theEvent.isFrom(numbox)){
        curve.curve[8] = numbox.getValue();
      }
    }
  }

  class Handle {

    boolean imDragging = false;
    float myX, myY;
    float handleW = 20;
    float displayX;
    float displayY;
    float myTranslateX;
    CurveGraph superGraph;
    int pointNum;

    Handle(CurveGraph g, float x_, float y_, int pn) {
      myX = x_;
      myY = y_;
      superGraph = g;
      pointNum = pn;
      
    }

    void display() {
      float w = superGraph.w; 
      float h = superGraph.h;

      fill(150);
      noStroke();
      displayX = myX * w + translateX;
      displayY = map(myY * h, 0, h, h, 0) + translateY;
      ellipse(displayX, displayY, handleW, handleW);
      myTranslateX = translateX;
    }

    void mouseDragged() {
      float d;
      d = dist(mouseX, mouseY, displayX, displayY);
      //println("d: " + d + " " + pointNum + " " + myX + " " + myY);
      if ((d < handleW && (imDragging || !isDragging )) || d < handleW * 4 && imDragging) {
        imDragging = true; 
        isDragging = true;
        if (pointNum == 1 || pointNum == 2) {
          println(translateX);
          myX = (mouseX - myTranslateX)/superGraph.w ;
          superGraph.curve.curve[pointNum*2] = myX;
        }
        myY = map(mouseY - translateY, superGraph.superGraph.graphH, 0, 0, superGraph.superGraph.graphH)/superGraph.superGraph.graphH;
        superGraph.curve.curve[pointNum*2+1] = myY;
        //if (pointNum == 1 || pointNum == 2) {
        //  displayX = mouseX;
        //  superGraph.curve.curve[pointNum*2] = (mouseX - translateX)/superGraph.w;
        //}
        //myY = map(mouseY - translateY, superGraph.superGraph.graphH, 0, 0, superGraph.superGraph.graphH)/superGraph.superGraph.graphH;
        //superGraph.curve.curve[pointNum*2+1] = myY;
      } else if (imDragging) {
        isDragging = false;
        imDragging = false;
      } else {
        imDragging = false;
      }
    }
  }
}
