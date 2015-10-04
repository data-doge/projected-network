import gab.opencv.*;
import processing.video.*;

Capture video;
OpenCV opencv;
PImage edges;

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
  opencv.loadImage(video);
  opencv.findScharrEdges(OpenCV.HORIZONTAL);
  edges = opencv.getSnapshot();
  image(edges, 0, 0);
  // opencv.dilate();
  // opencv.erode();
  // PImage contours = opencv.getSnapshot();
  // image(contours, 0, 0);
}
