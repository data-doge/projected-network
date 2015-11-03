import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;
import java.util.*;

abstract class BaseSketch {
  abstract void setup(OpenCV opencv, PGraphics g);
  abstract void draw(PImage webcamImage);
}

List<BaseSketch> sketches = new ArrayList();
int currentSketchIndex = 0;
OpenCV opencv;

Capture _webcam;

PGraphics texture;
PImage webcamImage;

void setup() {
  _webcam = new Capture(this, 640, 480);
  println("got webcam");
  size(displayWidth, displayHeight, P2D);
  println(width, height);
  
  _webcam.start();
  println("started webcam");
  
  sketches.add(new HalfHalfSplitSketch());
  sketches.add(new HSVOffsetSketch());
  sketches.add(new Zooming());
  sketches.add(new BackgroundSubtract());
  sketches.add(new DilateAndErode());
  println("added sketches");

  pushStyle();
  setCurrentSketch(2);
  println("set first sketch");
}

void draw() {
  if(_webcam.available()) {
    _webcam.read();
    webcamImage = _webcam.get();
    texture.beginDraw();
    texture.pushMatrix();
  //  texture.fill(255, 129, millis() % 255);
  //  texture.rect(0, 0, width, height);
    getCurrentSketch().draw(webcamImage);
    texture.popMatrix();
    texture.endDraw();
    
    
    background(0);
    fill(255); noStroke();
    beginShape();
    texture(texture);
    vertex(160.0 / 1920 * width, 0, 0, 0);
    vertex(1098.0 / 1920 * width, 0, width, 0);
    vertex(1056.0 / 1920 * width, 1078.0 / 1080 * height, width, height);
    vertex(103.0 / 1920 * width, 739.0 / 1080 * height, 0, height);
    endShape(CLOSE);
  }
  
  // 
  if (millis() - millisThisSketchStarted >= 60000 * 2) {
    setCurrentSketch(currentSketchIndex+1);
  }
  
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

int millisThisSketchStarted = 0;
void setCurrentSketch(int index) {
  index = index % sketches.size();
  popStyle();
  currentSketchIndex = index;
  opencv = new OpenCV(this, _webcam.width, _webcam.height);
  
  millisThisSketchStarted = millis();
  pushStyle();
  println("set sketch to " + getCurrentSketch());
  texture = createGraphics(width, height);

  texture.beginDraw();
  getCurrentSketch().setup(opencv, texture);
  texture.endDraw();
}
