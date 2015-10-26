import processing.video.*;
import java.awt.*;

Capture video;
float granularity = 0.001;


float maxZoom = 1000;
float minZoom = 500;
float currentZoom = maxZoom;

int zoomSpeed = ;
String zoomDir = "smaller";

void setup () {
  size(displayWidth, displayHeight);
  video = new Capture(this, width, height);
  video.start();
}

void draw () {
  if (video.available() == true) {
    video.read();
        
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

    float scale = currentZoom * granularity;

    int scaledFrameWidth = (int)(scale * width);
    int scaledFrameHeight = (int)(scale * height);
    int newX = (width - scaledFrameWidth) / 2;
    int newY = (height - scaledFrameHeight) / 2;

    tint(255, 50);
//    translate(width / 2, height / 2);
//    rotate(radians(currentZoom * 4));
//    translate(-width / 2, -height / 2);
    image(video, newX, newY, scaledFrameWidth, scaledFrameHeight);
    
  }
}
