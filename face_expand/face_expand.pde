import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;
float tileDepth;

void setup() {
  size(640, 480);
  video = new Capture(this, 640/2, 480/2);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  tileDepth = 20;
  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0);

  Rectangle[] faces = opencv.detect();
  
  for (float i = tileDepth; i > 0; i--) {
    for (int j = 0; j < faces.length; j++) {
      float scale = i / tileDepth;
      Rectangle face = faces[j];
      int scaledFaceWidth = (int)(scale * face.width);
      int scaledFaceHeight = (int)(scale * face.height);
      int newX = face.x + (face.width - scaledFaceWidth) / 2;
      int newY = face.y + (face.height - scaledFaceHeight) / 2;
      copy(video.get(), face.x, face.y, face.width, face.height, newX, newY, scaledFaceWidth, scaledFaceHeight);
    }
  }
}


void captureEvent(Capture c) {
  c.read();
}
