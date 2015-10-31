class BackgroundSubtract extends BaseSketch {

  Capture video;
  OpenCV opencv;
  int h = 0;
  int s = 0;
  int b = 0;

  void setup(Capture video, OpenCV opencv) {
    this.video = video;
    this.opencv = opencv;
    
    opencv.startBackgroundSubtraction(3, 3, 0.5);
    
    blendMode(SUBTRACT);
    colorMode(HSB, 360, 100, 100);
  }

  void draw() {
    if (video.available()) {
      video.read();
      background(0);
      image(video, 0, 0, width, height);
      
      opencv.loadImage(video);
      opencv.updateBackground();
      opencv.dilate();
      opencv.erode();
      opencv.erode();

      noFill();
      changeColor();
      stroke(h % 360, s % 100, b % 100);
      strokeWeight(1);
      for (Contour contour : opencv.findContours()) {
        if (contour.area() > 200) {
          Rectangle boundingBox = contour.getBoundingBox();
          float centerX = boundingBox.x + boundingBox.width / 2;
          float centerY = boundingBox.y + boundingBox.height / 2;
          float radius = (boundingBox.width + boundingBox.height) / 2;
          pushMatrix();
          scale ( (float)width / video.width, (float)height / video.height );
          contour.draw();
          ellipse(centerX, centerY, radius, radius);
          translate(video.width * 2, 0);
          contour.draw();
          ellipse(centerX, centerY, radius, radius);
          popMatrix();
        }
      }
    }
  }

  void changeColor () {
    h += 1;
    s += 1;
    b = 99;
  }

}

