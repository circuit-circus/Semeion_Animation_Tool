class Curve {

  float posX, posY;
  float[] curve = {0.0, 0.5, 0.0, 0.2, 1.0, 0.2, 1.0, 0.5};
  int DraggingMode = -1;
  float pWidth = 0.4;
  boolean hidden = false;
  float scale = 100;
  boolean isActive = true;

  Curve() {
  }

  void display() {
    fill(150); 
    if (!hidden) {
      ellipse(curve[0] * scale + posX, curve[1] * scale + posY, pWidth * scale, pWidth * scale);
      ellipse(curve[2] * scale + posX, curve[3] * scale + posY, pWidth * scale, pWidth * scale);
      ellipse(curve[4] * scale + posX, curve[5] * scale + posY, pWidth * scale, pWidth * scale);
      ellipse(curve[6] * scale + posX, curve[7] * scale + posY, pWidth * scale, pWidth * scale);
      line(curve[0] * scale + posX, curve[1] * scale + posY, curve[2] * scale + posX, curve[3] * scale + posY);
      line(curve[4] * scale + posX, curve[5] * scale + posY, curve[6] * scale + posX, curve[7] * scale + posY);
    }
    noFill();
    stroke(255);
    bezier(
      curve[0] * scale + posX, curve[1] * scale + posY, 
      curve[2] * scale + posX, curve[3] * scale + posY, 
      curve[4] * scale + posX, curve[5] * scale + posY, 
      curve[6] * scale + posX, curve[7] * scale + posY
      );
    //writeRectCommand();
  }

  void mouseDragged() {
    if (isActive) {
      float d;
      d = dist(mouseX, mouseY, curve[0], curve[1]);
      if ((d < pWidth/2) || (DraggingMode == 1))
      {
        curve[0] = mouseX;
        curve[1] = mouseY;
        DraggingMode = 1;
        return;
      }
      d = dist(mouseX, mouseY, curve[2], curve[3]);
      if ((d < pWidth/2) || (DraggingMode == 2)) 
      {
        curve[2] = mouseX;
        curve[3] = mouseY;
        DraggingMode = 2;
        return;
      }
      d = dist(mouseX, mouseY, curve[4], curve[5]);
      if ((d < pWidth/2) || (DraggingMode == 3)) 
      {
        curve[4] = mouseX;
        curve[5] = mouseY;
        DraggingMode = 3;
        return;
      }
      d = dist(mouseX, mouseY, curve[6], curve[7]);
      if ((d < pWidth/2) || (DraggingMode == 4)) 
      {
        curve[6] = mouseX;
        curve[7] = mouseY;
        DraggingMode = 4;
        return;
      }
    }
  }

  void mouseReleased()
  {
    DraggingMode = -1;
  }

  void keyPressed() 
  {
    if (key == ' ') hidden = !hidden;
  }

  //void writeRectCommand() {
  //  float xtext = width * .1;
  //  float ytext = height * .9;
  //  String str;

  //  fill(0);
  //  str = "bezier(";    
  //  text(str, xtext, ytext);   
  //  xtext += textWidth(str);

  //  fill(Colors[0]);
  //  str = nf(int(x1), 1)+", "+nf(int(y1), 1)+", ";
  //  text(str, xtext, ytext);   
  //  xtext += textWidth(str);

  //  fill(Colors[2]);
  //  str = nf(int(cx1), 1)+", "+nf(int(cy1), 1)+", ";
  //  text(str, xtext, ytext);
  //  xtext += textWidth(str);

  //  fill(Colors[3]);
  //  str = nf(int(cx2), 1)+", "+nf(int(cy2), 1)+", ";
  //  text(str, xtext, ytext);
  //  xtext += textWidth(str);

  //  fill(Colors[1]);
  //  str = nf(int(x2), 1)+", "+nf(int(y2), 1);
  //  text(str, xtext, ytext);   
  //  xtext += textWidth(str);

  //  fill(0);
  //  text(");", xtext, ytext);
  //}
}
