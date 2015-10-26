import processing.video.*;
import java.awt.*;

Capture video;
float granularity = 0.001;


float maxZoom = 1000;
float minZoom = 900;
float currentZoom = 1000;
int currentDegrees = 0;
String zoomDir = "smaller";

int zoomSpeed = 6;
int rotationSpeed = 3;

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
//    println(camera);
    println(frameRate);
        
    if (zoomDir == "smaller") {
      currentZoom -= zoomSpeed;
    } else if (zoomDir == "bigger") {
      currentZoom += zoomSpeed;
    }
    
    if (currentZoom < minZoom) {
      zoomDir = "bigger";
    } else if (currentZoom > maxZoom) {
      zoomDir = "smaller";
    }
    
    if (currentDegrees < 360) {
      currentDegrees += rotationSpeed;
    } else {
      currentDegrees = 0;
    }

    float scale = currentZoom * granularity;

    int scaledFrameWidth = (int)(scale * width);
    int scaledFrameHeight = (int)(scale * height);
    int newX = (width - scaledFrameWidth) / 2;
    int newY = (height - scaledFrameHeight) / 2;

    tint(255, 1);
    translate(width / 2, height / 2);
    rotate(radians(currentDegrees));
    translate(-width / 2, -height / 2);
    
    // check out blend, burn, dodge
    image(video, newX, newY, scaledFrameWidth, scaledFrameHeight);
    
  }
}
