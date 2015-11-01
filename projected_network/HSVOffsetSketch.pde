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
    PImage snapshot = opencv.getSnapshot();
    g.colorMode(HSB);
    g.tint(frameCount % 255, 255, 128);
    g.colorMode(RGB);
    g.pushMatrix();
    float dx = 100 * sin(millis() / 1024f);
    float dy = 100 * cos(millis() / 1231f);
    g.translate(width/2 + dx, height/2 + dy);
    g.image(snapshot, -width/2, -height/2, width, height);
    g.scale(1.2);
    g.image(snapshot, -width/2, -height/2, width, height);
    g.scale(1.2);
    g.image(snapshot, -width/2, -height/2, width, height);
    
    g.popMatrix();
    g.noTint();
  }
}
