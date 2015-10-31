import processing.video.*;
import java.awt.*;

int centerX, centerY;

Capture video;
PGraphics graphicalMask;
PImage currentFrame;

float granularity = 0.001;

float maxZoom = 1000;
float minZoom = 1;
float currentZoom = 1000;
int currentDegrees = 0;
String zoomDir = "smaller";

int zoomSpeed = 1;
int rotationSpeed = 1;
int opacity = 1;

void setup () {
  size(displayWidth, displayHeight);
  imageMode(CENTER);
  centerX = width / 2;
  centerY = height / 2;
  initializeVideo();
  background(0);
  blendMode(SUBTRACT);
}

void draw () {
  if (video.available() == true) {
    getFrame();
    setZoom();        
    setDirection(); 
    setRotation();
    rotateFrame();
    // maskFrame();
    tint(255, opacity);
    printFrame();
  }
}

void initializeVideo () {
  String[] cameras = Capture.list();
  String cameraName = cameras[0];
  for (int i = 0; i < cameras.length; i++) {
    println(cameras[i]);
  }
  video = new Capture(this, cameraName);
  video.start();
}

void getFrame () {
  video.read();
  currentFrame = video.get();
}

void setZoom () {
  if (zoomDir == "smaller") {
    currentZoom -= zoomSpeed;
  } else if (zoomDir == "bigger") {
    currentZoom += zoomSpeed;
  }  
}

void setDirection () {
  if (currentZoom < minZoom) {
    zoomDir = "bigger";
  } else if (currentZoom > maxZoom) {
    zoomDir = "smaller";
  }
}

void setRotation () {
  if (currentDegrees < 360) {
    currentDegrees += rotationSpeed;
  } else {
    currentDegrees = 0;
  }
}

void rotateFrame () {
  translate(centerX, centerY);
  rotate(radians(currentDegrees));
  translate(-centerX, -centerY);  
}

float scale () {
  return currentZoom * granularity;
}

int scaledFrameWidth () {
  return (int)(scale() * width);
}

int scaledFrameHeight () {
  return (int)(scale() * height);
}

// void maskFrame () {
//   graphicalMask = createGraphics(currentFrame.width, currentFrame.height, JAVA2D);
//   graphicalMask.beginDraw();
//   graphicalMask.noStroke();
//   graphicalMask.ellipse(centerX, centerY, currentFrame.height / 3 * 2, currentFrame.height / 3 * 2);
//   graphicalMask.endDraw();
//   currentFrame.mask(graphicalMask);
// }

void printFrame () { 
  image(currentFrame, centerX, centerY, scaledFrameWidth(), scaledFrameHeight());
}
