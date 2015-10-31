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
  sketches.add(new Zooming());
  sketches.add(new BackgroundSubtract());
  sketches.add(new DilateAndErode());

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
  if(key >= '1' && key <= '5') {
    setCurrentSketch(key - '1');
  }
}

BaseSketch getCurrentSketch() {
  return sketches.get(currentSketchIndex);
}

void setCurrentSketch(int index) {
  // (EL) reset imageMode here because in one of my sketches I set imageMode to CENTER
  imageMode(CORNER);
  blendMode(BLEND);

  popStyle();
  currentSketchIndex = index;
  OpenCV opencv = new OpenCV(this, webcam.width, webcam.height);
  
  pushStyle();
  println("set sketch to " + getCurrentSketch());
  getCurrentSketch().setup(webcam, opencv);
}
