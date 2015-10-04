import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
float tileDepth = 15;

void setup () {
  int screenWidth = 640;
  int screenHeight = 480;
  size(screenWidth, screenHeight);
  video = new Capture(this, screenWidth, screenHeight);
  opencv = new OpenCV(this, screenWidth, screenHeight);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  video.start();
}

void draw() {
  video.read();
  opencv.loadImage(video);
  image(video, 0, 0);
  
  Rectangle[] faces = opencv.detect();
  copyFaces(faces, tileDepth);
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
  copy(video.get(), face.x, face.y, face.width, face.height, newX, newY, scaledFaceWidth, scaledFaceHeight);
}