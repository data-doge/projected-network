import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;
import java.util.*;

abstract class BaseSketch {
  abstract void setup(Capture webcam, OpenCV opencv, PGraphics g);
  abstract void draw();
}

List<BaseSketch> sketches = new ArrayList();
int currentSketchIndex = 0;

Capture webcam;

PGraphics texture;

void setup() {
  webcam = new Capture(this, 640, 480);
  println("got webcam");
  size(displayWidth, displayHeight, P2D);
  
  texture = createGraphics(width, height, P2D);
  println("created graphics");
  
  webcam.start();
  println("started webcam");
  
  sketches.add(new HalfHalfSplitSketch());
  sketches.add(new HSVOffsetSketch());
  println("added sketches");
  
  pushStyle();
  setCurrentSketch(0);
  println("set first sketch");
}

void draw() {
  texture.beginDraw();
  texture.pushMatrix();
  getCurrentSketch().draw();
  texture.popMatrix();
  texture.endDraw();
  
  
  background(0);
  fill(255); noStroke();
  beginShape();
  texture(texture);
  vertex(160, 0, 0, 0);
  vertex(1098, 0, width, 0);
  vertex(1056, 1078, width, height);
  vertex(103, 739, 0, height);
  endShape(CLOSE);
  
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
  texture.beginDraw();
  getCurrentSketch().setup(webcam, opencv, texture);
  texture.endDraw();
}
