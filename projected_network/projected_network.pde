import gab.opencv.*;
import processing.video.*;

Capture webcam;
// Movie video;
OpenCV opencv;

void setup() {
  // video = new Movie(this, "street.mov");
  webcam = new Capture(this, 640, 480);
  opencv = new OpenCV(this, webcam.width, webcam.height);
  size(webcam.width * 3, webcam.height);
  
  opencv.startBackgroundSubtraction(5, 5, 0.5);
  
  webcam.start();
  
//  video.loop();
//  video.play();
}

void draw() {
  if (webcam.available()) {
//    println("got capture");
    webcam.read();
    image(webcam, 0, 0);
    opencv.loadImage(webcam);
    opencv.updateBackground();
    image(opencv.getSnapshot(), webcam.width, 0);
    
    opencv.dilate();
    opencv.erode();
    image(opencv.getSnapshot(), webcam.width * 2, 0);

    noFill();
    stroke(255, 0, 0);
    strokeWeight(3);
    for (Contour contour : opencv.findContours()) {
      pushMatrix();
      contour.draw();
      translate(webcam.width * 2, 0);
      contour.draw();
      popMatrix();
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
