class Zooming extends BaseSketch {

  int centerX, centerY;

  PGraphics mask;

  float granularity = 0.001;

  float maxZoom = 1000;
  float minZoom = 700;
  float currentZoom = 1000;
  int currentDegrees = 0;
  String zoomDir = "smaller";

  int zoomSpeed = 1;
  int rotationSpeed = 1;
  int opacity = 1;

  PGraphics g;
  
  OpenCV opencv;

  void setup (OpenCV opencv, PGraphics g) {
    this.opencv = opencv;
    this.g = g;
    g.imageMode(CENTER);
    centerX = width / 2;
    centerY = height / 2;
    g.background(0);
  }

  void draw (PImage video) {
    setZoom();
    setDirection(); 
    setRotation();
    rotateFrame();
    // maskFrame();
    //    g.tint(255, opacity);
    opencv.loadImage(video);
    opencv.equalizeHistogram();
    printFrame(opencv.getSnapshot());
  }

  void setZoom () {
    if (zoomDir == "smaller") {
      currentZoom -= zoomSpeed;
    } else if (zoomDir == "bigger") {
      currentZoom += zoomSpeed;
    }
  }

  void setDirection () {
    if (currentZoom < minZoom) {
      zoomDir = "bigger";
    } else if (currentZoom > maxZoom) {
      zoomDir = "smaller";
    }
  }

  void setRotation () {
    if (currentDegrees < 360) {
      currentDegrees += rotationSpeed;
    } else {
      currentDegrees = 0;
    }
  }

  void rotateFrame () {
    g.translate(centerX, centerY);
    g.rotate(radians(currentDegrees));
    g.translate(-centerX, -centerY);
  }

  float scale () {
    return currentZoom * granularity;
  }

  int scaledFrameWidth () {
    return (int)(scale() * width);
  }

  int scaledFrameHeight () {
    return (int)(scale() * height);
  }

  // void maskFrame () {
  //   mask = createGraphics(currentFrame.width, currentFrame.height, JAVA2D);
  //   mask.beginDraw();
  //   mask.noStroke();
  //   mask.ellipse(centerX, centerY, currentFrame.height, currentFrame.height);
  //   mask.endDraw();
  //   currentFrame.mask(mask);
  // }

  void printFrame (PImage currentFrame) {
//    if (frameCount % 5 < 4) {
//      g.blendMode(ADD);
//    } else {
      g.blendMode(SUBTRACT);
//    }
    g.image(currentFrame, centerX, centerY, scaledFrameWidth(), scaledFrameHeight());
  }
}

