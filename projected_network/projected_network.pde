import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture webcam;
// Movie video;
OpenCV opencv;

PImage initialImage;

void setup() {
  // video = new Movie(this, "street.mov");
  for(String captureInfo : Capture.list()) {
    println(captureInfo);
  }
  webcam = new Capture(this, 640, 480, "USB2.0 Camera");
  opencv = new OpenCV(this, webcam.width, webcam.height*2);
  size(webcam.width * 3, webcam.height);
  
  opencv.startBackgroundSubtraction(3, 3, 0.5);
  
  webcam.start();
//  while (!webcam.available()) {
//    try {
//      Thread.sleep(10);
//    } catch( Exception e) {
//    }
//  }
//  
//  webcam.read();
//  initialImage = webcam;
  
//  video.loop();
//  video.play();
}

void draw() {
  if (webcam.available()) {
    webcam.read();
    image(webcam, 0, 0);
    opencv.loadImage(webcam);
//    opencv.diff(initialImage);
    opencv.updateBackground();
    image(opencv.getSnapshot(), webcam.width, 0);
    
//    opencv.threshold((int)map(mouseX, 0, width, -100, 100));
//    println((int)map(mouseX, 0, width, -100, 100));
    opencv.dilate();
    opencv.erode();
    opencv.erode();
    image(opencv.getSnapshot(), webcam.width * 2, 0);

    noFill();
    stroke(255, 0, 0);
    strokeWeight(3);
    for (Contour contour : opencv.findContours()) {
      if (contour.area() > 5) {
        Rectangle boundingBox = contour.getBoundingBox();
        float centerX = boundingBox.x + boundingBox.width / 2;
        float centerY = boundingBox.y + boundingBox.height / 2;
        float radius = (boundingBox.width + boundingBox.height) / 2;
        pushMatrix();
//        contour.draw();
//        ellipse(centerX, centerY, radius, radius);
//        translate(webcam.width * 2, 0);
//        contour.draw();
//        ellipse(centerX, centerY, radius, radius);
        popMatrix();
      }
    }
  }
  
//  image(video, 0, 0);  
//  opencv.loadImage(video);
//  
//  opencv.updateBackground();
//  
//  opencv.dilate();
//  opencv.erode();
//
//  noFill();
//  stroke(255, 0, 0);
//  strokeWeight(3);
//  for (Contour contour : opencv.findContours()) {
//    contour.draw();
//  }
}

//
//void movieEvent(Movie m) {
//  m.read();
//}
