class HalfHalfSplit extends BaseSketch {
  OpenCV opencv;
  Capture webcam;
  
  void setup(Capture webcam, OpenCV opencv) {
    this.webcam = webcam;
    this.opencv = opencv;
    
    opencv.startBackgroundSubtraction(3, 3, 0.5);
  }
  
  void drawImage(PImage img, int cX, int cY) {
    pushMatrix();
    imageMode(CENTER);
    translate(cX, cY);
    rotate(millis() / 10023f);
    scale(pow(1.4, sin(millis() / 79f)));
    image(img, 0, 0, width/2, height/2);
    popMatrix();
  }
  
  void draw() {
    if (webcam.available()) {
      webcam.read();
      background(0);
      drawImage(webcam, width/4, height/4);
      drawImage(webcam, width/4, 3*height/4);
      drawImage(webcam, 3*width/4, height/4);
      drawImage(webcam, 3*width/4, 3*height/4);
    }
  }
}
