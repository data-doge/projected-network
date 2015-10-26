import processing.video.*;
import java.awt.*;

Capture video;
float numOfSteps = 1000;
float counter = numOfSteps;

void setup () {
  size(displayWidth, displayHeight);
  video = new Capture(this, width, height);
  video.start();
}

void draw () {
  if (video.available() == true) {
    video.read();
  
    if (counter > 0) {
      counter--;
    } else {
      counter = numOfSteps;
    }

    float scale = counter / numOfSteps;

    int scaledFrameWidth = (int)(scale * width);
    int scaledFrameHeight = (int)(scale * height);
    int newX = (width - scaledFrameWidth) / 2;
    int newY = (height - scaledFrameHeight) / 2;

    tint(255, 50);
    translate(width / 2, height / 2);
    rotate(radians(counter * 4));
    translate(-width / 2, -height / 2);
    image(video, newX, newY, scaledFrameWidth, scaledFrameHeight);
    
  }
}
