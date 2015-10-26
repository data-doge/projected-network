class HalfHalfSplit extends BaseSketch {
  OpenCV opencv;
  Capture webcam;
  
  void setup(Capture webcam, OpenCV opencv) {
    this.webcam = webcam;
    this.opencv = opencv;
    
    opencv.startBackgroundSubtraction(3, 3, 0.5);
  }
  
  void draw() {
    if (webcam.available()) {
      webcam.read();
      background(0);
      image(webcam, 0, 0, width / 2, height / 2);
      image(webcam, 0, height / 2, width / 2, height / 2);
      
      
      image(webcam, width/2, 0, width / 2, height / 2);
      image(webcam, width/2, height / 2, width / 2, height / 2);
      
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
}


