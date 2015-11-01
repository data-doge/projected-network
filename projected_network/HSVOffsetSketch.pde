class HSVOffsetSketch extends BaseSketch {
  OpenCV opencv;
  PGraphics g;
  
  void setup(OpenCV opencv, PGraphics g) {
    this.opencv = opencv;
    this.g = g;
    
    opencv.startBackgroundSubtraction(3, 3, 0.5);
    g.imageMode(CENTER);
  }
  
  void draw(PImage webcam) {
    g.background(0);
    g.blendMode(ADD);
    g.image(webcam, width/2, height/2, width, height);
    opencv.loadImage(webcam);
    opencv.updateBackground();
    g.colorMode(HSB);
    g.tint(frameCount % 255, 128, 255);
    g.colorMode(RGB);
    g.image(opencv.getSnapshot(), width/2, height/2 - 100, width, height);
    g.noTint();
  }
}
