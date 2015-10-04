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
  // read video 
  video.read();
  // upload to opencv
  opencv.loadImage(video);
  // grab each face, store in array
  Rectangle[] faces = opencv.detect();
  // create black rectangle, which is size of the screen

  // for each face, put them on screen at same coordinates as before, and copyFaces on them

  // write the updated black rectangle to image
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