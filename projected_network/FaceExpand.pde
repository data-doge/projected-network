class FaceExpand extends BaseSketch {
  Capture video;
  OpenCV opencv;
  PGraphics g;
  float tileDepth = 10;
  
  void setup (Capture video, OpenCV opencv, PGraphics g) {
    this.video = video;
    this.opencv = opencv;
    this.g = g;
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  //  blendMode(SUBTRACT);
  }


  void draw() {
    if (video.available() == true) {
      video.read();
      opencv.loadImage(video);
      g.image(video, 0, 0);
      Rectangle[] faces = opencv.detect();
      copyFaces(faces, tileDepth);
    }
  }

  void copyFaces (Rectangle[] faces, float depth) {
    for (float i = depth; i > 0; i--) {
      for (int j = 0; j < faces.length; j++) {
        Rectangle face = faces[j];
        float scale = i / depth;
        copyFace(face, scale);
      }
    }
  }

  void copyFace (Rectangle face, float scale) {
    int scaledFaceWidth = (int)(scale * face.width);
    int scaledFaceHeight = (int)(scale * face.height);
    int newX = face.x + (face.width - scaledFaceWidth) / 2;
    int newY = face.y + (face.height - scaledFaceHeight) / 2;
    g.copy(video.get(), face.x, face.y, face.width, face.height, newX, newY, scaledFaceWidth, scaledFaceHeight);
  }

}
