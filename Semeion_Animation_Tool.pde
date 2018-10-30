import controlP5.*;

GUI myGUI;
Animation animation;
boolean isPlaying;

void setup() {
  size(1800, 900);
  //fullScreen();
  frameRate(60);
  smooth();
  animation = new Animation();
  myGUI = new GUI(this);
  colorMode(HSB);
      
}

void draw() {
  background(0);
  myGUI.display();
}

void mouseDragged() {
  myGUI.mouseDragged();
}

void keyPressed() {

  if (key == ' ') {
    isPlaying = !isPlaying;
  } else if (keyCode == LEFT) {
    animation.stepBackward();
  } else if (keyCode == RIGHT) {
    animation.stepForward();
  }  

  myGUI.keyPressed();
}

void controlEvent(ControlEvent theEvent) {
  myGUI.controlEvent(theEvent);
}
