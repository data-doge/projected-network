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
  dilateAndErode(3);
  edges = opencv.getSnapshot();


  loadPixels();
  for (int i = 0; i < pixels.length; i++) {
    color pixel = pixels[i];
    float red = red(pixel);
    float green = green(pixel);
    float blue = blue(pixel);
    float brightness = (red + green + blue) / 3;
    println(brightness);
    pixels[i] = color(red, green, brightness);
  }
  // go through each pixel, and ...
    // map its darkness to a color within the visible spectrum (red -> blue)

  image(edges, 0, 0);
}

void dilateAndErode (int iterations) {
  for (int i = 0; i < iterations; i++) {
    opencv.dilate();
  }
  for (int i = 0; i < iterations; i++) {
    opencv.erode();
  }
}
