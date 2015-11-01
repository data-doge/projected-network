class HalfHalfSplitSketch extends BaseSketch {
  OpenCV opencv;
  PGraphics g;
  
  PImage webcam;
  
  void setup(OpenCV opencv, PGraphics g) {
    this.opencv = opencv;
    this.g = g;
  }
  
  void drawImage(PImage img, int cX, int cY) {
    g.pushMatrix();
    g.blendMode(ADD);
    g.imageMode(CENTER);
    g.translate(cX, cY);
    g.rotate(millis() / 10023f);
    g.scale(0.9 + pow(1.3, sin(millis() / 7945f)));
    g.image(img, 0, 0, width/2, height/2);
    g.popMatrix();
  }
  
  void draw(PImage webcam) {
    this.webcam = webcam;
    g.background(0);
    drawImage(webcam, width/4, height/4);
    drawImage(webcam, width/4, 3*height/4);
    drawImage(webcam, 3*width/4, height/4);
    drawImage(webcam, 3*width/4, 3*height/4);
  }
}
