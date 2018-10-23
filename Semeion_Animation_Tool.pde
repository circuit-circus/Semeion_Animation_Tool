GUI myGUI;
ArrayList<Animation> animations;

void setup() {
  size(600, 600);

  smooth();
  myGUI = new GUI();
  colorMode(HSB); 
  animations.add(new Animation());
}

void draw() {
  background(0);
  myGUI.display();
}

void mouseDragged(){
  myGUI.mouseDragged();
}

void mouseReleased(){
  myGUI.mouseReleased();
}

void keyPressed(){
  myGUI.keyPressed();
}
