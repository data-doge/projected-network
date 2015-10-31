import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture webcam;
OpenCV opencv;

void setup() {
  webcam = new Capture(this, 640, 480);
  opencv = new OpenCV(this, webcam.width, webcam.height);
  size(displayWidth, displayHeight);
  
  opencv.startBackgroundSubtraction(3, 3, 0.5);
  
  webcam.start();
}

void draw() {
  if (webcam.available()) {
    webcam.read();
    background(0);
    image(webcam, 0, 0, width, height);
    
    opencv.loadImage(webcam);
    opencv.updateBackground();
    opencv.dilate();
    opencv.erode();
    opencv.erode();

    noFill();
    stroke(255, 0, 0);
    strokeWeight(3);
    for (Contour contour : opencv.findContours()) {
      if (contour.area() > 200) {
        Rectangle boundingBox = contour.getBoundingBox();
        float centerX = boundingBox.x + boundingBox.width / 2;
        float centerY = boundingBox.y + boundingBox.height / 2;
        float radius = (boundingBox.width + boundingBox.height) / 2;
        pushMatrix();
        scale ( (float)width / webcam.width, (float)height / webcam.height );
        contour.draw();
        ellipse(centerX, centerY, radius, radius);
        translate(webcam.width * 2, 0);
        contour.draw();
        ellipse(centerX, centerY, radius, radius);
        popMatrix();
      }
    }
  }
}
