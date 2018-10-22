GUI myGUI;
Curve myCurve;

void setup() {
  size(600, 600);

  smooth();
  myGUI = new GUI();
  colorMode(HSB); 
  myCurve = new Curve();

}

void draw() {
  background(0);
  myGUI.display();
  myCurve.display();
}

void mouseDragged(){
  myCurve.mouseDragged();
}

void mouseReleased(){
  myCurve.mouseReleased();
}

void keyPressed(){
  myCurve.keyPressed();

}
