import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
float tileDepth;

void setup () {
  int screenWidth = 640;
  int screenHeight = 480;
  size(screenWidth, screenHeight);
  video = new Capture(this, screenWidth/2, screenHeight/2);
  opencv = new OpenCV(this, screenWidth/2, screenHeight/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  tileDepth = 15;
  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);
  image(video, 0, 0);
  
  Rectangle[] faces = opencv.detect();
  copyFaces(faces);
}

void copyFaces (Rectangle[] faces) {
  for (float i = tileDepth; i > 0; i--) {
    for (int j = 0; j < faces.length; j++) {
      Rectangle face = faces[j];
      float scale = i / tileDepth;
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

void captureEvent (Capture c) {
  c.read();
}
