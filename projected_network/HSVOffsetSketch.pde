class HSVOffsetSketch extends BaseSketch {
  OpenCV opencv;
  Capture webcam;
  
  void setup(Capture webcam, OpenCV opencv) {
    this.webcam = webcam;
    this.opencv = opencv;
    
    opencv.startBackgroundSubtraction(3, 3, 0.5);
    
    imageMode(CENTER);
  }
  
  void draw() {
    if (webcam.available()) {
      webcam.read();
      background(0);
      blendMode(ADD);
      image(webcam, width/2, height/2, width, height);
      opencv.loadImage(webcam);
      opencv.updateBackground();
      colorMode(HSB);
      tint(frameCount % 255, 255, 128);
      colorMode(RGB);
      image(opencv.getSnapshot(), width/2, height/2 - 100, width, height);
      noTint();
    }
  }
}
