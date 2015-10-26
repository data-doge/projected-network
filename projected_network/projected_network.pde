import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;
import java.util.*;

abstract class BaseSketch {
  abstract void setup(Capture webcam, OpenCV opencv);
  abstract void draw();
}

List<BaseSketch> sketches = new ArrayList();
int currentSketchIndex = 0;

Capture webcam;

void setup() {
  webcam = new Capture(this, 640, 480);
  size(displayWidth, displayHeight);
  
  webcam.start();
  sketches.add(new HalfHalfSplitSketch());
  sketches.add(new HSVOffsetSketch());
  
  pushStyle();
  setCurrentSketch(1);
}

void draw() {
  pushMatrix();
  getCurrentSketch().draw();
  popMatrix();
  println(frameRate);
}

void keyPressed() {
  if(key >= '1' && key <= '9') {
    setCurrentSketch(key - '1');
  }
}

BaseSketch getCurrentSketch() {
  return sketches.get(currentSketchIndex);
}

void setCurrentSketch(int index) {
  popStyle();
  currentSketchIndex = index;
  OpenCV opencv = new OpenCV(this, webcam.width, webcam.height);
  
  pushStyle();
  println("set sketch to " + getCurrentSketch());
  getCurrentSketch().setup(webcam, opencv);
}
