class BackgroundSubtract extends BaseSketch {

  Capture video;
  OpenCV opencv;
  PGraphics g;
  
  int h = 0;
  int s = 0;
  int b = 0;

  void setup(Capture video, OpenCV opencv, PGraphics g) {
    this.video = video;
    this.opencv = opencv;
    this.g = g;
    
    opencv.startBackgroundSubtraction(3, 3, 0.5);
    
    g.blendMode(SUBTRACT);
    g.colorMode(HSB, 360, 100, 100);
  }

  void draw() {
    if (video.available()) {
      video.read();
      g.background(0);
      g.image(video, 0, 0, width, height);
      
      opencv.loadImage(video);
      opencv.updateBackground();
      opencv.dilate();
      opencv.erode();
      opencv.erode();

      g.noFill();
      changeColor();
      g.stroke(h % 360, s % 100, b % 100);
      g.strokeWeight(1);
      for (Contour contour : opencv.findContours()) {
        if (contour.area() > 200) {
          Rectangle boundingBox = contour.getBoundingBox();
          float centerX = boundingBox.x + boundingBox.width / 2;
          float centerY = boundingBox.y + boundingBox.height / 2;
          float radius = (boundingBox.width + boundingBox.height) / 2;
          g.pushMatrix();
          g.scale ( (float)width / video.width, (float)height / video.height );
          drawContour(contour);
          g.ellipse(centerX, centerY, radius, radius);
          g.translate(video.width * 2, 0);
          drawContour(contour);
          g.ellipse(centerX, centerY, radius, radius);
          g.popMatrix();
        }
      }
    }
  }
  
  void drawContour(Contour c) {
    g.beginShape();
    for( PVector p : c.getPoints()) {
      g.vertex(p.x, p.y);
    }
    g.endShape(CLOSE);
  }

  void changeColor () {
    h += 1;
    s += 1;
    b = 99;
  }

}

