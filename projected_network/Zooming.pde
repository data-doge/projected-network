class Zooming extends BaseSketch {

  int centerX, centerY;

  Capture video;
  PGraphics mask;
  PImage currentFrame;

  float granularity = 0.001;

  float maxZoom = 1000;
  float minZoom = 1;
  float currentZoom = 1000;
  int currentDegrees = 0;
  String zoomDir = "smaller";

  int zoomSpeed = 1;
  int rotationSpeed = 1;
  int opacity = 1;


  void setup (Capture video, OpenCV opencv) {
    this.video = video;
    imageMode(CENTER);
    centerX = width / 2;
    centerY = height / 2;
    background(0);
    blendMode(SUBTRACT);
  }

  void draw () {
    if (video.available() == true) {
      getFrame();
      setZoom();        
      setDirection(); 
      setRotation();
      rotateFrame();
      // maskFrame();
      tint(255, opacity);
      printFrame();
    }
  }

  void getFrame () {
    video.read();
    currentFrame = video.get();
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
    translate(centerX, centerY);
    rotate(radians(currentDegrees));
    translate(-centerX, -centerY);  
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

  void printFrame () {
    image(currentFrame, centerX, centerY, scaledFrameWidth(), scaledFrameHeight());
  }

}