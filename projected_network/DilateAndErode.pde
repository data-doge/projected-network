class DilateAndErode extends BaseSketch {

  Capture video;
  OpenCV opencv;
  PImage edges;

  void setup(Capture video, OpenCV opencv) {
    this.video = video;
    this.opencv = opencv;
    opencv.gray();
    opencv.threshold(100);
    opencv.invert();
  }

  void draw() {
    video.read();
    opencv.loadImage(video);
    opencv.findScharrEdges(OpenCV.HORIZONTAL);
    dilateAndErode(3);
    edges = opencv.getSnapshot();
    image(edges, 0, 0, width, height);
  }

  void dilateAndErode (int iterations) {
    for (int i = 0; i < iterations; i++) {
      opencv.dilate();
    }
    for (int i = 0; i < iterations; i++) {
      opencv.erode();
    }
  } 

}
