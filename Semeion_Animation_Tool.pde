GUI myGUI;
Animation animation;
boolean isPlaying;

void setup() {
  size(1800, 900);

  smooth();
  animation = new Animation();
  myGUI = new GUI();
  colorMode(HSB);
}

void draw() {
  background(0);
  myGUI.display();
}


void mouseDragged() {
  myGUI.mouseDragged();
}

void mouseReleased() {
  myGUI.mouseReleased();
}

void keyPressed() {

  if (key == ' ') {
    isPlaying = !isPlaying;
  }

  myGUI.keyPressed();
}
