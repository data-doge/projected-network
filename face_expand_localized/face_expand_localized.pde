import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture webcam;
OpenCV opencv;
float tileDepth = 15;
int screenWidth = 640;
int screenHeight = 480;

void setup () {
  size(screenWidth, screenHeight);
  webcam = new Capture(this, screenWidth, screenHeight);
  opencv = new OpenCV(this, screenWidth, screenHeight);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  webcam.start();
}

void draw() {
  // read webcam 
  webcam.read();
  // upload to opencv
  opencv.loadImage(webcam);
  // grab each face, store in array
  Rectangle[] faceRects = opencv.detect();
  PImage[] faceImages = new PImage[faceRects.length];
  for (int i = 0; i < faceRects.length; i++) {
    Rectangle faceRect = faceRects[i];
    PImage faceImage = webcam.get(faceRect.x, faceRect.y, faceRect.width, faceRect.height);
    faceImages[i] = faceImage;
  }

  // put large black rectangle black rectangle, which is size of the screen
  rect(0, 0, screenWidth, screenHeight);

  // for each face, put them on screen at same coordinates as before, and copyFaces on them
  for (int i = 0; i < faceImages.length; i++) {
    PImage faceImage = faceImages[i];
    Rectangle faceRect = faceRects[i];
    image(faceImage, faceRect.x, faceRect.y);
  }

}

void copyFaces (Rectangle[] faces, float depth) {
  for (float i = depth; i > 0; i--) {
    for (int j = 0; j < faces.length; j++) {
      Rectangle face = faces[j];
      float scale = i / depth;
      copyFace(face, scale);
    }
  }
}

void copyFace (Rectangle face, float scale) {
  int scaledFaceWidth = (int)(scale * face.width);
  int scaledFaceHeight = (int)(scale * face.height);
  int newX = face.x + (face.width - scaledFaceWidth) / 2;
  int newY = face.y + (face.height - scaledFaceHeight) / 2;
  copy(webcam.get(), face.x, face.y, face.width, face.height, newX, newY, scaledFaceWidth, scaledFaceHeight);
}
