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
  sketches.add(new HalfHalfSplit());
  
  setCurrentSketch(0);
}

void draw() {
  sketches.get(currentSketchIndex).draw();
}

void setCurrentSketch(int index) {
  currentSketchIndex = index;
  OpenCV opencv = new OpenCV(this, webcam.width, webcam.height);
  sketches.get(index).setup(webcam, opencv);
}
