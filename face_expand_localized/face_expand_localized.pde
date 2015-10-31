import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture webcam;
OpenCV opencv;
float tileDepth = 7;
int screenWidth = 960;
int screenHeight = 720;
Rectangle[] faceRects;
PImage[] faceImages;

void setup () {
  size(screenWidth, screenHeight);
  webcam = new Capture(this, screenWidth, screenHeight);
  opencv = new OpenCV(this, screenWidth, screenHeight);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  webcam.start();
}

void draw() {
  loadFrame();
  grabFaces();
  renderFaces(tileDepth);
}

void loadFrame () {
  webcam.read();
  opencv.loadImage(webcam);
}

void grabFaces () {
  faceRects = opencv.detect();
  faceImages = new PImage[faceRects.length];
  for (int i = 0; i < faceRects.length; i++) {
    Rectangle faceRect = faceRects[i];
    PImage faceImage = webcam.get(faceRect.x, faceRect.y, faceRect.width, faceRect.height);
    faceImages[i] = faceImage;
  }
}

void renderFaces (float depth) {
  rect(0, 0, screenWidth, screenHeight);
  for (float i = depth; i > 0; i--) {
    float scale = i / depth;
    for (int j = 0; j < faceImages.length; j++) {
      PImage faceImage = faceImages[j];
      Rectangle faceRect = faceRects[j];
      pasteFace(faceImage, faceRect, scale);
    }
  }
}

void pasteFace (PImage faceImage, Rectangle faceRect, float scale) {
  int scaledFaceWidth = (int)(scale * faceRect.width);
  int scaledFaceHeight = (int)(scale * faceRect.height);
  int newX = faceRect.x + (faceRect.width - scaledFaceWidth) / 2;
  int newY = faceRect.y + (faceRect.height - scaledFaceHeight) / 2;
  image(faceImage, newX, newY, scaledFaceWidth, scaledFaceHeight);
}
