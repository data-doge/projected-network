import gab.opencv.*;
import processing.video.*;

Capture video;
OpenCV opencv;

void setup() {
  int screenWidth = 640;
  int screenHeight = 480;
  size(screenWidth, screenHeight);
  video = new Capture(this, screenWidth, screenHeight);
  opencv = new OpenCV(this, screenWidth, screenHeight);
  opencv.gray();
  opencv.threshold(100);
  opencv.invert();

  video.start();
}

void draw() {
  video.read();
  image(video, 0, 0);
  opencv.loadImage(video);
  opencv.dilate();
  opencv.erode();
}