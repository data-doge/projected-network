class HSVOffsetSketch extends BaseSketch {
  OpenCV opencv;
  PGraphics g;
  
  void setup(OpenCV opencv, PGraphics g) {
    this.opencv = opencv;
    this.g = g;
    
    opencv.startBackgroundSubtraction(3, 3, 0.5);
  }
  
  void draw(PImage webcam) {
    g.background(0);
    g.blendMode(ADD);
    g.image(webcam, 0, 0, width, height);
    opencv.loadImage(webcam);
    opencv.updateBackground();
//    opencv.threshold(128);
    g.colorMode(HSB);
    g.tint(frameCount % 255, 255, 255);
    g.colorMode(RGB);
    g.pushMatrix();
    g.translate(width/2, height/2);
    g.scale(1.2);
    g.image(opencv.getSnapshot(), -width/2, -height/2, width, height);
    g.popMatrix();
    g.noTint();
  }
}
