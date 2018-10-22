class GUI {

  Lamp lamp;

  GUI() {
    lamp = new Lamp();

    smooth();
    noStroke();

    PFont font;
    font = createFont("Courier New", 22);
    textFont(font);
  }

  void display() {  
    lamp.display();
  }
  

  class Lamp {

    int size = 100;

    Lamp() {
    }

    void display() {
      ellipseMode(CENTER);
      fill(255);

      ellipse(width/2, height/4, size, size);
    }
  }

  void mouseDragged(){};


  void mouseReleased(){};
  
  void keyPressed(){};


}
