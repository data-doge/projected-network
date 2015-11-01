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
    g.image(webcam, 0, 0);
    g.blendMode(ADD);
    opencv.loadImage(webcam);
    opencv.equalizeHistogram();
    opencv.updateBackground();
    PImage snapshot = opencv.getSnapshot();
    g.colorMode(HSB);
    g.tint((millis() / 15) % 255, 255, 128);
    g.colorMode(RGB);
    g.pushMatrix();
    float dx = 100 * sin(millis() / 10024f);
    float dy = 100 * cos(millis() / 10231f);
    g.translate(width/2.3 + dx, height/2 + dy);
    g.image(snapshot, -width/2, -height/2);
    g.scale(1.3);
    g.image(snapshot, -width/2, -height/2);
    g.scale(1.3);
    g.image(snapshot, -width/2, -height/2);
    
    g.popMatrix();
    g.noTint();
  }
}
