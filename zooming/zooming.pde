import processing.video.*;
import java.awt.*;

Capture video;
float granularity = 0.001;

float maxZoom = 1000;
float minZoom = 1;
float currentZoom = 1000;
int currentDegrees = 0;
String zoomDir = "smaller";

int zoomSpeed = 1;
int rotationSpeed = 1;
int opacity = 1;

String camera;

void setup () {
  size(displayWidth, displayHeight);
  String[] cameras = Capture.list();
  camera = cameras[0];
  for (int i = 0; i < cameras.length; i++) {
    println(cameras[i]);
  }
  video = new Capture(this, camera);
  video.start();
  blendMode(SUBTRACT);
}

void draw () {
  if (video.available() == true) {
    video.read();
    setZoom();        
    setDirection(); 
    setRotation();
    rotateFrame();
    printFrame();
  }
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
  tint(255, opacity);
  translate(width / 2, height / 2);
  rotate(radians(currentDegrees));
  translate(-width / 2, -height / 2);  
}

void printFrame () {
  float scale = currentZoom * granularity;
  int scaledFrameWidth = (int)(scale * width);
  int scaledFrameHeight = (int)(scale * height);
  int newX = (width - scaledFrameWidth) / 2;
  int newY = (height - scaledFrameHeight) / 2;
  image(video, newX, newY, scaledFrameWidth, scaledFrameHeight);
}