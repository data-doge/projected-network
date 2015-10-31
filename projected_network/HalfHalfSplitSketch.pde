class HalfHalfSplitSketch extends BaseSketch {
  OpenCV opencv;
  Capture webcam;
  PGraphics g;
  
  void setup(Capture webcam, OpenCV opencv, PGraphics g) {
    this.webcam = webcam;
    this.opencv = opencv;
    this.g = g;
  }
  
  void drawImage(PImage img, int cX, int cY) {
    g.pushMatrix();
    g.imageMode(CENTER);
    g.translate(cX, cY);
    g.rotate(millis() / 10023f);
    g.scale(pow(1.4, sin(millis() / 7945f)));
    g.image(img, 0, 0, width/2, height/2);
    g.popMatrix();
  }
  
  void draw() {
    if (webcam.available()) {
      webcam.read();
      g.background(0);
      drawImage(webcam, width/4, height/4);
      drawImage(webcam, width/4, 3*height/4);
      drawImage(webcam, 3*width/4, height/4);
      drawImage(webcam, 3*width/4, 3*height/4);
    }
  }
}
