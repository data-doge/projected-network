import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0);

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < faces.length; j++) {
      float scale = 1.0 / i;
      Rectangle face = faces[j];
      int scaledFaceWidth = (int)(scale * face.width);
      int scaledFaceHeight = (int)(scale * face.height);
      copy(video.get(), face.x, face.y, face.width, face.height, face.x, face.y, scaledFaceWidth, scaledFaceHeight);
    }
  }
}


void captureEvent(Capture c) {
  c.read();
}
